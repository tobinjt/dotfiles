---
name: review-plan
description: >-
  Performs a structured, eight-pillar review of any plan, configuration, design, or itinerary—including
  software, hardware, networking, woodworking, tools, DIY, home improvement, financial planning, and
  holiday/travel planning. Evaluates: (1) Correctness, Accuracy, and Consistency, (2) Instruction/Step
  Correctness, Completeness, and Clarity, (3) Fitness for Purpose, (4) Risks & Mitigations,
  (5) Availability of Components, Materials, Bookings, or Products, (6) Missing Features, Allowances,
  or Opportunities, (7) Unnecessary Complexity, and (8) Alternative Approaches to Consider. Use this
  skill whenever the user asks to review a plan, project, config, script, budget, or itinerary.
---

# Universal Plan & Configuration Review Workflow

Use this skill to perform a rigorous, actionable eight-pillar review across any domain—including **software, hardware, networking**, **woodworking, tools, DIY, home improvement**, **financial planning**, and **holiday/travel planning**.

## Preparation & Context Gathering

1. **Read All Target Files & Context Completely**: Read every referenced file, table, script, drawing, budget, or itinerary in full so cross-file interactions, math errors, and mismatches are caught.
1. **Identify Domain, Jurisdiction & Constraints**: Note the applicable environment, geography/jurisdiction (e.g., local building codes, electrical standards, tax year/country rules, travel nationalities, climate/season), budget, timeline, and skill/tool constraints.
1. **Verify Live External Facts & Availability**:
   - **Never rely on stale assumptions**: Verify current regulations, tax thresholds, visa/entry rules, opening hours, transit schedules, or software version semantics.
   - **Live SKU, Link & Booking Verification**: When plans reference specific tools, hardware, timber/materials, financial products, flights, hotels, or purchase URLs, verify that links are live, items are in stock (not discontinued/superseded), and bookings/routes actually operate on the target dates.

______________________________________________________________________

## The Eight Review Pillars

Structure your review into the following eight sections (adapting each pillar to the domain of the plan). When reviewing workspace files, include clickable file and line-range links (`[filename](file:///absolute/path#L10-L20)`).

### 1. Correctness, Accuracy, and Consistency

Audit the plan for technical defects, arithmetic/measurement errors, factual inaccuracies, and internal contradictions:

- **Cross-Document & Internal Consistency**: Verify that numbers, totals, dates, dimensions, variable names, and diagrams agree across every section and file.
- **Domain-Specific Checks**:
  - *Software, Hardware & Networking*: Syntax, API/version compatibility, order-of-evaluation bugs, MTU/subnet math, pinouts, power budgets, and doc-vs-code drift.
  - *Woodworking, Tools, DIY & Home Improvement*: Cut-list and kerf math, joinery geometry, metric/imperial conversions, load/span calculations, wood movement allowances, and compliance with building/electrical/plumbing codes.
  - *Financial Planning*: Spreadsheet/formula arithmetic, compounding and inflation math, current-year tax bands/allowances/contribution limits, fee/interest calculations, and cash-flow balance consistency.
  - *Holiday & Travel Planning*: Date/day-of-week alignment, time-zone math, realistic driving/transit durations, geographical routing order, and operating seasons/days of attractions.
- **Actionable Fix**: Provide the exact correction, formula fix, dimension adjustment, or drop-in snippet for every issue found.

### 2. Instruction Correctness, Completeness, and Clarity

Audit all step-by-step procedures, build sequences, execution plans, and itineraries:

- **Sequencing & Order of Operations**: Ensure steps are ordered so earlier actions do not block or complicate later ones:
  - *Software/Networking*: Dependencies and uploads before resets; firewall/access rules before enabling strict filtering.
  - *Woodworking/DIY*: Milling, dry-fitting, pre-finishing, and glue-up sequences; isolating power/water before work; curing/drying times between coats.
  - *Financial*: Account opening, transfer settlement windows, tax-year deadlines, and prerequisite registrations.
  - *Travel*: Booking lead-time order (permits/visas and scarce reservations before non-refundable flights/hotels), check-in/check-out windows, and luggage storage between legs.
- **Completeness & Unstated Assumptions**: Flag missing commands, omitted prep work, unstated tool setups/jigs, missing transfer steps, or absent verification/test steps.
- **Clarity**: Replace vague steps with concrete measurements, settings, commands, or actionable checklists.

### 3. Fitness for Purpose

Evaluate how well the plan satisfies the user's stated goals, constraints, and real-world conditions:

