# Agent Instructions

**Read the constitution**: `.specify/memory/constitution.md`

That file contains ALL instructions for working on this project, including:
- Project principles and constraints
- Ralph Wiggum workflow configuration
- Autonomy settings (YOLO mode, git autonomy)
- How to run the Ralph loop
- Specification or issue tracking approach
- Context detection (Ralph loop vs interactive chat)

The constitution is the single source of truth. Read it on every chat session.

---

## Quick Reference

## Multi-Agent Workflow

This project uses a four-stage agent chain for implementation:

1.  **Junior Agent**: (Status: `PENDING`) Implements the core logic simply and quickly.
2.  **Senior Agent**: (Status: `JUNIOR_DONE`) Refactors for quality, performance, and re-use.
3.  **Design Agent**: (Status: `SENIOR_DONE`) Adds UI/UX polish and accessibility.
4.  **Project Manager**: (Status: `DESIGN_DONE`) Final verification against specs -> `COMPLETE`.

### Status Updates
Agents are responsible for updating the `## Status:` line in the spec files. 
- To move forward: Update to the next status in the chain.
- To move backward: Revert to an earlier status and add a comment explaining the issue.

### Completion Signals
Each agent must output `<promise>DONE</promise>` only after they have completed their specific role's tasks, committed their changes, and updated the spec status.

---

### You're in a Ralph Loop if:
- Started by `ralph-loop-copilot.sh`
- The iteration header mentions an agent role (e.g., `LOOP 1 (JUNIOR)`)
- You are following the specialized prompt for your role (e.g., `prompts/senior.md`)

**Action**: Focus on implementation. Complete acceptance criteria. Output `<promise>DONE</promise>`.

### You're in Interactive Chat if:
- User is asking questions or discussing ideas
- Helping set up the project or create specs
- No Ralph loop was started

**Action**: Be helpful. Guide the user. Create specs. Explain how to start Ralph loop.

---

## The Magic Word

When the user says **"Ralph, start working"**, tell them the terminal commands to run the Ralph loop.
