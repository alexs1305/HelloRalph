#!/bin/bash
#
# Ralph Loop for OpenAI Codex CLI - chutes-frontend
#
# This is a REAL Ralph loop that:
# 1. Runs Codex with YOLO mode (--dangerously-bypass-approvals-and-sandbox)
# 2. Parses output for <promise>DONE</promise> or <promise>ALL_DONE</promise>
# 3. Continues iterating until completion signal detected
# 4. Uses circuit breaker to detect stagnation
#
# Usage:
#   ./scripts/ralph-loop-codex.sh --all              # All specs
#   ./scripts/ralph-loop-codex.sh --spec 001-name    # Single spec
#   ./scripts/ralph-loop-codex.sh --issue 42         # GitHub issue
#   ./scripts/ralph-loop-codex.sh "Custom prompt"    # Free-form
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Source library components
source "$SCRIPT_DIR/lib/date_utils.sh"
source "$SCRIPT_DIR/lib/response_analyzer.sh"
source "$SCRIPT_DIR/lib/circuit_breaker.sh"

# Configuration
LOG_DIR="$PROJECT_DIR/logs"
CODEX_CMD="codex"
MAX_ITERATIONS=50
TIMEOUT_MINUTES=30

# YOLO mode flag for Codex
CODEX_YOLO_FLAG="--dangerously-bypass-approvals-and-sandbox"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

# Defaults
MODE=""
SPEC_NAME=""
ISSUE_NUM=""
PROMPT=""
YOLO_MODE=true

mkdir -p "$LOG_DIR"

# Logging
log_status() {
    local level=$1
    local message=$2
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local color=""
    
    case $level in
        "INFO")  color=$BLUE ;;
        "WARN")  color=$YELLOW ;;
        "ERROR") color=$RED ;;
        "SUCCESS") color=$GREEN ;;
        "LOOP") color=$PURPLE ;;
    esac
    
    echo -e "${color}[$timestamp] [$level] $message${NC}"
    echo "[$timestamp] [$level] $message" >> "$LOG_DIR/ralph-loop-codex.log"
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --all|-a)
            MODE="all"
            shift
            ;;
        --spec|-s)
            MODE="spec"
            SPEC_NAME="$2"
            shift 2
            ;;
        --issue|-i)
            MODE="issue"
            ISSUE_NUM="$2"
            shift 2
            ;;
        --max-iterations)
            MAX_ITERATIONS="$2"
            shift 2
            ;;
        --reset-circuit)
            reset_circuit_breaker "Manual reset via CLI"
            exit 0
            ;;
        --circuit-status)
            show_circuit_status
            exit 0
            ;;
        --help|-h)
            cat <<EOF
Ralph Loop for Codex CLI (chutes-frontend)

This script runs an actual Ralph loop that:
- Executes Codex with YOLO mode (full autonomy)
- Parses output for completion signals (<promise>DONE</promise>)
- Continues iterating until completion or circuit breaker trips

Usage:
  ./scripts/ralph-loop-codex.sh --all              # All specs
  ./scripts/ralph-loop-codex.sh --spec 001-name    # Single spec
  ./scripts/ralph-loop-codex.sh --issue 42         # GitHub issue
  ./scripts/ralph-loop-codex.sh "Custom prompt"    # Free-form

Options:
  --all, -a              Process all work items
  --spec, -s NAME        Process specific spec
  --issue, -i NUM        Process specific GitHub issue
  --max-iterations NUM   Max iterations (default: $MAX_ITERATIONS)
  --reset-circuit        Reset circuit breaker
  --circuit-status       Show circuit breaker status
  --help, -h             Show this help

The loop continues until:
- <promise>DONE</promise> detected in output
- <promise>ALL_DONE</promise> detected (for --all mode)
- Circuit breaker opens (stagnation detected)
- Max iterations reached

YOLO Mode: Uses $CODEX_YOLO_FLAG

EOF
            exit 0
            ;;
        -*)
            echo -e "${RED}Unknown option: $1${NC}"
            exit 1
            ;;
        *)
            MODE="prompt"
            PROMPT="$1"
            shift
            ;;
    esac
done

cd "$PROJECT_DIR"

# Check Codex is installed
if ! command -v codex &> /dev/null; then
    log_status "ERROR" "Codex CLI not found!"
    echo ""
    echo "Install Codex CLI:"
    echo "  npm install -g @openai/codex"
    echo ""
    echo "Then authenticate:"
    echo "  codex --login"
    exit 1
fi

