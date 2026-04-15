---
type: system
title: "Claude Code — Vault Usage Instructions"
updated: 2026-04-13
tags: [system, claude-code, instructions]
---

# How Claude Code Should Use This Vault

## Philosophy: Context > Retrieval

This vault replaces RAG. Instead of embedding + vector search, Claude Code reads relevant `.md` files directly. The files are small, interlinked, and structured with frontmatter — making them trivially parseable.

## Reading Strategy

1. **Start at `_MOC.md`** — the master index. Scan for the topic.
2. **Follow `[[wiki-links]]`** — every link is a real file in the vault.
3. **Use frontmatter** — `type`, `tags`, and `related` fields tell you what a note is and what it connects to.
4. **Check `status` fields** — some notes are templates (empty fields to fill), others are populated with live data.

## Answering Questions

| Question Type | Start Here |
|---|---|
| "What deal types does Canela support?" | `Deal Types/` folder |
| "What are the creative specs?" | [[Creative Guidelines]] |
| "How does PG differ from PMP?" | [[Programmatic Guaranteed (PG)]] vs [[Private Marketplace (PMP)]] |
| "What's the budget?" | [[FY25 Media Plan Projections]] |
| "Who's the tech contact?" | [[Admin & SLA]] |
| "What tracking is supported?" | [[Conversion Tracking]] + [[Measurement & Verification]] |
| "What targeting can we do?" | [[Targeting Capabilities]] |
| "How do I set up a new CTV campaign?" | [[Brief — CTV]] |

## Adding Knowledge

When new vendor intake forms arrive:
1. Create a new vendor note in `Vendors/`
2. Create deal-type notes in `Deal Types/`
3. Link everything back to `_MOC.md`
4. Use the same frontmatter schema (see [[_SCHEMA]])

## Conventions

- `[[double brackets]]` = Obsidian wiki-links (resolve to filenames)
- `#tags` in frontmatter = filterable in Obsidian
- `related:` frontmatter field = explicit graph edges
- `status: template` = empty form, not yet filled
- `status: active` = populated with real data
