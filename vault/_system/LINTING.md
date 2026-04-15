---
type: system
title: "Linting — Vault Health Checks"
updated: 2026-04-15
tags: [system, lint, health, ci]
status: active
---

# Linting the Second Brain

## Why

A knowledge vault rots the same way code rots: broken links, stale facts, orphan notes, two files disagreeing with each other. Without checks, Claude starts answering from contradictory sources and you stop trusting the brain.

Linting is the fix. It is CI/CD for the vault — a periodic health check that an LLM (or a script) runs across every note to catch rot before it spreads. Inspired by Karpathy's LLM Wiki pattern: pass the whole wiki through a model and ask *"what is inconsistent, outdated, or missing?"*

## How to run it

In the Claude Code Desktop chat, type:

```
/lint
```

or scoped to a subfolder:

```
/lint Operations/
```

Claude will:
1. Scan every `.md` for structural problems (broken `[[links]]`, missing frontmatter, schema violations, stale `updated` dates, orphans, duplicate titles, TODO markers).
2. Read the vault as a whole for semantic problems (contradictions, missing concepts, outdated info, coverage gaps, weak link-graph).
3. Write a full report to `vault/_system/lint-report.md`.
4. Print a 5-line summary in chat.

The lint command does **not** edit notes. Fixes are a separate action you (or Claude, on request) take afterward.

## What gets checked

### Structural (fast, deterministic)

| Check | Example failure |
|---|---|
| Broken wiki-links | `[[Brief — Audio]]` but no file exists |
| Missing frontmatter | Note has no `updated` field |
| Invalid frontmatter values | `type: partner` (not in schema) |
| Stale notes | `updated` older than 180 days |
| Orphans | Note not linked from anywhere |
| Duplicate titles | Two files titled "Canela Media" |
| TODO markers | `TODO: confirm CPM` left in body |

### Semantic (deeper, LLM-powered)

| Check | Example failure |
|---|---|
| Contradictions | One note says 3x/day freq cap, another says 6x/day |
| Missing concepts | "LiveRamp" mentioned 12 times but no LiveRamp note |
| Outdated info | FY25 projections referenced as current in FY27 |
| Coverage gaps | `_MOC.md` promises a note that doesn't exist |
| Weak link-graph | New vendor note with empty `related:` |

## Cadence

- **Before a major briefing** — run `/lint` to make sure Claude won't cite a contradiction.
- **After ingesting new data** — run `/lint` to surface missing concepts and weak links.
- **Weekly** — quick health check. A clean report = the brain is trustworthy.
- **Before merging a big change** — catches regressions in the knowledge graph.

## Severity levels

| Severity | Meaning |
|---|---|
| `clean` | Zero issues. |
| `minor` | Only stale dates, orphans, or TODOs — cosmetic. |
| `major` | Broken links, missing frontmatter, coverage gaps — will degrade answer quality. |
| `critical` | Contradictions or outdated facts Claude would cite as truth. Fix before using the vault for decisions. |

## Fixing issues

After running `/lint`, the fastest recovery is to ask Claude to fix the top N issues:

```
Read vault/_system/lint-report.md and fix the broken wiki-links section.
```

or

```
Read vault/_system/lint-report.md and resolve the frequency cap contradiction — confirm which value is current and update the other note.
```

Claude has full write access to vault files; the auto-sync will commit and push fixes within 5 minutes, so no git CLI is needed.

## Related

- [[_SCHEMA]] — the frontmatter schema the linter enforces
- [[_CLAUDE]] — how Claude Code reads this vault
- [[_MOC]] — the master index the linter uses to detect orphans
