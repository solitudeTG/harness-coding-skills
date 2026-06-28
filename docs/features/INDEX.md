# Feature Index

Use this file as the coarse recall entry before opening Feature pages. Pick the 1-3 most plausible candidates, then read the Feature pages and linked Evidence.

| Feature | Domain | Trigger Terms | Owned Paths | Read When |
| --- | --- | --- | --- | --- |
| [F001](F001-closeout-entry-anchor-validation.md) | closeout | completion claim, closeout, Evidence, Vision Anchor | scripts/harness_closeout_check.py; skills/harness-knowledge-capture | Completion language or closeout contract changes. |
| [F002](F002-canonical-harness-artifact-placement.md) | knowledge | docs/features, docs/decisions, docs/lessons, docs/evidence | docs/features; docs/decisions; docs/lessons; docs/evidence | Artifact placement or canonical docs paths change. |
| [F003](F003-optional-harness-hook-runtime.md) | hooks | Codex hooks, Claude hooks, OpenCode hooks, stop, recovery | hooks; skills/using-harness/hooks; hooks.json | Hook runner behavior or examples change. |
| [F004](F004-delegation-gate-three-outcomes.md) | delegation | single_agent, delegate, blocked, independent review | skills/harness-delegation-gate; docs/features/F004* | Delegation decisions or subagent routing change. |
| [F005](F005-session-recovery-hooks.md) | hooks | pre-compact, session-start, compaction recovery | docs/features/F005* | Recovery or compaction guidance changes. |
| [F006](F006-spec-drift-guardrails.md) | spec | stale spec, validation failure, acceptance criteria drift | skills/harness-spec-drift; docs/features/F006* | Spec Drift routing or stale-spec rules change. |
| [F007](F007-governance-readiness-assessment.md) | readiness | progress, maturity, gap, blocker, distance to target | skills/harness-readiness-dashboard; docs/features/F007* | Readiness or progress assessment changes. |
| [F008](F008-doc-install-example-consistency.md) | docs | README, INSTALL, examples, public docs | README.md; README.en.md; INSTALL.md; examples | Public docs, install flow, or examples change. |
| [F009](F009-feature-intake-governance.md) | feature-memory | Feature Intake, Decision Context, Acceptance Map, Recovery Snapshot | templates/FEATURE.md; scripts/knowledge_check.py; skills/using-harness | Feature memory schema or validator changes. |
| [F010](F010-goal-driven-feature-flow.md) | workflow | Goal boundary, approval guard, per-Feature approval | skills/using-harness; skills/harness-start-gate | Goal-driven Feature flow or approval boundary changes. |
| [F011](F011-lesson-case-protection-governance.md) | lessons | lesson, case, resolution, prevention, patch churn | templates/LESSON.md; docs/lessons; scripts/knowledge_check.py | Lesson structure or case protection rules change. |
| [F012](F012-adr-decision-boundary-governance.md) | decisions | ADR, decision boundary, rejected options, change checks | templates/ADR.md; docs/decisions; scripts/knowledge_check.py | ADR structure or decision boundary rules change. |
| [F013](F013-evidence-claim-verification-governance.md) | evidence | Evidence, supports claim, verification scope, limitations | templates/EVIDENCE.md; docs/evidence; scripts/knowledge_check.py | Evidence structure or claim verification rules change. |
| [F014](F014-project-rules-human-authorized-governance.md) | project-rules | AGENTS.md, project rules, user authorization, promotion boundary | templates/AGENTS.md; skills/harness-project-rules | Project rule promotion or AGENTS guidance changes. || [F015](F015-stop-only-hook-runtime.md) | hooks | stop-only hook runtime | hooks.json, Stop, closeout, hook diagnostics | Hook default runtime scope or hook examples change. |
| [F016](F016-doc-usage-telemetry.md) | telemetry | document usage telemetry | usage_record.py, doc usage, shaped_change_narrative | Change narrative or retrieval starts recording document usage. |
