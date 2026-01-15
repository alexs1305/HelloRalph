# Ralph Wiggum

> Autonomous AI coding with spec-driven development

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 🤖 AI Agent: Read This First

**If you are an AI coding agent** that has been pointed to this repository, you MUST:

1. **Read and execute [INSTALLATION.md](INSTALLATION.md)** — It contains step-by-step instructions for setting up Ralph Wiggum in the user's project
2. **Interview the user** to create their project constitution
3. **Set up all required files** including bash scripts, slash commands, and config files
4. **Guide the user** through their first specification or issue backlog setup

**Do NOT just describe the process. Actually execute it.**

---

## For Humans

Tell your AI coding agent:

> "Set up Ralph Wiggum in this project using https://github.com/fstandhartinger/ralph-wiggum"

Your AI will:
1. Interview you about your project
2. Set up a constitution and workflow
3. Configure YOLO mode (recommended) for fully autonomous operation
4. Help you create specs or connect to your issue tracker
5. Show you how to start the Ralph loop

---

## What is Ralph Wiggum?

Ralph Wiggum is **fully autonomous AI-assisted software development**:

- 🔄 **Iterative self-correction** — AI works until acceptance criteria pass
- 📋 **Spec-driven** — Professional specifications guide the work
- 🤖 **YOLO mode** — No permission prompts, full autonomy
- 🔁 **Nested loops** — Outer loop manages backlog, inner loops implement each item

## How It Actually Works

The Ralph loop is a **real bash loop** that enforces completion:

```
┌───────────────────────────────────────────────────────────┐
│                    RALPH LOOP                             │
│                                                           │
│   ┌─────────────┐                                         │
│   │ Build Prompt │ ←── Spec or custom task                │
│   └──────┬──────┘                                         │
│          ▼                                                │
│   ┌────────────────────────┐                              │
│   │ Execute Claude/Codex   │ ←── --print captures output  │
│   └──────────┬─────────────┘                              │
│              ▼                                            │
│   ┌────────────────────────┐                              │
│   │ Parse Output for       │ ←── Looking for <promise>    │
│   │ Completion Signal      │                              │
│   └──────────┬─────────────┘                              │
│              ▼                                            │
│        ┌───────────┐                                      │
│        │ Found     │──YES──▶ EXIT with success            │
│        │ <promise> │                                      │
│        │ DONE?     │                                      │
│        └─────┬─────┘                                      │
│              │ NO                                         │
│              ▼                                            │
│        ┌───────────┐                                      │
│        │ Circuit   │──OPEN──▶ EXIT (stagnation)           │
│        │ Breaker?  │                                      │
│        └─────┬─────┘                                      │
│              │ CLOSED                                     │
│              ▼                                            │
│        Loop back to Execute                               │
└───────────────────────────────────────────────────────────┘
```

**Key enforcement**: The loop will NOT exit until it sees `<promise>DONE</promise>` in the AI's output.

## Completion Signals

The AI must output one of these exact strings to exit the loop:

- `<promise>DONE</promise>` — Single task/spec complete
- `<promise>ALL_DONE</promise>` — All tasks/specs complete

## Circuit Breaker

Prevents infinite loops by detecting stagnation:

- **CLOSED**: Normal operation, progress being made
- **HALF_OPEN**: Warning (2 loops without file changes)
- **OPEN**: Halted (5+ loops without progress)

## Usage

```bash
# All specs
./scripts/ralph-loop.sh --all           # Claude Code
./scripts/ralph-loop-codex.sh --all     # Codex CLI (YOLO mode)

# Single spec
./scripts/ralph-loop.sh --spec 001-project-setup

# Custom task
./scripts/ralph-loop.sh "Fix the login bug"

# Utilities
./scripts/ralph-loop.sh --reset-circuit    # Reset circuit breaker
./scripts/ralph-loop.sh --circuit-status   # Show circuit breaker status
```

## Supported Platforms

| Platform    | Script                          | YOLO Flag                                    |
|-------------|---------------------------------|----------------------------------------------|
| Claude Code | `./scripts/ralph-loop.sh`       | `--print` mode for output capture            |
| Codex CLI   | `./scripts/ralph-loop-codex.sh` | `--dangerously-bypass-approvals-and-sandbox` |
| Cursor      | `/speckit.implement`            | Interactive mode                             |

## Credits

Built upon:
- [Ralph Wiggum technique](https://awesomeclaude.ai/ralph-wiggum) by the Claude community
- [How to Ralph Wiggum](https://github.com/ghuntley/how-to-ralph-wiggum) by Geoffrey Huntley
- [ralph-claude-code](https://github.com/frankbria/ralph-claude-code) by frankbria
- [SpecKit](https://github.com/github/spec-kit) by GitHub

## License

MIT License - See [LICENSE](LICENSE) for details.

---

**Website**: [ralph-wiggum-web.onrender.com](https://ralph-wiggum-web.onrender.com)
