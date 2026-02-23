```markdown
## Status: COMPLETE
# Specification: add-ascii-header

## Feature: Insert ASCII question-mark as the first output of `who_is_ralph.sh`

### Overview
Add a non-invasive header so the first output produced when running `scripts/who_is_ralph.sh` is the ASCII-art question mark. The header should be the first visible stdout content and should not remove or alter the existing content the script prints after startup.

### User Stories
- As a terminal user, I want to immediately see the ASCII question-mark at script start so I know it has begun.
- As a maintainer, I want the header to be clearly separated from existing script output and reversible.

---

## Functional Requirements

### FR-1: First-output header
The ASCII question-mark must appear as the first text printed to stdout when the script runs.

**Acceptance Criteria:**
- [ ] Running `scripts/who_is_ralph.sh` prints the ASCII question-mark as the first stdout lines.
- [ ] The original subsequent script output remains unchanged and follows the header.

### FR-2: Non-destructive change
The header addition must be reversible and documented; it should not modify or remove existing script files without explicit follow-up.

**Acceptance Criteria:**
- [ ] There is a clear, reversible change plan documented in the corresponding implementation spec (e.g., wrapper or optional inclusion).

---

## Success Criteria

- The script prints the ASCII question-mark first, then its original output.
- The addition is documented and can be reverted without loss of original behavior.

---

## Dependencies
- `specs/003-design-ascii-art.md` (artwork resource)
- `scripts/who_is_ralph.sh`

## Assumptions
- Users prefer a visible plaintext header and that printing text at script start is acceptable.

---

## Completion Signal

### Implementation Checklist
- [ ] Describe how the header will be included (resource reference) in implementation spec.
- [ ] Confirm run produces header followed by original output.

### Testing Requirements

Per user request, no automated tests are required for this change within this feature's spec.

### Iteration Instructions
If the header causes unexpected side-effects (timing-sensitive output), revise inclusion approach to ensure original behavior is preserved.

**Only when acceptance criteria are met, this spec is complete.**

```
