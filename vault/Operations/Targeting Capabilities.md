---
type: operations
title: "Targeting Capabilities"
updated: 2026-04-13
tags: [targeting, contextual, geotargeting, device, ctv, audience, identity, liveramp, cas, 26-27]
status: active
related:
  - "[[Canela Media]]"
  - "[[Programmatic Guaranteed (PG)]]"
  - "[[Private Marketplace (PMP)]]"
  - "[[Programmatic RFI 26-27]]"
  - "[[Audience Demographics]]"
---

# Targeting Capabilities

## Targeting Types

- **Contextual Targeting** (content category)
- **Canela Audience Segments** (proprietary)

## Geotargeting

- Available: **Yes**
- ⚠️ **Not recommended for scale**

## Device Targeting

- Available: **Yes**
- ⚠️ **Not recommended for scale**

## CTV Specific

- Platform support: **Yes**
- Household-level targeting: **Yes**

## Inclusions

- Contextual Targeting by content category

## Exclusions

### PG Deals
Standard brand safety, content suitability exclusions, and custom exclusions defined at setup (e.g., sensitive categories or competitive separation).

### PMP Deals
Brand safety filters, sensitive content exclusions, and custom-defined audience or category exclusions.

## Audience Limitations

### PG
Targeting parameters are typically **locked at setup**. Minor adjustments may be possible; significant changes require deal reconfiguration and re-approval.

### PMP
PMP offers flexibility, but **overly granular targeting** may reduce scale and impact win rates in the auction.

## Lookalike Audiences

- Do **not** dynamically refresh in real time
- Updates require **manual** changes and reactivation based on refreshed seed audiences

## Learning Reset Triggers

Significant changes may impact delivery and optimization:
- Budget adjustments
- Targeting modifications
- Creative swaps
- Deal reconfigurations (PG) / Bid adjustments (PMP)

## 1P Data — Canela Audience Solutions (CAS) (26-27 RFI)

- **Product:** Canela Audience Solutions (CAS) — proprietary 1P data
- **Availability:** PG and PMP
- **Note:** TTD does not allow Canela to run their 1P data product; DV360 and Xandr preferred

### 1P Data by Deal Type

| Deal Type | Client 1P Data | CAS 1P Data |
|-----------|----------------|-------------|
| PG | Y | Y |
| PMP | N | Y |

## 3P Data Partners (26-27 RFI)

- **LiveRamp** — primary 3P identity and segment partner
- 3P targeting available on **PG deals** (Y)
- 3P segments sourced from LiveRamp marketplace
- No 3P attribution partners integrated directly

## Identity Resolution (26-27 RFI)

| Environment | Method |
|-------------|--------|
| CTV / Mobile | Device ID (IFA / GAID) |
| Desktop | Cookie + IP matching |
| Cross-device | LiveRamp integration |

- **HMI Aquifer & LiveRamp 1P pixel:** Accepted (Y)
- **HMI .blu DMP:** Not currently integrated, but exploring; CAS 1P available as alternative
- **3P IDs:** LiveRamp IdentityLink
- **Persistent ID type:** IFA

## DNA List Targeting (26-27)

- Yes — contextual targeting by genre/content category via CAS and direct IO
- **CPM premium for DNA list:** $2.00 flat

## Known DSP Conflicts — Targeting

| Deal Type | Risk |
|-----------|------|
| PG | Overly restrictive targeting layers, frequency caps, or conflicting audience settings may limit scale |
| PMP | Overly restrictive targeting combinations, low bid levels, or conflicting audience settings may reduce win rates |
