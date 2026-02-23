# HelloRalph Constitution

> The project should aim at being a small runnable script that informs the user who ralph is

---

## Context Detection

**Ralph Loop Mode** (started by ralph-loop*.sh):
- Pick highest priority incomplete spec from `specs/`
- Implement, test, commit, push
- Output `<promise>DONE</promise>` only when 100% complete
- Output `<promise>ALL_DONE</promise>` when no work remains

**Interactive Mode** (normal conversation):
- Be helpful, guide decisions, create specs

---

## Core Principles

- Keep it simple
- Move fast
- Maximum code re-use, do not repeat yourself

---

## Technical Stack

Detected from codebase

---

## Autonomy

YOLO Mode: ENABLED
Git Autonomy: ENABLED

---

## Status Workflow

Specs live in `specs/` and follow a multi-agent progression:

1.  `## Status: PENDING` - Ready for the **Junior Agent**.
2.  `## Status: JUNIOR_DONE` - Ready for the **Senior Agent**.
3.  `## Status: SENIOR_DONE` - Ready for the **Design Agent**.
4.  `## Status: DESIGN_DONE` - Ready for the **Project Manager Agent**.
5.  `## Status: COMPLETE` - Task is finished.

Any agent can move a status **backwards** (e.g., from `SENIOR_DONE` to `PENDING`) if they find issues. They must leave a comment explaining why.

---

## Agent Roles

- **Junior Agent**: Focuses on speed and simplicity. Implements the core logic using the most straightforward approach.
- **Senior Agent**: Focuses on code quality, performance, and re-use. Refactors junior code and ensures best practices.
- **Design Agent**: Focuses on UI/UX, accessibility, and visual polish.
- **Project Manager**: Verifies that the implementation meets all acceptance criteria and marks the task as `COMPLETE`.

---

## Specs

Specs live in `specs/` as markdown files. Pick the highest priority incomplete spec (lower number = higher priority). A spec is incomplete if it lacks `## Status: COMPLETE`.

---

## NR_OF_TRIES

Track attempts per spec via `<!-- NR_OF_TRIES: N -->` at the bottom of the spec file. Increment each attempt. At 10+, the spec is too hard — split it into smaller specs.

---

## History

Append a 1-line summary to `history.md` after each spec completion. For details, create `history/YYYY-MM-DD--spec-name.md` with lessons learned, decisions made, and issues encountered.

---

## Completion Signal

All acceptance criteria verified, tests pass, changes committed and pushed → output `<promise>DONE</promise>`. Never output this until truly complete.

---

## Metadata

- Ralph Wiggum upstream commit: `6022995317363dc3dba3aa0100dc3e40ed83dfff`
- Local workspace commit: `6022995`