- **Alignment with Goals & Bottlenecks**:
  - *Software/Networking*: Throughput, latency, concurrency, and hardware capacity under real workloads.
  - *Woodworking/DIY*: Structural rigidity, ergonomics, durability, moisture/UV resistance, and suitability of chosen materials/tools for the environment.
  - *Financial*: Alignment with time horizon, liquidity needs, risk tolerance, income stability, and tax efficiency.
  - *Travel*: Pacing (avoiding burnout from over-packed days), suitability for the travellers' interests/mobility/weather, and balance of transit time vs. enjoyment.
- **Call Out Strengths Briefly**: Highlight design choices that are already well-suited so they are preserved during revisions.

### 4. Risks & Mitigations

Identify operational, safety, security, financial, or logistical risks, and pair each with a concrete mitigation or fallback:

- *Software, Hardware & Networking*: Management lockouts, single points of failure, data loss, security exposures, cold-boot deadlocks, PoE/electrical damage, and rollback plans.
- *Woodworking, Tools, DIY & Home Improvement*: Kickback or tool-handling hazards, PPE/dust/fume extraction, hidden utilities (pipes/cables), structural/water-ingress failure modes, and timber warping/splitting.
- *Financial Planning*: Sequence-of-returns risk, emergency-fund depletion, interest-rate/inflation shocks, tax penalties, concentration/platform risk, and insurance/protection gaps.
- *Holiday & Travel Planning*: Tight connection buffers, strike/weather disruptions, visa/passport validity rules (e.g., 6-month rule), medical/cancellation insurance gaps, local scams/safety, and backup rainy-day options.

### 5. Availability of Components, Materials, Bookings, or Products

Verify that every required physical item, dependency, product, or reservation is genuinely obtainable:

- **Live SKU, Stock & Link Verification**: Confirm products, tools, timber dimensions, electronics, or software packages are currently available, in stock, and not EOL/discontinued—providing active replacement SKUs or local trade alternatives where needed.
- **Completeness of Bill of Materials / Packing / Requirements**:
  - *Software/Hardware*: Unlisted cables, transceivers, power supplies, mounting brackets, adapters, or licenses.
  - *Woodworking/DIY*: Fasteners, adhesives, abrasives, finishes, blades/bits, clamps, jigs, and safety gear.
  - *Financial*: Account eligibility rules (residency, minimums) and provider availability in the user's jurisdiction.
  - *Travel*: Ticket/permit quotas, seasonal closures, restaurant/train booking windows, and required travel documents/adapters/passes.

### 6. Missing Features, Allowances, Techniques, or Opportunities

Highlight valuable capabilities, techniques, reliefs, or experiences the plan overlooks:

- *Software/Networking*: Built-in platform features that improve performance, security, automation, or observability.
- *Woodworking/DIY*: Simpler or stronger joints, jig techniques, workshop aids, serviceability features (e.g., access panels, cable channels, levelling feet), or protective finishes.
- *Financial*: Unused tax wrappers/shelters, employer matching, spousal allowances, fee-saving tiers, or automation (standing orders/rebalancing).
- *Travel*: Nearby high-value sights along the same route, regional transit/museum passes, scenic alternative routes, or local festivals/dining worth booking.

### 7. Unnecessary Complexity

Spot elements that add cost, effort, fragility, or maintenance burden without proportionate value:

- *Software/Networking*: Redundant rules, over-segmented architectures, manual steps that can be automated, or maintenance footguns.
- *Woodworking/DIY*: Over-engineered joinery for hidden/low-stress parts, excessive material thicknesses, or specialty single-use tools when a standard tool/jig suffices.
- *Financial*: Overlapping funds/accounts, complex multi-institution juggling for negligible yield differences, or high-maintenance manual tracking.
- *Travel*: Unnecessary hotel changes (one-night stays), backtracking routes, or over-scheduled micro-itineraries.

### 8. Alternative Configurations & Approaches to Consider

Present 2–4 thoughtful alternatives where meaningful trade-offs exist:

- Compare the current plan against credible alternatives across **cost, time/effort, risk, durability/performance, and flexibility** (e.g., sheet goods vs. solid timber; lump-sum vs. phased investing; base-camp hub vs. point-to-point road trip; managed service vs. self-hosted).
- Clearly state the **pros, cons, and trade-offs** of each option so the user can make an informed choice.

______________________________________________________________________

## Follow-Up Execution

End the review by offering to apply the selected fixes, risk mitigations, and improvements across all plan documents, scripts, cut lists, budgets, or itineraries so everything remains 100% synchronized.
