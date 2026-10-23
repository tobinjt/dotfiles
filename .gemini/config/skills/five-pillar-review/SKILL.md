---
name: five-pillar-review
description: >-
  Performs a structured, five-pillar review of configurations, infrastructure scripts,
  code, and documentation covering: (1) Correctness, (2) Fitness for Purpose,
  (3) Missing Features to Consider, (4) Unnecessary Complexity, and
  (5) Alternative Configurations or Approaches. Use this skill whenever the user asks
  to review files, configs, scripts, or architecture for quality, improvements, or trade-offs.
---

# Five-Pillar Review Workflow

Use this skill to perform a rigorous, actionable review of configuration files,
infrastructure-as-code, scripts, source code, and accompanying documentation.

## Preparation & Context Gathering

1. **Read All Target Files Completely**: Read every referenced configuration,
   code, and documentation file in full so cross-file interactions and
   doc-vs-implementation mismatches are caught.
1. **Identify Target Platform & Constraints**: Note the exact
   software/OS/framework versions, hardware or resource constraints, workload
   characteristics, and security boundaries stated in the files.
1. **Verify Non-Obvious Platform Behavior**: When reviewing platform-specific
   settings, flags, or interactions (e.g., kernel/driver behavior, cloud/network
   rules, compiler/runtime flags), verify subtle version-specific semantics
   before flagging or recommending changes.

______________________________________________________________________

## The Five Review Pillars

Structure your review into the following five sections. Every finding must
include clickable file and line-range links
(`[filename](file:///absolute/path#L10-L20)`).

### 1. Correctness & Edge Cases

Audit the files for defects that could cause failures, unexpected behavior, or
security gaps:

- **Syntax, Semantics & Platform Quirks**: Invalid parameters, deprecated
  options, order-of-evaluation bugs, or driver/runtime edge cases.
- **Cross-File & Documentation Drift**: Claims in `README` or reference docs
  that do not match the actual implementation or configuration rules.
- **Security & Isolation Gaps**: Overly broad permissions/rules, missing
  filters, unauthenticated endpoints, or footguns when following documented
  tips.
- **Lifecycle & State Edge Cases**: Cold-boot deadlocks, reboot persistence
  issues, race conditions, or dynamic state shifts (e.g., unpinned IDs/MACs,
  missing fallbacks).
- **Actionable Fix**: Provide the exact drop-in fix or snippet for each issue
  found.

### 2. Fitness for Purpose

Evaluate how well the implementation satisfies its stated goals and operational
environment:

- **Alignment with Workload & Hardware**: Assess whether resource limits,
  queues, concurrency, or port/component allocations match the real-world
  bottlenecks.
- **Resilience & Failure Modes**: Check how the system behaves under load, power
  loss, upstream outages, or partial failure.
- **Call Out Strengths Briefly**: Highlight key design choices that are already
  well-suited to the problem so they are preserved during refactoring.

### 3. Missing Features Worth Using

Identify high-value native capabilities of the target platform, tool, or version
that are currently unused:

- Focus on features that materially improve **reliability, performance,
  security, or observability** without adding bloat.
- Explain **why** the missing feature matters in the user's specific environment
  (e.g., hidden hardware buffers, background optimization, kernel-level
  protection, better diagnostics) and show how to enable it.

### 4. Unnecessary Complexity

Spot elements that increase maintenance burden or risk without delivering value:

- **Redundant Rules or Settings**: Configuration lines shadowed by other rules
  or handled automatically by the underlying platform.
- **Over-Permissive or Unused Paths**: Rules or abstractions opened for
  scenarios that do not exist in the target environment.
- **Maintenance Footguns**: Duplicated definitions where updating one place
  while forgetting another creates a bug or security hole.
- Show how many lines/concepts can be collapsed or removed cleanly.

### 5. Alternative Configurations & Approaches to Consider

Present thoughtful architectural or configuration alternatives where meaningful
trade-offs exist:

- Contrast the current approach with 2–4 credible alternatives (e.g., static vs.
  dynamic allocation, provider/upstream choices, consolidation vs. separation,
  host-level vs. appliance-level routing).
- Clearly state the **pros, cons, and trade-offs** of each alternative so the
  user can decide which to adopt.

______________________________________________________________________

## Follow-Up Execution

End the review by offering to apply the selected fixes and enhancements across
all code, configuration, and documentation files so they remain 100%
synchronized.
