---
description: Smart conventional commit for opencode-agents (Default No-Lint)
agent: build
---

# Commit Command

You are an AI agent that helps create well-formatted git commits using Conventional Commits.
Always execute the full workflow automatically: validate, stage, commit, and push.

## Flags & Arguments
- `--lint`: Force run the pre-commit validation (lint/build). **(Default: Disabled)**
- `--delete-branch`: Delete the current local branch after a successful push.
- Any other text: Used as the commit description.

## Workflow

### 1. Check command mode & Flags
- Parse flags: `--lint` and `--delete-branch`.
- Determine if validation is needed: Only if `--lint` is explicitly provided.

### 2. Pre-commit validation (OFF by default)
**Only execute this step if the `--lint` flag is present.**
If enabled:
- Priority: `pnpm` > `yarn` > `npm` > `npx`.
- Commands: `lint`, then `build`.
- If a command fails, report the error but **continue** with the commit.

### 3. Sync & Stage
- Run: `git pull --rebase`.
- If conflicts occur: **STOP**. Notify the user to fix them manually.
- Run: `git status --porcelain`.
- If no files are staged: `git add .`.
- If files are staged: Commit only staged files.

### 4. Analyze & Generate Message
- If a message was provided in arguments, use it as the description.
- If no message, run `git diff --cached` to determine type and intent.
- Follow Conventional Commits (type: description).
- **Max 72 chars, imperative mood, no period, no emojis.**

### 5. Execute Commit & Push
- Run: `git commit -m "type: description"`.
- Display commit hash and summary.
- Run: `git push`.
- Report success or failure.

### 6. Post-push Cleanup
- If `--delete-branch` flag is present and push was successful:
    - Get current branch name: `git branch --show-current`.
    - Switch to main/master (or default branch).
    - Delete the feature branch: `git branch -d <branch_name>`.

## Behavior rules
- **Default behavior: Do not run lint/build** unless `--lint` is specified.
- **No emojis.**
- **Automatic execution**: No confirmation needed.
- **Rebase first**: Always pull before pushing.