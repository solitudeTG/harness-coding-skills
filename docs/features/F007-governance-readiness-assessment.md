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

## Current Status

Done. Harness readiness now covers progress assessment, maturity assessment, distance to target, roadmap gap, delivery gap, overall progress, and Chinese user phrasing such as `整体进展`, `距离目标`, `还差多少`, `当前成熟度`, and `交付缺口`.

## Links

- [EV-010 Governance Readiness Assessment](../evidence/EV-010-governance-readiness-assessment.md)

## Acceptance Criteria

- [x] `harness-readiness-dashboard` frontmatter includes progress, maturity, distance-to-target, roadmap gap, delivery gap, and Chinese gap-assessment triggers.
- [x] Readiness dashboard purpose says it answers what is missing before the target state, not only whether work can move to review or release.
- [x] `using-harness` routes progress, maturity, distance-to-target, roadmap gap, blocker, and readiness rollups to `harness-readiness-dashboard`.
- [x] `using-harness/references/routing.md`, `docs/skill-index.md`, and `docs/workflow.md` describe the broader dashboard responsibility.
- [x] Regression test locks the progress/gap trigger terms.
- [x] Validation commands pass before commit.

## Patch History

None yet.

## Evidence

[EV-010 Governance Readiness Assessment](../evidence/EV-010-governance-readiness-assessment.md)

## Next Step

If future real use shows roadmap planning needs decisions beyond status rollup, evaluate a separate planning or roadmap skill instead of overloading the readiness dashboard.
