```markdown
# Specification: update-docs

## Status: COMPLETE

## Feature: Document ASCII header behavior and usage

### Overview
Document the presence and purpose of the ASCII question-mark header in repository documentation so users and maintainers understand what to expect when running `scripts/who_is_ralph.sh` and how to remove or update the header.

### User Stories
- As a user, I want to know that the script prints a startup header so I am not surprised by extra output.
- As a maintainer, I want instructions for locating and updating the ASCII artwork.

---

## Functional Requirements

### FR-1: README entry
Add a short section to the main `README.md` or `scripts/README.md` describing the header and showing example output.

**Acceptance Criteria:**
- [ ] `README.md` (or `scripts/README.md`) contains a section titled "Startup header" or similar describing the ASCII header.
- [ ] The docs include an example snippet showing the header as it appears when the script runs.

### FR-2: Maintenance notes
Provide a note on how to update or remove the header.

**Acceptance Criteria:**
- [ ] Documentation includes filepath for the ASCII artwork resource and steps for updating or removing it.

---

## Success Criteria

- Documentation clearly explains the header, shows example output, and provides maintenance instructions.

---

## Dependencies
- `specs/003-design-ascii-art.md`
- `specs/004-add-ascii-header.md`

## Assumptions
- Documentation readers will consult `README.md` for script behavior.

---

## Completion Signal

### Implementation Checklist
- [ ] Update `README.md` or create `scripts/README.md` with a "Startup header" section and example output.
- [ ] Include maintenance notes describing where to find and edit the ASCII art.

### Testing Requirements

Documentation changes should be verified by reading the rendered `README.md` in a Markdown viewer.

**Only when acceptance criteria are met, this spec is complete.**

```
