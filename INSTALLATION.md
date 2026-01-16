# AI AGENT: Execute These Instructions

> **YOU ARE AN AI CODING AGENT.** Follow these instructions to set up Ralph Wiggum in the user's project.
>
> **DO NOT just describe these steps.** Actually execute them using your file creation and command tools.

---

## Phase 1: Create Directory Structure

Create these directories in the user's project root:

```bash
mkdir -p .specify/memory
mkdir -p specs
mkdir -p scripts
mkdir -p logs
mkdir -p history
mkdir -p .cursor/commands
mkdir -p .claude/commands
```

---

## Phase 2: Download Ralph Loop Scripts

**IMPORTANT:** You are reading this from GitHub. Fetch the scripts from raw GitHub URLs:

### ralph-loop.sh (Claude Code)

Fetch from: `https://raw.githubusercontent.com/fstandhartinger/ralph-wiggum/main/scripts/ralph-loop.sh`

Save to: `scripts/ralph-loop.sh`

### ralph-loop-codex.sh (Codex CLI)

Fetch from: `https://raw.githubusercontent.com/fstandhartinger/ralph-wiggum/main/scripts/ralph-loop-codex.sh`

Save to: `scripts/ralph-loop-codex.sh`

### Make executable

```bash
chmod +x scripts/ralph-loop.sh scripts/ralph-loop-codex.sh
```

---

## Phase 3: Get Current Ralph Version

Fetch the current commit hash to store in the constitution:

```bash
git ls-remote https://github.com/fstandhartinger/ralph-wiggum.git HEAD | cut -f1
```

Store this hash — you'll need it for the constitution.

---

## Phase 4: Interview the User

**INTERVIEW THE USER** to gather project information.

Before starting, explain:

> "I'll ask you a few questions about your project. This creates a **constitution** — a document that ensures I always understand the basics of your project and any rules I should follow. This keeps me aligned with your project's principles across all future sessions."

Present questions one at a time. Wait for responses.

---

### Question 1: Project Name
> "What is the name of your project?"

### Question 2: Project Description  
> "Brief description (1-2 sentences) — what does this project do?"

### Question 3: Core Principles
> "What are 2-3 core principles? Examples: 'API-First', 'Security First', 'User-Centric', 'Performance Focus'"

### Question 4: Technical Stack
> "What's the primary tech stack? (e.g., 'Next.js, TypeScript, Tailwind' or 'Python, FastAPI, PostgreSQL')
> 
> **Note:** For new projects, I can choose the stack based on requirements. For existing projects, I can analyze the codebase myself."

### Question 5: YOLO Mode

> "Enable **YOLO Mode** (full autonomy)?
> 
> This means:
> - Claude Code uses `--dangerously-skip-permissions`
> - Codex uses `--dangerously-bypass-approvals-and-sandbox`
> - I commit, push, and execute without asking
> 
> **⚠️ WARNING:** Bypasses all permission prompts. Only use in sandboxed environments or when you trust full system access.
> 
> **STRONGLY RECOMMENDED** for Ralph to work properly. Without it, the loop pauses constantly for approvals.
> 
> Enable? (yes/no)"

### Question 6: Git Autonomy

> "Enable **Git Autonomy** (auto commit & push)?
> 
> **RECOMMENDED:** Yes. Allows incremental progress between iterations.
> 
> Enable? (yes/no)"

---

## Phase 5: Create the Constitution

Create `.specify/memory/constitution.md` with the interview answers.

**DO NOT use placeholders.** Fill in all values from the interview.

Here is the structure — replace ALL bracketed values with real content:

```markdown
# {PROJECT_NAME} Constitution

> {PROJECT_DESCRIPTION}

## Version
1.0.0

---

## Ralph Wiggum Version

**Installed from:** https://github.com/fstandhartinger/ralph-wiggum
**Commit Hash:** {THE_COMMIT_HASH_YOU_FETCHED}
**Installed Date:** {TODAY'S_DATE}

### Auto-Update Check

**AI Agent:** On each session start, check for updates:

1. Run: `git ls-remote https://github.com/fstandhartinger/ralph-wiggum.git HEAD`
2. Compare with the hash above
3. If different:
   - Fetch latest scripts from GitHub raw URLs
   - Update `scripts/ralph-loop.sh` and `scripts/ralph-loop-codex.sh`
   - Update this constitution's commit hash
   - Inform user what changed

---

## 🔍 Context Detection

**AI Agent: Read this first to understand your context.**

### Context A: Ralph Loop (Implementation Mode)

