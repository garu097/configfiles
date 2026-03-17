---
description: Analyze codebase for patterns and similar implementations
---

# Analyze Patterns

Find recurring patterns and refactoring opportunities in codebase.

## Usage
```
/analyze-patterns [--pattern=<regex>] [--language=<lang>] [--depth=shallow|medium|deep]
```

## Analysis

Search for:
- **Patterns**: singleton, factory, observer, error-handling, middleware
- **Duplication**: similar implementations across files
- **Inconsistencies**: style differences, naming variations

## Output

```markdown
# Pattern: [name]
Occurrences: [count]
Files: [list]

## Implementations
1. [file:line] - [description] (similarity: X%)

## Suggestions
- [refactoring opportunity]
```

Focus on actionable refactoring suggestions.
