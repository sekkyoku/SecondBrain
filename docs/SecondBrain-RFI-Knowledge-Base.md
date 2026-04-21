# SecondBrain — RFI & Rate Card Knowledge Base

**SecondBrain — RFI & Rate Card Knowledge Base - User Guide**
Access: Open the `SecondBrain` folder in **Claude Code Desktop**

---

## What is the SecondBrain RFI Knowledge Base?

The SecondBrain RFI Knowledge Base is an internal Canela Media intelligence system that stores agency RFIs, rate cards, buying guidelines, compliance documents, and historical upfront data as structured Markdown notes. Instead of searching through email threads or shared drives, you ask questions in plain English and get instant, sourced answers — no database, no embeddings, no waiting.

Claude Code Desktop reads the vault files directly. The entire knowledge base is version-controlled on GitHub and syncs automatically across machines every 5 minutes with no manual git commands required.

---

## Getting Started

Open **Claude Code Desktop**, click **Open folder**, and select `~/SecondBrain`. That is all. Claude loads the vault and is ready to answer questions immediately.

The vault currently holds **23 notes** in the `Operations/` folder, covering agency capabilities, CPM rate cards, buying guidelines, compliance requirements, and historical upfront data going back to 2022.

---

## Step 1 — Ask a Question

In the Claude Code Desktop chat bar, type your question in plain English.

**Example questions:**

- `What's the OTT CPM range across agency RFIs?`
- `Does Canela qualify for T-Mobile campaigns?`
- `What are the Capital One FLA restrictions for Hispanic media targeting?`
- `What measurement partners are approved under the Carat supplier requirements?`
- `What were the iCTV CPMs we quoted OMG in 2023?`
- `Compare 22-23 vs 25-26 upfront terms.`

**How Claude answers:**

Claude reads the relevant vault notes and responds with a direct answer, then cites the source note. If two notes contain conflicting data (e.g., different frequency caps), Claude flags the contradiction and surfaces both values so you can confirm the correct figure per deal type.

> **Tip:** Ask follow-up questions in the same session — Claude holds the full vault context and can cross-reference multiple notes in a single answer. For example: *"What CPM did OMD quote for CTV :30s, and how does that compare to our rate card?"*

---

## Step 2 — Ingest a New File

When you receive a new RFI, rate card, or buying guidelines document, share the file path with Claude in chat. Claude extracts the content, writes a structured vault note, and updates the master index automatically.

**How to ingest:**

1. Save the file anywhere on your machine (Downloads, Desktop, etc.).
2. In Claude Code Desktop, paste the file path and a brief instruction:

   ```
   Ingest this file into our second brain:
   /Users/you/Downloads/Agency_RFI_2026.xlsx
   ```

3. Claude reads the file, pulls out all relevant data, and writes a new note to `vault/Operations/`. It will also flag if the file appears to be a duplicate of an existing note.

**Supported file formats:** `.xlsx`, `.pptx`, `.pdf`, `.docx`, `.csv`

**Multiple files at once:**

```
Ingest the following files into our second brain:
/Users/you/Downloads/RFI_OMD_2026.xlsx
/Users/you/Downloads/CPM_Rate_Card_Q1.pptx
/Users/you/Downloads/Capital_One_FLA_2026.pdf
```

Each file produces its own vault note. Within 5 minutes, the background sync service commits and pushes the new notes to GitHub so all teammates receive them automatically.