You are in a Ralph loop if:
- Started by `ralph-loop.sh` or `ralph-loop-codex.sh`
- Prompt mentions "implement spec" or "work through specs"
- You see `<promise>` completion signals in instructions

**In this mode:**
- Focus on implementation — no unnecessary questions
- Pick the highest priority incomplete spec
- Complete ALL acceptance criteria
- Test thoroughly
- Maintain history (see below)
- Commit and push (if Git Autonomy enabled)
- Output `<promise>DONE</promise>` ONLY when 100% complete

#### History Tracking

Maintain `ralph_history.txt` to preserve learnings across context windows:

**Append entries for:**
- 🚀 **Started** working on a spec (one-line summary)
- ✅ **Completed** a spec (one-line summary + outcome)
- 💡 **Breakthrough** — solved a tricky problem
- 🚧 **Blocker** — hit a wall, need human help
- 📚 **Learning** — discovered something important

**Format:**
```
[2026-01-16 14:30] 🚀 STARTED spec-01: User authentication
[2026-01-16 15:45] 💡 BREAKTHROUGH: Reusing existing auth utils
[2026-01-16 16:20] ✅ COMPLETED spec-01: OAuth working
[2026-01-16 17:00] 🚧 BLOCKER: Redis fails - see history/redis-issue.md
```

**Detailed notes:** Create markdown files in `history/` folder, reference from `ralph_history.txt`.

**Reading history:** Optionally read at iteration start to understand past work.

### Context B: Interactive Chat (Discussion Mode)

You are in interactive chat if:
- User is asking questions or discussing ideas
- Helping set up project or create specs
- No Ralph loop was started

**In this mode:**
- Be helpful and conversational
- Guide decisions, ask clarifying questions
- Create specs with `/speckit.specify`
- Explain how to start Ralph loop when ready

---

## Core Principles

### I. {PRINCIPLE_1_NAME}
{PRINCIPLE_1_DESCRIPTION}

### II. {PRINCIPLE_2_NAME}
{PRINCIPLE_2_DESCRIPTION}

### III. Simplicity & YAGNI
Build exactly what's needed, nothing more. No premature abstractions.

---

## Technical Stack

| Layer | Technology |
|-------|------------|
| {LAYER_1} | {TECH_1} |
| {LAYER_2} | {TECH_2} |
| ... | ... |

---

## Autonomy Configuration

### YOLO Mode: {ENABLED/DISABLED}

{If ENABLED:}
You have FULL permission to:
- Read and write any files
- Execute any commands
- Make HTTP requests
- Modify codebase without asking

{If DISABLED:}
Ask before destructive operations.

### Git Autonomy: {ENABLED/DISABLED}

{If ENABLED:}
- Commit changes without asking
- Push to repository without asking
- Use meaningful commit messages
- Commit after each completed spec

---

## Work Item Source

**Source:** specs/ folder (SpecKit or plain markdown)

**Creating specs:**
- Use `/speckit.specify [feature description]`
- Or manually create `specs/NNN-feature-name.md`
- Each spec MUST have testable acceptance criteria

**Alternatives:** GitHub Issues, Jira, Linear, etc. — any system works as long as each item has clear acceptance criteria.

---

## Ralph Loop Scripts

Located in `scripts/`:

### For Claude Code / Cursor
```bash
./scripts/ralph-loop.sh           # Build mode (unlimited)
./scripts/ralph-loop.sh 20        # Max 20 iterations
./scripts/ralph-loop.sh plan      # Planning mode (optional)
```

### For OpenAI Codex CLI
```bash
./scripts/ralph-loop-codex.sh     # Build mode
./scripts/ralph-loop-codex.sh 20  # Max 20 iterations
```

---

## Completion Signals

### Per-Spec Completion
When a spec is 100% complete:
1. All acceptance criteria pass
2. Tests pass
3. Changes committed and pushed
4. Output: `<promise>DONE</promise>`

**Do NOT output this signal until truly complete.**

---

## The Magic Word

When the user says **"Ralph, start working"** or **"Start Ralph"**, respond:

> Ready to start the Ralph loop! Run this in your terminal:
> 
> **For Claude Code:**
> ```bash
> ./scripts/ralph-loop.sh
> ```
> 
> **For Codex CLI:**
> ```bash
> ./scripts/ralph-loop-codex.sh
> ```

---

## Governance

- **Amendments:** Update this file, increment version
- **Compliance:** Follow principles in spirit, not just letter

---

