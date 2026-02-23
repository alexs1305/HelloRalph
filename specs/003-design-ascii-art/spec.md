```markdown
## Status: COMPLETE
# Specification: design-ascii-art

## Feature: ASCII question-mark artwork for script header

### Overview
Create a large ASCII-art question mark suitable for terminal display that will be used as the visual header when `who_is_ralph.sh` runs. The artwork must be readable in typical terminal widths and encoded as plain text.

### User Stories
- As a terminal user, I want a clear visual indicator the script has started so I can immediately tell it's running.
- As a maintainer, I want the artwork to be a plain-text resource so it can be reviewed and updated without code changes.

---

## Functional Requirements

### FR-1: Readable ASCII design
Produce an ASCII-art question mark that is legible in standard monospaced terminals (minimum 80-column width) and does not rely on color or special Unicode glyphs.

**Acceptance Criteria:**
- [ ] The artwork displays as plain ASCII characters only (no multi-byte/Unicode glyphs).
- [ ] The artwork fits within 80 columns when rendered at normal terminal font sizes.

### FR-2: Text resource
Provide the artwork as a plain-text resource that can be embedded or included by scripts.

**Acceptance Criteria:**
- [ ] The repository contains a text file or inline resource with the exact ASCII artwork.
- [ ] The artwork file is UTF-8 encoded and contains only ASCII bytes.

---

## Success Criteria

- The ASCII question-mark art is available in the repo as a plain-text resource and renders correctly in an 80-column terminal.
- The artwork uses only ASCII characters and is no wider than 80 columns.

---

## Dependencies
- `scripts/who_is_ralph.sh` (for eventual inclusion)

## Assumptions
- Target terminals use monospaced fonts and support ASCII text display.

---

## Completion Signal

### Implementation Checklist
- [ ] Add the ASCII artwork resource to the repository under `scripts/` or `assets/`.
- [ ] Confirm the file is ASCII-only and fits 80 columns.

### Testing Requirements

The planning agent should not implement tests here; acceptance criteria are manually verifiable by rendering the file in a terminal.

### Iteration Instructions
If the artwork does not render correctly on common terminals, refine the ASCII art to reduce width or simplify characters.

**Only when acceptance criteria are met, this spec is complete.**

```
