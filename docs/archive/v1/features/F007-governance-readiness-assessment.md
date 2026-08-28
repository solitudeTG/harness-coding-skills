---
id: F007
doc_kind: feature
status: completed
created: 2026-06-10
updated: 2026-06-10
---

# F007: Governance Readiness Assessment

## Goal

Extend Harness readiness routing from release and completion checks to general governance status questions: progress, maturity, distance to target, roadmap gap, delivery gap, blockers, and remaining modules.

## Vision Anchor

- Original request or source: batch 3 asks to backport upstream common governance rules while keeping the solitude repository independent.
- User pain or engineering problem: users often ask "overall progress", "how far from target", or "what is missing" before a formal release, PR, or handoff exists. Without an explicit readiness trigger, the agent may answer with an invented percentage or informal summary instead of using gate, evidence, blocker, and next-action status.
- Expected result: `harness-readiness-dashboard`, `using-harness`, routing reference, skill index, and workflow docs route progress and gap questions to the readiness dashboard.
- Non-goals or boundaries: do not rename solitude skills or import upstream brand documents; do not create a separate roadmap-planning skill in this batch.
- Exit Gate source: EV-010, targeted progressive-disclosure test, full pytest, metadata check, and knowledge check.


## Feature Intake

- Original problem: See Vision Anchor.
- User pain point: See Vision Anchor.
- Capability promise: Preserve the capability described by this Feature.
- Non-goals: See Vision Anchor non-goals or boundaries.
- Acceptance source: Acceptance Criteria and linked Evidence.
- Open questions: none known.

## Capability Contract

- Maintain the current capability boundary described by this Feature.

## Decision Context

### Why

This Feature preserves durable recovery context for `F007: Governance Readiness Assessment`.

### Why Not

Do not replace this Feature with chat-only memory; future agents need a stable source of truth.

### If Modifying This Area, Check

- This Feature's Acceptance Criteria, Acceptance Map, Evidence, and Patch History.
- Linked ADR, Lesson, Evidence, and related specs or plans.

## Current Status

Done. Harness readiness now covers progress assessment, maturity assessment, distance to target, roadmap gap, delivery gap, overall progress, and Chinese user phrasing such as `整体进展`, `距离目标`, `还差多少`, `当前成熟度`, and `交付缺口`.

## Links

- [EV-010 Governance Readiness Assessment](../evidence/EV-010-governance-readiness-assessment.md)

### Evidence

See linked Evidence in this Feature, if present.

### Decisions / ADRs

None recorded.

### Lessons

None recorded.

### Specs / Plans

None recorded.

### Related Features

None recorded.

### External Context

None recorded.

## Acceptance Criteria

- [x] `harness-readiness-dashboard` frontmatter includes progress, maturity, distance-to-target, roadmap gap, delivery gap, and Chinese gap-assessment triggers.
- [x] Readiness dashboard purpose says it answers what is missing before the target state, not only whether work can move to review or release.
- [x] `using-harness` routes progress, maturity, distance-to-target, roadmap gap, blocker, and readiness rollups to `harness-readiness-dashboard`.
- [x] `using-harness/references/routing.md`, `docs/skill-index.md`, and `docs/workflow.md` describe the broader dashboard responsibility.
- [x] Regression test locks the progress/gap trigger terms.
- [x] Validation commands pass before commit.


## Acceptance Map

| Claim | Acceptance | Evidence | Status |
| --- | --- | --- | --- |
| F007: Governance Readiness Assessment remains recoverable | Acceptance Criteria describe the expected state | Linked Evidence or this Feature history | active |

## State Timeline

| Date | State | Trigger | Evidence | Note |
| --- | --- | --- | --- | --- |
| 2026-06-26 | active | Feature governance migration | This Feature | Added recall and recovery structure |

## Patch History

None yet.

## Evidence

[EV-010 Governance Readiness Assessment](../evidence/EV-010-governance-readiness-assessment.md)


## Recovery Snapshot

- Read first: this Feature page.
- Current capability state: see Current Status.
- Known risks: see Patch History and linked Evidence.
- Next safe action: follow Next Step after running required gates.
- Unblock condition: not blocked unless Current Status says otherwise.

## Next Step

If future real use shows roadmap planning needs decisions beyond status rollup, evaluate a separate planning or roadmap skill instead of overloading the readiness dashboard.






