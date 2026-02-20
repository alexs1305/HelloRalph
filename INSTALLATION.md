# AI Agent: Ralph Wiggum Setup

> **You're an AI coding agent.** Follow these instructions to set up Ralph Wiggum.
>
> **Actually execute these steps** — don't just describe them.

---

## Overview: What You'll Do

1. **Quick Setup** — Create directories and download scripts (1 minute)
2. **Project Interview** — Learn about the user's project vision (3-5 minutes)
3. **Constitution** — Create the project's guiding document
4. **Next Steps** — Explain how to create specs and start Ralph

The goal: Make this feel **lightweight, pleasant, and professional**. Focus on understanding the *project*, not interrogating about technical minutiae.

---

## Phase 1: Create Structure

```bash
mkdir -p .specify/memory specs scripts logs history .cursor/commands .claude/commands
```

---

## Phase 2: Download Scripts

Fetch from GitHub raw URLs:

| Script | URL | Save To |
|--------|-----|---------|
| ralph-loop.sh | `https://raw.githubusercontent.com/fstandhartinger/ralph-wiggum/main/scripts/ralph-loop.sh` | `scripts/ralph-loop.sh` |
| ralph-loop-codex.sh | `https://raw.githubusercontent.com/fstandhartinger/ralph-wiggum/main/scripts/ralph-loop-codex.sh` | `scripts/ralph-loop-codex.sh` |
| ralph-loop-gemini.sh | `https://raw.githubusercontent.com/fstandhartinger/ralph-wiggum/main/scripts/ralph-loop-gemini.sh` | `scripts/ralph-loop-gemini.sh` |
| ralph-loop-copilot.sh | `https://raw.githubusercontent.com/fstandhartinger/ralph-wiggum/main/scripts/ralph-loop-copilot.sh` | `scripts/ralph-loop-copilot.sh` |

```bash
chmod +x scripts/ralph-loop*.sh
```

---

## Phase 3: Get Version Info

```bash
git ls-remote https://github.com/fstandhartinger/ralph-wiggum.git HEAD | cut -f1
```

Store the commit hash for the constitution.

---

## Phase 4: Project Interview

### Introduction

Start with a warm, brief introduction:

> "I'll ask a few quick questions to understand your project. This creates a **constitution** — a short document that helps me stay aligned with your goals across all future sessions.
>
> Don't worry about getting everything perfect — we can always refine it later."

### The Questions

Present these conversationally, one at a time. **Keep it lightweight.**

---

#### 1. Project Name
> "What's the name of your project?"

---

#### 2. Project Vision (MOST IMPORTANT)

> "Tell me about your project — what is it, what problem does it solve, who is it for?
>
> This is the most important question. The more I understand your vision, the better I can help build it."

**Note to AI:** This is the heart of the interview. Encourage the user to share context. A few sentences to a paragraph is ideal. This understanding guides everything.

---

#### 3. Core Principles

> "What 2-3 principles should guide development? Think about what matters most.
>
> Examples: 'User experience first', 'Keep it simple', 'Security above all', 'Move fast', 'Quality over speed'"

**Note to AI:** If the user struggles, offer to suggest principles based on their project description.

---

#### 4. Technical Stack (OPTIONAL)

> "What's the tech stack? (Or should I figure it out from the codebase?)
>
> For existing projects, I can usually detect this automatically. For new projects, I can suggest a stack based on your requirements."

**Note to AI:** This is **optional**. For existing projects, you should analyze the codebase yourself (check package.json, requirements.txt, go.mod, Cargo.toml, etc.). For new projects, you can recommend a stack. Don't pressure the user to specify every detail.

---

#### 5. Autonomy Settings

Present these together as a quick setup:

> "Two quick settings for how Ralph operates:
>
> **YOLO Mode** (recommended for smooth operation):
> Allows me to execute commands, modify files, and run tests without asking permission each time. This is what makes the autonomous loop work smoothly.
>
> **Git Autonomy** (recommended):
> Allows me to commit and push changes automatically after completing each spec.
>
> Enable both? (yes/no) — You can change these anytime."

**Note to AI:** Default to YES for both if the user seems agreeable. The loop works poorly without these.

---

#### 6. Optional Features

Present these as a quick checklist. Each is independent — the user can pick any combination.

> "Ralph has a few optional features. Quick yes/no for each:"

