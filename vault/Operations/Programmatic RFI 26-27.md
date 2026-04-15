---
type: operations
title: "Programmatic RFI 26-27"
source: "26-27 Publisher Programmatic RFI (4.2.26)"
updated: 2026-04-14
tags: [rfi, programmatic, dio, pg, pmp, 26-27, horizon, canela-media]
status: active
related:
  - "[[Canela Media]]"
  - "[[Canela Media Inventory]]"
  - "[[Programmatic Guaranteed (PG)]]"
  - "[[Private Marketplace (PMP)]]"
  - "[[Targeting Capabilities]]"
  - "[[Measurement & Verification]]"
  - "[[Admin & SLA]]"
---

# Programmatic RFI 26-27

> Source: `26-27_Publisher_Programmatic_RFI_4.2.26.xlsx` → Programmatic RFI Questions
> Context: Horizon is looking to establish 3 programmatic deal types.

---

## Deal Type Overview

| Deal Type | Budget Model | Description |
|-----------|-------------|-------------|
| **Client DIO** (Direct IO / Upfront) | Registered & committed | These $ will be registered by client and committed |
| **Client PG** | Estimated & tracked | We will estimate client spend, and track throughout year to meet endeavor |
| **PMP** | Fluid | Fluid $ |

---

## Content Availability

| Question | DIO | PG | PMP |
|----------|-----|----|----|
| All networks available? | Y | Y | Y, based on availability |
| All shows available? | Y | Y | Y, based on availability |
| Live events / live sports available? | Y | Y | Y, based on availability |
| Live streaming impressions available? (%) | Y, 100% | Y, based on availability | Y, based on availability |
| All endpoints (distribution points) available? | Y | Y | Y, based on availability |
| Average monthly avails | 10M per advertiser approx | 10M per advertiser approx | Y, based on availability |
| Reporting transparency (program/genre) | Y, device usage, show & genre level | Limited via PG; will provide available info | — |
| Monthly transparency reporting | Y | Y, can set campaigns to hit monthly goals | — |

---

## Device Mix

| Device | % of Inventory |
|--------|---------------|
| **CTV** | 95% |
| **Mobile (app)** | 3% |
| **Desktop / Web** | 2% |

> Device mix is consistent across DIO, PG, and PMP.

---

## Campaign Logistics

| Question | DIO | PG | PMP |
|----------|-----|----|----|
| Forecasting ability | Y | Y | N |
| Frequency capping (default) | 3x/Day/User | 3x/Day/User | Delivery may be impacted by restrictive frequency |
| Monthly PG deal setup | — | Y | — |
| Even pacing across flight | Daily optimizations | Daily optimizations | N/A (if even pacing needed, use DIO or PG) |
| Creative lengths accepted | :06s, :15s, :30s | :15s, :30s | :15s, :30s |
| Targeting by publisher | Y | Y | Y |
| Exclusions | No exclusion | Sponsorships, iCTV, OLV w/End Card, Rich Media | Sponsorships, iCTV, OLV w/End Card, Rich Media |

### Measurement by Deal Type

| Deal Type | Measurement Partners |
|-----------|---------------------|
| DIO | Upwave (BLS), FSQ (Store Visits Attribution Study), DAR |
| PG | — |
| PMP | — |

---

## Technology Stack

### Ad Servers
- **SpringServe** — primary (OTT O&O)
- **Google Ad Manager (GAM)** — Futbol Sites / Online
- **FreeWheel** — TMA, Vidoomy

### SSPs

| Purpose | SSPs | Priority |
|---------|------|----------|
| Preferred for PG | **Xandr, Magnite** | SpotX → Ad Manager → FreeWheel |
| Preferred for PMP | **Magnite, Xandr** | OTT: N/A; Online: Xandr |

### PG Waterfall Priority
- PG is **second priority after DIO**
- PG deals cannot be prioritized above direct deals

### PMP Priority
- PMP is **not a priority** — not guaranteed
- OTT: N/A; Online: Xandr

### DSP Integrations
- **DV360, Xandr** — preferred
- **TTD (The Trade Desk)** — ⚠️ **Not preferable** — does not allow Canela to run their 1P data product (best in class) and not all inventory is available
- Able to prioritize deals within ad server: **DV360, FreeWheel, Xandr**

### Platform Integrations

| Integration | Status |
|-------------|--------|
| Magnite's SpringServe | ✅ Y |
| FreeWheel's Curation Hub | ❌ N |
| Microsoft's Curator Tool | ❌ N |
| Contextual partners (IRIS, Peer39, GumGum) | — |

---

## Budget / Pricing / Fees

| Question | DIO | PG | PMP |
|----------|-----|----|----|
| DIO to PG price parity guaranteed? | Y | Y | — |
| Budget fluidity between PG & PMP | Y | Y | — |
| Mid-flight spend adjustment (PG↔PMP) | N, only PG | N, only PG | — |
| Typical sell-out periods | Q3–Q4 | Q3–Q4 | — |
| Added value opportunities | Y — 1% AVM BLS AND iSpot measurements | Y — 1% AVM BLS AND iSpot measurements | — |
| DNA list premium (flat CPM) | Y, **$2 CPM** | Y, **$2 CPM** | — |
| DSP reporting as billing source of truth | Y | Y | — |

---

## Bid Request Data

### Identifiers

| Signal | DIO | PG | PMP |
|--------|-----|----|----|
| User Agent String | N/A (no auction in DIO) | Y | Y |
| IP Address | — | Y | Y |
| Cookie / Device ID | — | Y | Y |
| Persistent ID type | — | IFA | IFA |

### Content Signals

| Signal | PG | PMP |
|--------|----|----|
| Genre | Y | Y |
| Content length | Y | Y |
| Livestream vs VOD | Both | Both |
| Episode name | N | N |
| Show name | Y | Y |
| Network / Channel name | Y (Channel Name) | Y (Channel Name) |
| Content owner | N | N |

### Privacy Compliance
- **Limit Ad Tracking (LAT):** Y (both PG and PMP)

---

## Data / Measurement

| Question | PG | PMP |
|----------|----|----|
| 3P targeting on PG deals? | Y | — |
| 3P data partners | LiveRamp | LiveRamp |
| 1P data (client / HMI .blu) | **Y, PG Only** | **N, PG Only** |
| Integrated with HMI's .blu DMP? | No, but exploring; 1P data product available | No, but exploring; 1P data product available |
| 3P attribution partners | None; uses LiveRamp for 3P segments from marketplace | — |
| Proprietary 1P data | **Canela Audience Solutions (CAS) 1P** | **Canela Audience Solutions (CAS) 1P** |
| Identity resolution | Device ID (IFA/GAID) for CTV/mobile; cookie + IP matching for desktop; LiveRamp integration | Same |
| Accept HMI's Aquifer & LiveRamp 1P pixel | Y | Y |
| 3P IDs integrated | LiveRamp | LiveRamp |

---

## Contacts (from RFI)

| Role | Contact |
|------|---------|
| **Sales** | Carolina Cadena |
| **Operations / Troubleshooting** | Sandra Pulido |
