---
description: Run a health-check on the Second Brain vault — catches broken links, stale notes, contradictions, missing concepts, and schema violations.
---

# /lint — Second Brain Health Check

You are running the vault linter. This is CI/CD for the knowledge base: catch rot before it spreads. Run all phases in order. Be thorough but concise.

## Phase 1 — Structural checks (deterministic, use Grep/Glob/Read)

Scan every `.md` file under `vault/` and flag:

1. **Broken wiki-links** — any `[[Target]]` whose `Target.md` does not exist anywhere in the vault. List source file → missing target.
2. **Missing frontmatter fields** — per `vault/_system/_SCHEMA.md`, every note must have `type`, `title`, `updated`, `tags`, `status`. Flag notes missing any.
3. **Invalid frontmatter values** — `type` must be one of: vendor, client, deal, brief, projection, operations, creative, moc, system. `status` must be one of: active, template, archived.
4. **Stale `updated` dates** — anything older than 180 days from today. List with age.
5. **Orphans** — notes not referenced by `[[...]]` from any other note, AND not reachable from `vault/_MOC.md`. Exclude `_system/` and `_MOC.md` itself.
6. **Duplicate titles** — two files with the same `title:` frontmatter value.
7. **TODO/FIXME markers** — any note containing `TODO`, `FIXME`, or `<!-- placeholder -->`.

## Phase 2 — Semantic checks (LLM reasoning)

Read the vault as a whole and flag:

1. **Contradictions** — any two notes that state conflicting facts (e.g., one says frequency cap is 3x/day, another says 6x/day). Quote both sources.
2. **Missing concepts** — terms, products, acronyms, or contacts mentioned in one note but without a dedicated note of their own. Suggest a filename to create.
3. **Outdated info** — data tied to past dates (e.g., "FY25 projections" when today is FY27), past contacts, deprecated products.
4. **Coverage gaps** — topics the `_MOC.md` promises but no note covers, or topics clearly relevant to the client/vendor but absent.
5. **Link-graph weak spots** — clusters of notes that should interlink but don't (e.g., a new vendor note with no `related:` entries).

## Phase 3 — Report

Write the output to `vault/_system/lint-report.md` using this exact template:

```markdown
---
type: system
title: "Lint Report"
updated: <today YYYY-MM-DD>
tags: [system, lint, health]
status: active
---

# Lint Report — <today>

**Files scanned:** <N>  **Issues found:** <N>  **Severity:** <clean | minor | major | critical>

## Structural

### Broken wiki-links (<N>)
- `source.md` → `[[Missing Target]]`

### Missing/invalid frontmatter (<N>)
- `path/note.md` — missing: `updated`, `tags`

### Stale notes (<N>)
- `path/note.md` — last updated 2025-09-01 (221 days)

### Orphans (<N>)
- `path/note.md`

### Duplicate titles (<N>)
- `a.md` and `b.md` both titled "Foo"

### TODO/FIXME (<N>)
- `path/note.md:42` — TODO: confirm CPM

## Semantic

### Contradictions (<N>)
- **Frequency cap** — `Programmatic RFI 26-27.md` says 3x/day; `CTV Vetting Q&A.md` says 6x/day. Reconcile per deal type.

### Missing concepts (<N>)
- **LiveRamp** referenced in `Targeting Capabilities.md` but no note exists. Suggest: `Operations/LiveRamp.md`.

### Outdated info (<N>)
- `FY25 Media Plan Projections.md` — FY25 ended; either archive or add FY26/FY27 counterparts.

### Coverage gaps (<N>)
- `_MOC.md` lists `[[Brief — Audio]]` but no file exists.

### Weak link-graph (<N>)
- `Vendors/Canela Media.md` has no `related:` entries despite being referenced by 8 other notes.

## Recommended next actions
1. Fix top 3 critical issues (list filenames).
2. Add missing notes (list).
3. Refresh stale notes (list).
```

If there are zero issues in a section, write `_none_` under it. Do not fabricate issues to fill sections.

## Phase 4 — Summary to user

After writing the report, print a 5-line summary in chat:

```
Lint complete. <N> issues found (<N> structural, <N> semantic).
Top issue: <one sentence>.
Full report: vault/_system/lint-report.md
Severity: <clean | minor | major | critical>
Run /lint again after fixes.
```

## Rules

- Do not modify any vault note during linting — report only. Fixes are a separate user action.
- Do not delete or overwrite an existing lint-report.md without writing the new one in its place.
- If the user passed an argument (e.g., `/lint Vendors/`), scope the scan to that subpath only.
- Keep the report under 500 lines. If issues exceed that, list top 50 per section and append `... +N more`.
