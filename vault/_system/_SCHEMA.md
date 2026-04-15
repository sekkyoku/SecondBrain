---
type: system
title: "Frontmatter Schema Reference"
updated: 2026-04-13
tags: [system, schema]
---

# Frontmatter Schema

Every note in this vault uses YAML frontmatter. Here are the field definitions:

## Universal Fields

| Field | Type | Description |
|-------|------|-------------|
| `type` | string | Note category: `vendor`, `client`, `deal`, `brief`, `projection`, `operations`, `creative`, `moc`, `system` |
| `title` | string | Human-readable title |
| `updated` | date | Last modified date (YYYY-MM-DD) |
| `tags` | list | Obsidian-searchable tags |
| `related` | list | Wiki-links to connected notes |
| `status` | string | `active`, `template`, `archived` |

## Vendor-Specific

| Field | Type | Description |
|-------|------|-------------|
| `partner` | string | Vendor/partner name |
| `contact` | string | Primary contact email |
| `inventory_type` | string | `programmatic`, `direct`, `social` |

## Deal-Specific

| Field | Type | Description |
|-------|------|-------------|
| `deal_type` | string | `PG`, `PMP`, `PD`, `PA` |
| `cpm_type` | string | `fixed`, `dynamic`, `floor` |
| `serving` | string | `site-served`, `third-party` |

## Projection-Specific

| Field | Type | Description |
|-------|------|-------------|
| `flight_start` | date | Campaign start |
| `flight_end` | date | Campaign end |
| `total_budget` | number | Total spend |
| `fiscal_year` | string | e.g. `FY25` |