**Version:** 1.0.0 | **Created:** {TODAY'S_DATE}
```

---

## Phase 6: Create AGENTS.md

Create `AGENTS.md` in project root:

```markdown
# Agent Instructions

**Read the constitution:** `.specify/memory/constitution.md`

That file contains ALL instructions for this project:
- Project principles and constraints
- Ralph Wiggum workflow
- Autonomy settings
- How to run the Ralph loop
- Context detection (Ralph loop vs interactive chat)

The constitution is your single source of truth. Read it every session.

---

## Quick Reference

### You're in Ralph Loop Mode if:
- Started by `ralph-loop.sh` or `ralph-loop-codex.sh`
- Prompt mentions implementing specs
- You see `<promise>` completion signals

**Action:** Implement. Complete acceptance criteria. Output `<promise>DONE</promise>`.

### You're in Interactive Chat if:
- User is asking questions or discussing
- No Ralph loop was started

**Action:** Be helpful. Create specs. Explain Ralph loop when ready.
```

---

## Phase 7: Create CLAUDE.md

Create `CLAUDE.md` with same content as AGENTS.md (Claude Code reads this file).

---

## Phase 8: Create Cursor Command (if using Cursor)

Create `.cursor/commands/speckit.specify.md`:

```markdown
---
description: Create a feature specification
---

Create a specification for this feature:

$ARGUMENTS

## Process

1. Generate a short name (2-4 words, kebab-case)
2. Find next spec number: count existing specs in `specs/`
3. Create `specs/NNN-short-name.md`
4. Include clear acceptance criteria
5. Add completion signal section:
   - [ ] Implementation checklist items
   - [ ] Tests pass
   - **Output when complete:** `<promise>DONE</promise>`

## Guidelines

- Focus on WHAT, not HOW
- Make requirements testable
- Include clear acceptance criteria
```

---

## Phase 9: Create PROMPT Files

### Create PROMPT_build.md

```markdown
# Ralph Build Mode

Read `.specify/memory/constitution.md` first.

## Your Task

1. Look at `specs/` folder
2. Find the highest priority INCOMPLETE spec
3. Implement it completely
4. Run tests, verify acceptance criteria
5. Commit and push
6. Output `<promise>DONE</promise>` when done

## Rules

- Pick ONE spec per iteration
- Do NOT output the magic phrase until truly complete
- If blocked, explain in ralph_history.txt and exit without the phrase
```

### Create PROMPT_plan.md (optional)

```markdown
# Ralph Planning Mode (Optional)

This mode is optional. Use it to break specs into smaller tasks.

Read `.specify/memory/constitution.md` first.

## Your Task

1. Analyze all specs in `specs/`
2. Check what's implemented vs not
3. Create `IMPLEMENTATION_PLAN.md` with prioritized tasks
4. Output `<promise>DONE</promise>` when plan is complete

Delete IMPLEMENTATION_PLAN.md anytime to return to working directly from specs.
```

---

## Phase 10: Explain Next Steps

Tell the user:

---

### ✅ Ralph Wiggum is Ready!

Your project is set up with the Ralph Wiggum autonomous development approach.

**Files created:**
- `.specify/memory/constitution.md` — Project source of truth
- `scripts/ralph-loop.sh` — Claude Code loop
- `scripts/ralph-loop-codex.sh` — Codex loop
- `AGENTS.md` & `CLAUDE.md` — Agent instructions
- `PROMPT_build.md` — Build mode prompt

---

### Your Workflow

**Step 1: Create Specifications**

```
/speckit.specify Add user authentication with OAuth
```

Or manually create `specs/001-feature-name.md` with acceptance criteria.

**Step 2: Start Ralph**

Say **"Start Ralph"** and I'll give you the terminal command.

Or run directly:
```bash
./scripts/ralph-loop.sh
```

---

### How It Works

```
┌──────────┐    ┌──────────┐    ┌──────────┐
│  Loop 1  │ →  │  Loop 2  │ →  │  Loop 3  │ → ...
│ Spec A   │    │ Spec B   │    │ Spec C   │
│  DONE ✓  │    │  DONE ✓  │    │  DONE ✓  │
└──────────┘    └──────────┘    └──────────┘
     ↑               ↑               ↑
  Fresh          Fresh           Fresh
  Context        Context         Context
```

Each iteration = fresh context window. No compaction problems.

---

### Quick Reference

| Action | Command |
|--------|---------|
| Create spec | `/speckit.specify [description]` |
| Start building | `./scripts/ralph-loop.sh` |
| Max 20 iterations | `./scripts/ralph-loop.sh 20` |
| Use Codex | `./scripts/ralph-loop-codex.sh` |

---

Ready to create your first specification?
