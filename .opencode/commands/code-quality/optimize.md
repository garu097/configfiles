---
description: Analyze and optimize code for performance, security, and issues
---

# Code Optimization

Analyze code for performance, security, and potential issues.

## Scope
- With `$ARGUMENTS`: Analyze specified files/directories
- Without: Check git status, recent changes, open files

## Analysis

### Performance
- Algorithmic efficiency (O(n²), nested loops)
- Memory management (leaks, excessive allocations)
- I/O patterns (API calls, caching)
- Framework-specific (React re-renders, N+1 queries)

### Security
- Input validation (sanitization, injection)
- Authentication & authorization
- Sensitive data handling
- Dependency vulnerabilities

### Issues
- Error handling (missing try-catch, silent failures)
- Edge cases (null/undefined, empty arrays)
- Scalability (hard-coded limits)
- Maintainability (duplication, complexity)

## Output Format

```markdown
## Analysis Scope
Files: [list]
Languages: [list]

## Issues Found

### Critical (Fix Now)
- [Issue]: [Location] → [Solution]

### Important
- [Issue]: [Location] → [Solution]

### Minor
- [Issue]: [Location] → [Solution]

## Priority Fixes
1. [Most critical fix]
2. [Second priority]
3. [Third priority]
```

Focus on actual bottlenecks, not premature optimization. Prioritize measurable improvements.