> **Important:** Do not manually create vault notes or edit frontmatter unless you are following the note schema in the [Vault Note Schema](#vault-note-schema--how-it-works) section below. Malformed notes will be caught by the lint check but may produce inaccurate answers in the interim.

---

## Step 3 — Lint & Review

After ingesting new files, or as a weekly habit before any client briefing, run a full vault health check.

In the Claude Code Desktop chat bar, type:

```
/lint
```

Claude scans every note and checks for:

- **Broken links** — `[[wiki-links]]` that point to nonexistent notes
- **Missing or invalid frontmatter** — required fields absent or using wrong values
- **Stale notes** — last updated more than 180 days ago
- **Orphan notes** — notes not reachable from the master index (`_MOC.md`)
- **Duplicate titles** — two notes covering the same vendor/topic
- **Contradictions** — conflicting data across notes (e.g., two different frequency caps for the same client)
- **Missing concepts** — terms referenced in notes but never defined in their own note

The full report is written to `vault/_system/lint-report.md`. A 5-line summary appears in chat. Any issue marked `critical` should be resolved before using vault data in a client-facing document.

**To fix issues after linting:**

```
Read vault/_system/lint-report.md and fix the top 3 critical issues.
```

Claude edits the notes in place. The sync service handles the commit and push — no terminal required.

---

## The Sync Log

The background sync service runs every 5 minutes on each machine and logs every action to `~/SecondBrain/scripts/sync.log`. Open this file in any text editor (TextEdit, Notepad, VS Code) to verify the service is running.

**What the log shows:**

| Column | Description |
|--------|-------------|
| Timestamp | Date and time of the sync cycle (UTC) |
| Action | `ok` = synced cleanly; `WARN: push failed` = retrying next interval; `WARN: pull failed` = conflict needs review |
| Machine | Hostname that ran the sync |

**What a healthy log looks like:**

```
[2026-04-21 14:30:01] ok
[2026-04-21 14:35:01] ok
[2026-04-21 14:40:02] auto-sync: vault update from brunos-macbook 2026-04-21T14:40:01Z
[2026-04-21 14:45:01] ok
```

`WARN: push failed` lines are automatically retried on the next interval. If you see the same warning three or more times in a row, re-run the one-line install from [docs/SETUP.md](SETUP.md) to refresh credentials.

---

## Vault Note Schema — How It Works

**Vault path:** `~/SecondBrain/vault/Operations/`

---

### Overview

Every note in the vault is a plain Markdown file with a YAML frontmatter block at the top. The frontmatter is the machine-readable layer Claude uses to filter, link, and cross-reference notes during answering. The body of each note contains structured sections — key data tables, field-by-field breakdowns, and sourced facts extracted from the original document.

Each file covers one document (one RFI, one rate card, one compliance package), identified at the top by:
- **title** — full descriptive name of the note
- **updated** — ISO date of the last edit or data refresh
- **status** — `current`, `archived`, or `draft`

---

### Frontmatter Fields

Every vault note must include all six required fields. Notes missing required fields will be flagged by `/lint` as schema violations.

| Field | Required | Allowed Values | Description |
|-------|----------|---------------|-------------|
| `type` | Yes | `vendor`, `client`, `deal`, `brief`, `projection`, `operations`, `creative`, `moc`, `system` | Category of the note. All RFIs, rate cards, and guidelines use `operations`. |
| `title` | Yes | Any string | Full display name of the note, shown in the master index. |
| `updated` | Yes | `YYYY-MM-DD` | Date the note was last edited or its source data last refreshed. |
| `tags` | Yes | Array of strings | Searchable labels. Use agency name, document type, year, client name, and deal type where applicable (e.g., `[canela, rfi, OMG, 2023, ictv]`). |
| `status` | Yes | `current`, `archived`, `draft` | `current` = active and reliable; `archived` = superseded but preserved for historical reference; `draft` = incomplete, do not use for briefings. |
| `related` | Yes | Array of `[[wiki-links]]` | Links to other vault notes covering related topics. Used for cross-referencing during answer generation. |

**Example frontmatter:**

```yaml
---
type: operations
title: "OMG 23 CanelaTV RFI"
updated: 2023-06-01
tags: [canela, rfi, OMG, 2023, upfront, ictv, fast-channels]
status: current
related: ["[[Site Direct CPM Rate Card 2024]]", "[[Programmatic RFI 26-27]]", "[[Streaming Capabilities 22-23]]"]
---
```

---

### Operations Folder — Current Notes

| Note | Document Type | Source Agency/Client | Year | Status |
|------|--------------|---------------------|------|--------|
| Multicultural RFI 2024 | Agency capabilities RFI | Publicis / Zenith | 2024 | current |
| Carat Supplier Overview 2024 | Supplier qualification form | Dentsu / Carat | 2024 | current |
| OMD Clorox Partners RFI | Agency capabilities RFI | OMD / Clorox | 2024 | current |
| OMG 23 CanelaTV RFI | Upfront RFI | OMG | 2023 | current |
| Digital Buying Guidelines 2025 | Buying guidelines | T-Mobile | 2025 | current |
| Site Direct CPM Rate Card 2024 | Rate card | Internal | 2024 | current |
| FLA Compliance | Compliance attestation | Capital One | 2024 | current |
| Target MC Partner Overview | Partner overview | Target | 2024 | current |
| Programmatic RFI 25-26 | Upfront RFI | Horizon | 2025 | current |
| Programmatic RFI 26-27 | Upfront RFI | Horizon | 2026 | current |
| Streaming Capabilities 22-23 | Upfront capabilities | Portal | 2022 | archived |
| Streaming Upfront Guidelines 22-23 | IO & programmatic terms | HMI | 2022 | archived |
| FY24 Holiday DV Specs | Campaign specs | Matterkind | 2024 | archived |
| Targeting Capabilities | Capabilities overview | Internal | 2024 | current |
| Measurement & Verification | Measurement partners | Internal | 2024 | current |
| Ad Innovation Products | Premium ad units | Internal | 2024 | current |
| Audience Demographics | Audience profile | Internal | 2024 | current |
| Streaming Consumption Profile | Inventory & viewership data | Internal | 2024 | current |
| CTV Vetting Q&A | Planning Q&A | Internal | 2024 | current |
| Planning Questions Q&A | Planning Q&A | Internal | 2024 | current |
| Conversion Tracking | Tracking specs | Internal | 2024 | current |
| Walgreens Foot Traffic Measurement | Measurement comparison | Internal | 2024 | current |
| Admin & SLA | SLA and contacts | Internal | 2024 | current |

---

### How to Add a New Note (via Claude)

1. Drop the source file (xlsx, pptx, pdf) in any accessible folder on your machine.
2. In Claude Code Desktop, tell Claude what to ingest and any relevant context:

   ```
   Ingest this new agency RFI into the second brain. It's from GroupM for 2026.
   /Users/you/Downloads/GroupM_RFI_2026.pptx
   ```

3. Claude extracts the data, writes the note with correct frontmatter, adds it to `vault/Operations/`, and updates `vault/_MOC.md` with a reference.
4. The background sync service commits and pushes within 5 minutes.
5. Run `/lint` to confirm no schema issues were introduced.

---

### Note Types — Quick Reference

| Type | Use For |
|------|---------|
| `operations` | Agency RFIs, rate cards, buying guidelines, compliance docs, campaign specs, upfront data — any sourced external document |
| `vendor` | Canela Media product and capability profiles |
| `client` | Client profiles (ALSAC, Capital One, T-Mobile, etc.) |
| `deal` | PG, PMP, DIO deal mechanics and terms |
| `brief` | Intake templates for new campaigns |
| `projection` | Media plan numbers and budget forecasts |
| `creative` | Ad spec sheets and creative best practices |
| `moc` | Master table of contents only — do not create new MOC notes |
| `system` | Lint config, schema definitions, audit reports — do not edit manually |

---

*Built on Claude Code Desktop. Vault replaces RAG with direct-read Markdown context. Guide v1.0 — April 2026.*
