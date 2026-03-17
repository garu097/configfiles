---
description: Clean code via Prettier, Import Sorter, ESLint, TypeScript
---

# Code Cleanup

Clean code for production readiness.

## Scope
- With `$ARGUMENTS`: Clean specified files
- Without: Check git status for modified files

## Process

1. **Remove debug code** - console.log, debugger, commented-out code

2. **Format** - Run Prettier, consistent indentation

3. **Optimize imports** - Sort, remove unused, group by type

4. **Fix linting** - ESLint/TSLint auto-fixable issues

5. **Type check** - TypeScript compiler fixes

## Report

```markdown
## Cleanup Results
- Files: [list]
- Debug removed: [count]
- Imports optimized: [count]
- Lint fixed: [count]
- Type issues: [count]
```

Production ready = no debugging artifacts, consistent style, clean imports.