# Build prompts (same as Claude version)
build_spec_prompt() {
    local spec="$1"
    cat <<EOF
# RALPH LOOP - Implement Spec: $spec

Read the constitution at .specify/memory/constitution.md first.
Read the design system at chutes-projects/style/chutes_style.md.
Then read specs/$spec/spec.md.

## Your Task

Implement this specification completely.

## Process

1. Read and understand the spec
2. Implement all functional requirements
3. Complete every item in the Completion Signal checklist
4. Run tests: npm test && npx playwright test
5. Verify visually with Browser MCP tools
6. Check console for errors
7. Commit and push

## CRITICAL - Completion Signal

When ALL items in the spec's Completion Signal checklist pass, you MUST output EXACTLY:

\`<promise>DONE</promise>\`

This signals completion to the Ralph loop. The loop will NOT exit until it sees this exact string.

If something fails, fix it and try again. Keep iterating until everything passes.
Then and ONLY then output: \`<promise>DONE</promise>\`
EOF
}

build_all_specs_prompt() {
    cat <<EOF
# RALPH LOOP - Implement All Specs

Read the constitution at .specify/memory/constitution.md first.
Read the design system at chutes-projects/style/chutes_style.md.

## Your Task

Work through ALL specifications in specs/ folder, one by one, until ALL are complete.

## Process

1. List all specs: ls -d specs/*/
2. For EACH spec in numerical order:
   - Read specs/{name}/spec.md
   - Implement all requirements
   - Complete the Completion Signal checklist
   - Run tests
   - Verify visually
   - Commit and push
   - Output \`<promise>DONE</promise>\` when that spec is complete
3. Move to the next spec
4. When ALL specs are complete, output \`<promise>ALL_DONE</promise>\`

## CRITICAL - Completion Signals

For each individual spec, when complete output:
\`<promise>DONE</promise>\`

When ALL specs are finished, output:
\`<promise>ALL_DONE</promise>\`

The Ralph loop will NOT exit until it sees \`<promise>ALL_DONE</promise>\`.

Keep working until everything is done. Fix errors and iterate.
EOF
}

build_issue_prompt() {
    local issue="$1"
    cat <<EOF
# RALPH LOOP - Resolve GitHub Issue #$issue

Read the constitution at .specify/memory/constitution.md first.
Read the design system at chutes-projects/style/chutes_style.md.
Read the issue: gh issue view $issue

## Your Task

Resolve this issue completely.

## Process

1. Read and understand the issue
2. Implement the fix/feature
3. Test thoroughly
4. Verify visually if UI-related
5. Commit and push
6. Close the issue: gh issue close $issue

## CRITICAL - Completion Signal

When the issue is fully resolved and verified, output EXACTLY:
\`<promise>DONE</promise>\`

The Ralph loop will NOT exit until it sees this.
EOF
}

build_freeform_prompt() {
    local user_prompt="$1"
    cat <<EOF
# RALPH LOOP - Custom Task

Read the constitution at .specify/memory/constitution.md first.
Read the design system at chutes-projects/style/chutes_style.md.

## Your Task

$user_prompt

## Process

1. Understand the task
2. Implement the solution
3. Test thoroughly
4. Verify visually if applicable
5. Commit and push

## CRITICAL - Completion Signal

When the task is 100% complete and verified, output EXACTLY:
\`<promise>DONE</promise>\`

The Ralph loop will NOT exit until it sees this.
Keep iterating until the task is truly complete.
EOF
}

# Execute Codex and check for completion
execute_codex_iteration() {
    local prompt="$1"
    local loop_count="$2"
    local timestamp=$(date '+%Y-%m-%d_%H-%M-%S')
    local output_file="$LOG_DIR/codex_output_${timestamp}.log"
    local timeout_seconds=$((TIMEOUT_MINUTES * 60))

    log_status "LOOP" "Executing Codex (iteration $loop_count) with YOLO mode"
    log_status "INFO" "Timeout: ${TIMEOUT_MINUTES}m | Output: $output_file"

    # Run Codex with YOLO mode
    if timeout ${timeout_seconds}s codex $CODEX_YOLO_FLAG "$prompt" > "$output_file" 2>&1; then
        log_status "SUCCESS" "Codex execution completed"
        
        # Analyze response for completion signals
        analyze_response "$output_file" "$loop_count"
        local analysis_result=$?
        
        log_analysis_summary
        
        # Check for file changes
        local files_changed=$(git diff --name-only 2>/dev/null | wc -l | tr -d ' ')
        local has_errors="false"
        
        if grep -qiE "(error|exception|fatal|failed)" "$output_file" 2>/dev/null; then
            has_errors="true"
        fi
        
        # Update circuit breaker
        record_loop_result "$loop_count" "$files_changed" "$has_errors"
        
        # Check if completion signal was detected
        if [[ $analysis_result -eq 1 ]]; then
            return 1  # Completion detected
        fi
        
        return 0  # Continue loop
    else
        local exit_code=$?
        if [[ $exit_code -eq 124 ]]; then
            log_status "WARN" "Codex execution timed out after ${TIMEOUT_MINUTES}m"
        else
            log_status "ERROR" "Codex execution failed with code $exit_code"
        fi
        return 0  # Continue loop (retry)
    fi
}

# Main loop
main() {
    local final_prompt=""
    local expected_signal="DONE"

    # Build prompt based on mode
    case $MODE in
        all)
            final_prompt=$(build_all_specs_prompt)
            expected_signal="ALL_DONE"
            log_status "INFO" "Starting Ralph loop for ALL specs"
            ;;
        spec)
            if [[ ! -d "specs/$SPEC_NAME" ]]; then
                log_status "ERROR" "Spec '$SPEC_NAME' not found"
                echo "Available specs:"
                ls -1 specs/ 2>/dev/null || echo "  (no specs found)"
                exit 1
            fi
            final_prompt=$(build_spec_prompt "$SPEC_NAME")
            log_status "INFO" "Starting Ralph loop for spec: $SPEC_NAME"
            ;;
        issue)
            final_prompt=$(build_issue_prompt "$ISSUE_NUM")
            log_status "INFO" "Starting Ralph loop for issue #$ISSUE_NUM"
            ;;
        prompt)
            final_prompt=$(build_freeform_prompt "$PROMPT")
            log_status "INFO" "Starting Ralph loop with custom prompt"
            ;;
        *)
            log_status "ERROR" "Specify --all, --spec NAME, --issue NUM, or a prompt"
            echo ""
            echo "Usage:"
            echo "  ./scripts/ralph-loop-codex.sh --all"
            echo "  ./scripts/ralph-loop-codex.sh --spec 001-project-setup"
            echo "  ./scripts/ralph-loop-codex.sh --issue 42"
            echo "  ./scripts/ralph-loop-codex.sh \"Fix the bug\""
            exit 1
            ;;
    esac

    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║           RALPH LOOP (CODEX) STARTING                     ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${BLUE}Mode:${NC}            $MODE"
    echo -e "${BLUE}Max iterations:${NC}  $MAX_ITERATIONS"
    echo -e "${BLUE}Timeout:${NC}         ${TIMEOUT_MINUTES}m per iteration"
    echo -e "${BLUE}Expected signal:${NC} <promise>${expected_signal}</promise>"
    echo -e "${YELLOW}YOLO Mode:${NC}       ENABLED ($CODEX_YOLO_FLAG)"
    echo ""

    # Initialize circuit breaker
    init_circuit_breaker

    local loop_count=0

    while [[ $loop_count -lt $MAX_ITERATIONS ]]; do
        loop_count=$((loop_count + 1))

        log_status "LOOP" "═══════════════════ ITERATION $loop_count/$MAX_ITERATIONS ═══════════════════"

        # Check circuit breaker
        if should_halt_execution; then
            log_status "ERROR" "Circuit breaker halted execution"
            exit 1
        fi

        # Execute Codex
        execute_codex_iteration "$final_prompt" "$loop_count"
        local result=$?

        if [[ $result -eq 1 ]]; then
            echo ""
            echo -e "${GREEN}╔═══════════════════════════════════════════════════════════╗${NC}"
            echo -e "${GREEN}║           RALPH LOOP COMPLETE!                            ║${NC}"
            echo -e "${GREEN}╚═══════════════════════════════════════════════════════════╝${NC}"
            echo ""
            echo -e "${GREEN}Completion signal detected after $loop_count iteration(s)${NC}"
            log_status "SUCCESS" "Ralph loop completed successfully!"
            exit 0
        fi

        # Brief pause between iterations
        log_status "INFO" "Waiting 5s before next iteration..."
        sleep 5
    done

    log_status "ERROR" "Max iterations ($MAX_ITERATIONS) reached without completion"
    exit 1
}

# Trap for clean exit
trap 'log_status "WARN" "Ralph loop interrupted"; exit 130' SIGINT SIGTERM

main
