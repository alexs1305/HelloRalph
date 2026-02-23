```markdown
# Specification: colorize-who-is-ralph-script

## Status: COMPLETE

## Feature: Colorize occurrences of 'Ralph' in who_is_ralph outputs

### Overview
Add a non-invasive feature that ensures every literal occurrence of the word "Ralph" in the stdout of the `who_is_ralph.sh` script is rendered in purple using ANSI terminal color codes, without modifying the original script file.

### User Stories
- As a terminal user, I want the name Ralph highlighted in purple so that it stands out in script output.
- As a maintainer, I want the original `who_is_ralph.sh` file to remain unchanged so changes are reversible and auditable.

---

## Functional Requirements

### FR-1: Non-invasive colorization wrapper
Provide a wrapper or output-filtering mechanism that intercepts the stdout of `who_is_ralph.sh` and replaces every exact, case-sensitive instance of "Ralph" with the same text wrapped in the ANSI purple color code and reset code.

**Acceptance Criteria:**
- [ ] A wrapper (e.g., `who_is_ralph.colorize.sh`) or equivalent is present and documented.
- [ ] Running the wrapper produces the same text as the original script, except each exact occurrence of "Ralph" is wrapped with ANSI purple (35) and reset codes.
- [ ] The original file `who_is_ralph.sh` is not modified by this task.
- [ ] Replacement is global across the entire output stream and is idempotent (running wrapper twice does not double-color already-colored text).

### FR-2: Portable, POSIX-compatible implementation
The solution must work on common Unix-like environments (macOS, Linux) using standard shell utilities or a small portable script.

**Acceptance Criteria:**
- [ ] The wrapper runs on macOS and a typical Linux environment without requiring non-standard binaries.
- [ ] The wrapper exits with the same exit code as the original `who_is_ralph.sh` script.

### FR-3: Tests and verification
Provide automated tests that verify colorization behavior and that the original script remains unchanged.

**Acceptance Criteria:**
- [ ] Unit/integration tests added under `tests/` (or project test layout) asserting that output contains the ANSI color sequence around every "Ralph" occurrence.
- [ ] A test verifies that the original `who_is_ralph.sh` file content is unchanged after running the wrapper.

---

## Success Criteria
- Every literal, case-sensitive occurrence of "Ralph" in `who_is_ralph.sh` output is colored purple when run via the wrapper.
- The original `who_is_ralph.sh` file remains byte-for-byte unchanged.
- Tests covering colorization and non-modification pass in CI.

- Wrapper exists and documented in repository README or `scripts/` directory.

---

## Dependencies
- `scripts/who_is_ralph.sh`
- POSIX shell and common utilities (`sed`, `awk`, `printf`, `sh`)
- CI runner that supports running shell scripts

## Assumptions
- Terminals used by target users support ANSI color codes.
- Matching is exact and case-sensitive (only "Ralph", not "ralph" or partial matches).
- The repository owner prefers a non-invasive wrapper rather than modifying the original script.

---

## Completion Signal

### Implementation Checklist
- [ ] Add wrapper script `scripts/who_is_ralph.colorize.sh` (or equivalent) that pipes `who_is_ralph.sh` output through a safe replacer.
- [ ] Add tests that verify coloring and non-modification.
- [ ] Add documentation in `README.md` or `scripts/` explaining how to run the colored output.

### Testing Requirements

The agent MUST complete ALL before outputting the magic phrase:

#### Code Quality
- [ ] All existing unit tests pass
- [ ] New tests added for the wrapper pass
- [ ] No lint errors in newly added shell scripts

#### Functional Verification
- [ ] All acceptance criteria verified
- [ ] Edge cases handled (no double-coloring, binary output preserved)
- [ ] Exit codes propagated correctly

#### Console/Network Check (if web)
- [ ] N/A

### Iteration Instructions
If ANY check fails:
1. Identify the specific issue
2. Fix the wrapper or tests
3. Run tests again
4. Verify all criteria
5. Commit and push
6. Check again

**Only when ALL checks pass, output:** `<promise>DONE</promise>`

```
