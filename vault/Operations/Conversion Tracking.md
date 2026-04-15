---
type: operations
title: "Conversion Tracking"
updated: 2026-04-13
tags: [tracking, pixels, vast, conversion, measurement]
status: active
related:
  - "[[Measurement & Verification]]"
  - "[[Canela Media]]"
  - "[[ALSAC]]"
---

# Conversion Tracking

## RACI

| Component | Owner |
|-----------|-------|
| Pixel Intent | ALSAC |
| Page Specific vs Site-Wide | ALSAC |
| Tracking Mechanism | Media Partner |
| Base Code + Placement | Media Partner |
| Event Code + Placement | Media Partner |
| Notes | Media Partner / ALSAC |

## Current Setup

- **Pixel Intent:** Landing Page Views
- **Scope:** Page Specific
- **Tracking Mechanism:** 3rd Party Measurement Provider
- **Base Code:** Ad Server
- **Base Code Placement:** Ad Server
- **Event Code:** Ad Server
- **Event Code Placement:** Ad Server

## Pixel Request Process

New pixels require submission to Media Lead. Use: `FY24 Pixel Request Template.xlsx`

## Supported Tracking

- **VAST tags** for impression and video tracking
- **Standard impression tracking pixels** supported via VAST
- **3rd party tracking pixels** accepted (e.g., VideoAmp)

## DV360 Notes

- In DV360, you **cannot** append a tracker to 3rd party VAST tags
- Publisher must append tracking ad for VAST format
- Most publishers have no issue applying tracking ads
- Before saving deal in DV360, send publisher screenshots of setup to confirm
