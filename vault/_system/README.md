---
type: system
title: "README — Setup Guide"
updated: 2026-04-13
tags: [system, setup, readme]
---

# Second Brain MVP — Setup Guide

## What This Is

A **zero-RAG knowledge vault** for media planning operations. Instead of embedding documents into vector databases, this vault stores structured knowledge as interlinked Markdown files that Claude Code reads directly as context.

## Why This Beats RAG

| RAG | This Vault |
|-----|-----------|
| Embedding + vector search | Direct file read |
| Lossy retrieval | Lossless context |
| Needs infrastructure | Just a folder |
| Chunks lose context | Full documents with links |
| No visualization | Obsidian graph view |
| Hard to edit | Edit any `.md` file |
| Opaque relevance | Explicit `[[links]]` + `tags` |

## Setup

### 1. Obsidian

1. Download [Obsidian](https://obsidian.md)
2. Open this folder as a vault: `File → Open folder as vault`
3. Enable **Graph View** (Core plugin, on by default)
4. Recommended community plugins:
   - **Dataview** — query frontmatter across notes
   - **Tag Wrangler** — manage tags at scale
   - **Templater** — auto-fill brief templates

### 2. Claude Code

Point Claude Code at this vault directory. When asking questions:

```bash
# Example: Ask Claude Code about the vault
claude "Read the files in ./vault/ and tell me: what deal types does Canela Media support?"
```

Claude Code will:
1. Read `_MOC.md` to orient itself
2. Follow links to `Deal Types/` folder
3. Read both PG and PMP notes
4. Synthesize an answer with full context

### 3. Adding New Vendors

1. Copy the intake form data into a new vendor note in `Vendors/`
2. Create deal-type notes in `Deal Types/` if new types
3. Update operational notes if specs differ
4. Add the vendor to `_MOC.md`
5. Link everything with `[[wiki-links]]`

## Vault Structure

```
vault/
├── _MOC.md                          ← Start here
├── _system/
│   ├── _CLAUDE.md                   ← Claude Code instructions
│   ├── _SCHEMA.md                   ← Frontmatter reference
│   └── README.md                    ← This file
├── Clients/
│   └── ALSAC.md
├── Vendors/
│   └── Canela Media.md
├── Deal Types/
│   ├── Programmatic Guaranteed (PG).md
│   └── Private Marketplace (PMP).md
├── Briefs/
│   ├── Brief — CTV.md
│   ├── Brief — Programmatic.md
│   └── Brief — Social.md
├── Projections/
│   └── FY25 Media Plan Projections.md
├── Operations/
│   ├── Admin & SLA.md
│   ├── Conversion Tracking.md
│   ├── Measurement & Verification.md
│   └── Targeting Capabilities.md
└── Creative/
    └── Creative Guidelines.md
```

## Graph View

Open Obsidian's Graph View to see how everything connects. Color-code by folder or tag to see clusters of related knowledge. The `_MOC.md` node will be the most connected — it's the hub.
