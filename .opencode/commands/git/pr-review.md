---
description: Review PR changes and suggest improvements
---

# PR Review

Review PR changes:

!`git diff origin/main...HEAD`
!`git log --oneline origin/main...HEAD`

Check:
1. **Quality** - clean code, naming, no duplication, error handling
2. **Security** - no secrets, input validation
3. **Performance** - efficient algorithms
4. **Tests** - new tests, existing pass
5. **Docs** - comments, README

Provide actionable feedback with line references.
