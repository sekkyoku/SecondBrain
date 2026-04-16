---
type: system
title: "Lint Report"
updated: 2026-04-16
tags: [system, lint, health]
status: active
---

# Lint Report — 2026-04-16

**Files scanned:** 38  **Issues found:** 14  **Severity:** minor

## Structural

### Broken wiki-links (0)

_none_

### Missing/invalid frontmatter (5)

- `Dashboard.md` — missing: `type`, `title`, `updated`, `tags`, `status` (Dataview-only file, no frontmatter)
- `CLAUDE.md` — missing: `type`, `title`, `updated`, `tags`, `status` (vault instructions file, no frontmatter)
- `_system/README.md` — missing: `status`
- `_system/_SCHEMA.md` — missing: `status`
- `_system/_CLAUDE.md` — missing: `status`
- `Vendors/Canela Media Inventory.md` — invalid type: `vendor-inventory` (not in schema; valid: vendor, client, deal, brief, projection, operations, creative, moc, system)

### Stale notes (0)

_none_ (all notes updated between 2026-04-13 and 2026-04-16)

### Orphans (1)

- `Dashboard.md` — no inbound `[[]]` links; not referenced from `_MOC.md`. (Dataview widget — may be intentional.)

### Duplicate titles (0)

_none_

### TODO/FIXME (0)

_none_ (TODOs found only in `.obsidian/plugins/` JS files — not vault notes)

## Semantic

### Contradictions (2)

1. **Frequency cap** — four different values across notes:
   - `Programmatic RFI 26-27.md`: 3x/Day/User (DIO/PG default)
   - `CTV Vetting Q&A.md`: 6x/day (CTV scatter)
   - `Streaming Capabilities 22-23.md`: 4x/day recommended (22-23 baseline)
   - `Streaming Upfront Guidelines 22-23.md`: "minimum 3x/day frequency for OTT" (Canela's HMI counter-proposal)
   - *Already noted in `vault/CLAUDE.md` as needing confirmation per deal type. Newly ingested historical data adds context: Canela has consistently pushed for 3-4x/day minimum, while agencies request 1-2x/stream.*

2. **CTV CPM pricing across periods** — not a true contradiction but potentially confusing without context:
   - `Site Direct CPM Rate Card 2024.md`: :30 = $38, :15 = $33 (2024 site-direct, geo-targeted)
   - `CTV Vetting Q&A.md`: :30 = $37, :15 = $30 (26-27 scatter)
   - `OMD Clorox Partners RFI.md`: :30 = $33.60-$36, :15 = $26.50-$31 (pre-negotiation ranges)
   - *These reflect different time periods, deal types, and negotiation stages. Consider adding a "Pricing History" summary note to reconcile.*

### Missing concepts (3)

1. **Canela Audience Solutions (CAS)** — 1P data product referenced in `Targeting Capabilities.md`, `Programmatic RFI 25-26.md`, `Multicultural RFI 2024.md`, and `Programmatic RFI 26-27.md`. No dedicated note. Suggest: `Operations/Canela Audience Solutions.md`
2. **LiveRamp** — identity/data partner referenced in 5+ notes for onboarding, ID resolution, and 3P segments. No dedicated note. Suggest: `Operations/LiveRamp Integration.md`
3. **VideoAmp** — measurement partner with PG-specific significance (PG supports VideoAmp, PMP does not). Referenced in `Measurement & Verification.md`. Suggest: `Operations/VideoAmp.md`

### Outdated info (2)

1. `Projections/FY25 Media Plan Projections.md` — FY25 ended. Flight was Nov 2024. Either archive (`status: archived`) or add FY26/FY27 counterparts.
2. `Operations/FLA Compliance.md` — 2024 attestation signed 10/17/2023, valid for 1 year (expired 10/17/2024). 2025 template populated but no signed PDF for 2025. Confirm renewal status.

### Coverage gaps (2)

1. **Audio / Podcast capabilities** — both `Multicultural RFI 2024.md` and `Carat Supplier Overview 2024.md` reference a "dedicated audio and podcast space" on Canela's 2025 roadmap. `FY24 Holiday DV Specs.md` shows Canela already ran :15s audio ads. No dedicated note covers audio inventory, specs, or pricing. Suggest: `Operations/Audio & Podcast Capabilities.md`
2. **Agency contacts directory** — `Admin & SLA.md` covers ALSAC-specific contacts. New ingested files introduce contacts at OMD (Mel Ruiz), Publicis (Christine Garcia), Carat (no NDA yet), HMI (Andres Rincon, Elvin Fernandez, Julieta LaMalfa, Karsten). No consolidated cross-agency contact reference exists.

### Weak link-graph (0)

_none_ — all 10 newly ingested notes have `related:` entries linking to 3-6 existing notes each. Cross-referencing is healthy.

## Recommended next actions

1. **Add `status: active` to 3 system notes** (`_system/README.md`, `_system/_SCHEMA.md`, `_system/_CLAUDE.md`).
2. **Fix `vendor-inventory` type** on `Canela Media Inventory.md` → change to `vendor` or add `vendor-inventory` to schema.
3. **Archive `FY25 Media Plan Projections.md`** — set `status: archived`.
4. **Create `Canela Audience Solutions.md`** — the 1P data product is referenced everywhere but has no dedicated note.
5. **Confirm FLA attestation 2025 renewal** — 2024 attestation expired.
