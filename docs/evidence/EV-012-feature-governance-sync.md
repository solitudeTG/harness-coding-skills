---
id: EV-012
doc_kind: evidence
scope: feature
feature_refs:
  - docs/features/F009-feature-intake-governance.md
  - docs/features/F010-goal-driven-feature-flow.md
created: 2026-06-26
---

# EV-012: Feature Governance Sync

## Commands

```text
python -m unittest tests.test_goal_driven_feature_flow tests.test_knowledge_check tests.test_skill_progressive_disclosure.SkillProgressiveDisclosureTests.test_feature_recall_uses_index_before_broad_reading
python -m pytest -q
python skills\using-harness\scripts\skill_metadata_check.py --root . --skills-path skills --strict
python skills\using-harness\scripts\knowledge_check.py --root . --docs-path docs --strict
```

## Results

- Targeted tests: Pass.
- Full pytest suite: Pass, 95 tests and 19 subtests passed.
- Bundled skill metadata check: Pass, scanned 12 skill files, 0 errors, 0 warnings.
- Knowledge check: Pass, scanned 43 markdown files, checked 35 knowledge artifacts, 0 errors, 0 warnings.

## Artifacts

- `scripts/knowledge_check.py`
- `skills/using-harness/scripts/knowledge_check.py`
- `templates/FEATURE.md`
- `skills/using-harness/assets/templates/FEATURE.md`
- `skills/using-harness/SKILL.md`
- `skills/harness-start-gate/SKILL.md`
- `skills/harness-knowledge-capture/SKILL.md`
- `skills/harness-knowledge-retrieval/SKILL.md`
- `skills/harness-knowledge-capture/references/artifact-decision-matrix.md`
- `skills/harness-knowledge-capture/references/bugfix-attribution-and-patch-churn.md`
- `docs/features/INDEX.md`
- `docs/features/F009-feature-intake-governance.md`
- `docs/features/F010-goal-driven-feature-flow.md`
- `tests/test_goal_driven_feature_flow.py`
- `tests/test_knowledge_check.py`
- `tests/test_skill_progressive_disclosure.py`

## Notes

This sync keeps Harness public naming and repository identity. It backports the generic governance logic only: Feature Intake, Decision Context, Feature Index coarse retrieval, Goal-driven Feature Flow, and Empty Approval Guard.