**a) Telegram Notifications** — Get progress updates (spec completions, failures) sent to a Telegram chat.

> "Want Telegram notifications when specs are completed or the loop gets stuck? (yes/no)"

If yes, ask for:
- `TG_BOT_TOKEN` — Telegram bot token (create via @BotFather)
- `TG_CHAT_ID` — Chat ID to send messages to

**Note to AI:** Tell the user to set these as environment variables. Do NOT put tokens directly in the constitution. The constitution should reference the env vars.

**b) GitHub Issues Integration** — Work on GitHub issues in addition to specs.

> "Should Ralph also pick up work from GitHub Issues? (yes/no)"

If yes, ask for:
- Repository (e.g. `owner/repo`)
- Whether issues need approval before work starts (recommended — ask who the approver is)

**c) NR_OF_TRIES Tracking** (recommended) — Track how many times each spec is attempted. After 10 failed attempts, the spec is flagged as "stuck" and should be split.

> "Enable attempt tracking? This prevents the loop from getting stuck on one hard spec forever. (yes/no, recommended: yes)"

**d) Completion Logs** — Create a visual history of completed work in `completion_log/` with summaries and optional mermaid diagrams.

> "Want to keep a completion log with summaries of finished specs? (yes/no)"

---

### Interview Complete

Thank the user briefly and move on:

> "That's all I need. Let me set up your project..."

---

## Phase 5: Create Constitution

Create `.specify/memory/constitution.md` using the interview answers.

**Template** (fill in ALL bracketed values, include optional sections only if user opted in):

```markdown
# {PROJECT_NAME} Constitution

> {PROJECT_VISION — paste their description here}

---

## Ralph Wiggum

**Source:** https://github.com/fstandhartinger/ralph-wiggum
**Commit:** {COMMIT_HASH}
**Installed:** {TODAY_DATE}

---

## Context Detection

**Ralph Loop Mode** (you're in this if started by ralph-loop*.sh):
- Focus on implementation — no unnecessary questions
- Pick highest priority incomplete spec from `specs/`
- Complete ALL acceptance criteria
- Test thoroughly
- Commit and push
- Output `<promise>DONE</promise>` ONLY when 100% complete
- Output `<promise>ALL_DONE</promise>` when all work items are finished

**Interactive Mode** (normal conversation):
- Be helpful and conversational
- Guide decisions, create specs
- When user says "Ralph, start working", tell them to run the appropriate script

---

## Core Principles

### I. {PRINCIPLE_1}
{Brief description if provided}

### II. {PRINCIPLE_2}
{Brief description if provided}

### III. Simplicity
Build exactly what's needed, nothing more.

---

## Technical Stack

{Either list what user provided OR write: "Detected from codebase" and list what you found}

---

## Autonomy

**YOLO Mode:** {ENABLED/DISABLED}
{If enabled: Full permission to read/write files, execute commands, make HTTP requests}

**Git Autonomy:** {ENABLED/DISABLED}
{If enabled: Commit and push without asking, meaningful commit messages}

---

## Work Items

Specs live in the `specs/` folder (project root). Each spec is a markdown file.

The agent discovers work dynamically from:
1. **specs/ folder** — Primary source, look for `.md` files NOT marked `## Status: COMPLETE`
2. **IMPLEMENTATION_PLAN.md** — If it exists, find unchecked tasks

Pick the **highest priority** incomplete item (lower numbers = higher priority).

Create specs using `/speckit.specify [description]` or manually create `specs/NNN-feature-name.md`.
Each spec MUST have **testable acceptance criteria**.

### Re-Verification Mode

When all specs appear complete, do a quality check:
1. Randomly pick a completed spec
2. Strictly re-verify ALL acceptance criteria
3. Fix any regressions found
4. Only output `<promise>DONE</promise>` if quality confirmed

---

## Completion Signal

When a spec is 100% complete:
1. All acceptance criteria verified
2. Tests pass
3. Changes committed and pushed
4. Output: `<promise>DONE</promise>`

**Never output this until truly complete.**

---

## Running Ralph

