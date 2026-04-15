---
type: operations
title: "Measurement & Verification"
updated: 2026-04-13
tags: [measurement, ias, videoamp, vast, brand-safety, verification, vcr, viewability, 26-27]
status: active
related:
  - "[[Conversion Tracking]]"
  - "[[Canela Media]]"
  - "[[Programmatic Guaranteed (PG)]]"
  - "[[Private Marketplace (PMP)]]"
  - "[[Streaming Consumption Profile]]"
  - "[[Audience Demographics]]"
---

# Measurement & Verification

## Supported Tags

- **VAST** — primary tracking tag format

## Third-Party Pixels

- Third-party tracking pixels accepted (e.g., VideoAmp): **Yes**

## IAS Integration

- IAS tag acceptance (viewability, IVT, MFA rates): **Yes**

### IAS Best Practices by Deal Type

| Deal Type | IAS Approach |
|-----------|-------------|
| [[Programmatic Guaranteed (PG)]] | Supported where applicable |
| [[Private Marketplace (PMP)]] | Leverage IAS pre-bid segments for brand safety, suitability, and IVT filtering. Balance targeting layers to maintain scale. |

## Brand Safety

- **Implementation:** Category Exclusions
- **PMP note:** The fewer exclusions, the better the scale

## VideoAmp — Critical Difference

| Deal Type | VideoAmp Pixel Accepted? | Fallback |
|-----------|------------------------|----------|
| [[Programmatic Guaranteed (PG)]] | **Yes** | Append to backend of deals |
| [[Private Marketplace (PMP)]] | **No** | DSP reporting, server-to-server integrations, alternative attribution |

> If VideoAmp pixel is not accepted, CTV/Audio campaigns cannot be measured for attribution accurately.

## Impression Pixels

Standard impression tracking pixels supported via VAST tags (both deal types).

## VCR Benchmarks (26-27)

| Format | VCR |
|--------|-----|
| OTT/CTV | **85%+** |
| OLV Pre-Roll | 70–80% |
| OLV Outstream | 60–70% |

## Viewability (26-27)

- **Overall:** >70% (IAS verified)
- **OTT IAS:** >70% viewability, >98% brand safety, <1% IVT

## Co-Viewing

- Yes — included in CTV/OTT measurement via Nielsen and iSpot

## 3P Pixel Limit

- Up to **3 third-party pixels** per placement (standard)
- Additional pixels may be accommodated on request

## Transparency

- Content / Channel / Genre level reporting
- Program-level reporting available for O&O inventory upon request

## Brand Study Partners (26-27)

| Partner | Capability | Threshold |
|---------|-----------|-----------|
| **Nielsen** | Brand Lift & Incremental Reach | — |
| **iSpot** | OTT measurement | DIO only, >$150K |
| **Upwave** | BLS (Brand Lift Study) | AV at $500K+ |
| **Kantar** | Brand study | — |
| **Dynata** | Brand study | — |

## Audience Guarantees

- Nielsen DAR
- iSpot (OTT DIO >$150K)
- Upwave BLS (AV at $500K+)

## Known DSP Conflicts — Measurement

| Deal Type | Risk |
|-----------|------|
| PG | None known at this time |
| PMP | Overly restrictive verification settings, unsupported tags, or misaligned VAST configurations may limit scale |
