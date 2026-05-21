---
name: git-summary
description: Summarize the current Git repository status — branch, latest commit, and modified files. Trigger when the user asks about "git status" or "branch status".
---

# Git Summary

Analyze the context below and provide the user with a concise 3-line summary.

## Context

Branch: !`git branch --show-current`

Latest commit:
!`git log -1 --pretty=format:'%h %s (%an, %ar)'`

Modified files:
!`git status --short`

## Requirements

Return to the user:

1. Current branch name
2. One-line summary of the latest commit
3. Number of modified files (if any)