```bash
./scripts/ralph-loop.sh              # Claude Code (unlimited)
./scripts/ralph-loop.sh 20           # Claude Code (max 20 iterations)
./scripts/ralph-loop-codex.sh        # OpenAI Codex
./scripts/ralph-loop-gemini.sh       # Google Gemini
./scripts/ralph-loop-copilot.sh      # GitHub Copilot
```
```

### Optional Constitution Sections

**Include each section below ONLY if the user opted in during the interview.**

#### If Telegram Notifications: YES

Add this section to the constitution:

```markdown
---

## Telegram Notifications

Send progress updates via Telegram. Use env vars `TG_BOT_TOKEN` and `TG_CHAT_ID`.

After completing a spec, send a summary:
```bash
curl -s -X POST "https://api.telegram.org/bot$TG_BOT_TOKEN/sendMessage" \
  -d chat_id="$TG_CHAT_ID" -d parse_mode=Markdown \
  -d text="✅ *Completed:* {spec name}%0A{brief summary}"
```

Also notify on: 3+ consecutive failures, stuck specs, loop start/finish.
```

#### If GitHub Issues Integration: YES

Add this section to the constitution:

```markdown
---

## GitHub Issues Integration

Work on GitHub issues from `{OWNER/REPO}` in addition to specs.

```bash
gh issue list --repo {OWNER/REPO} --state open
gh issue view <number> --repo {OWNER/REPO} --json title,body,comments
gh issue close <number> --repo {OWNER/REPO}
```

{If approval required: Only work on issues where **{APPROVER}** has commented "approved".}
```

#### If NR_OF_TRIES Tracking: YES

Add this section to the constitution:

```markdown
---

## NR_OF_TRIES Tracking

Track attempts on each spec via a comment at the bottom of the spec file:
`<!-- NR_OF_TRIES: N -->`

Increment on each attempt. If NR_OF_TRIES >= 10, the spec is too hard or too big — split it into smaller specs and mark the original as superseded.

Check `history/` for lessons learned from previous attempts before starting work.
```

#### If Completion Logs: YES

Add this section to the constitution:

```markdown
---

## Completion Logs

After completing a spec, create an entry in `completion_log/`:
- `YYYY-MM-DD--HH-MM-SS--spec-name.md` — Summary of what was built

Keep entries concise. This provides a visual history across agent sessions.
```

---

## Phase 6: Create Agent Entry Files

### AGENTS.md (project root)

```markdown
# Agent Instructions

**Read:** `.specify/memory/constitution.md`

That file is your source of truth for this project.
```

### CLAUDE.md (project root)

Same content as AGENTS.md.

---

## Phase 7: Create Cursor Command

Create `.cursor/commands/speckit.specify.md`:

```markdown
---
description: Create a feature specification
---

Create a specification for:

$ARGUMENTS

## Steps

1. Generate short name (2-4 words, kebab-case)
2. Find next spec number from `specs/`
3. Create `specs/NNN-short-name.md`
4. Include clear acceptance criteria
5. Add completion signal:
   ```
   **Output when complete:** `<promise>DONE</promise>`
   ```
```

---

## Phase 8: Explain Next Steps

Present this clearly to the user:

---

### Ralph Wiggum is Ready!

Here's what was created:

| File | Purpose |
|------|---------|
| `.specify/memory/constitution.md` | Your project's guiding document |
| `scripts/ralph-loop*.sh` | The autonomous build loops |
| `AGENTS.md` / `CLAUDE.md` | Entry points for AI agents |

---

### How to Use Ralph

**Step 1: Create Specifications**

Tell me what you want to build:

```
"Create a spec for user authentication with OAuth"
```

Or use the Cursor command:
```
/speckit.specify user authentication with OAuth
```

Each spec needs **clear acceptance criteria** — specific, testable requirements that define "done."

**Step 2: Start the Loop**

Once you have specs, run:

```bash
./scripts/ralph-loop.sh
```

Ralph will pick specs, implement them, verify acceptance criteria, commit, push, and move to the next spec — all autonomously.

---

### Quick Reference

| Task | Command |
|------|---------|
| Create spec | Tell me or `/speckit.specify [feature]` |
| Start building | `./scripts/ralph-loop.sh` |
| Use Codex | `./scripts/ralph-loop-codex.sh` |
| Use Gemini | `./scripts/ralph-loop-gemini.sh` |
| Use Copilot | `./scripts/ralph-loop-copilot.sh` |
| Limit iterations | `./scripts/ralph-loop.sh 20` |

---

Ready to create your first specification?
