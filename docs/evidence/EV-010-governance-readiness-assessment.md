---
id: EV-010
doc_kind: evidence
scope: feature
feature_refs: [docs/features/F007-governance-readiness-assessment.md]
created: 2026-06-10
updated: 2026-06-10
---

# EV-010: Governance Readiness Assessment

## Scope

Validate F007: Harness readiness routing covers general governance status questions without importing upstream branding or changing public skill names.

## Commands

```text
python -m unittest tests.test_skill_progressive_disclosure.SkillProgressiveDisclosureTests.test_readiness_dashboard_trigger_covers_progress_gap_language
python -m pytest -q
python skills\using-harness\scripts\skill_metadata_check.py --root . --skills-path skills --strict
python skills\using-harness\scripts\knowledge_check.py --root . --docs-path docs --strict
```

## Results

- Targeted readiness trigger test: Pass, `1 test` passed.
- Full pytest suite: Pass, `81 passed`.
- Bundled skill metadata check: Pass, scanned 12 skill files, 0 errors, 0 warnings.
- Knowledge check: Pass, scanned 37 markdown files, checked 30 knowledge artifacts, 0 errors, 0 warnings.

## Harness Validation

```text
python skills\using-harness\scripts\knowledge_check.py --root . --docs-path docs --strict
Scanned 37 markdown file(s). Checked 30 knowledge artifact(s). Errors: 0. Warnings: 0.
```

## Artifacts

- `skills/harness-readiness-dashboard/SKILL.md`
- `skills/using-harness/SKILL.md`
- `skills/using-harness/references/routing.md`
- `tests/test_skill_progressive_disclosure.py`
- `docs/features/F007-governance-readiness-assessment.md`
- `docs/evidence/EV-010-governance-readiness-assessment.md`
- `docs/skill-index.md`
- `docs/workflow.md`

## Notes

This batch intentionally backports only the generic governance rule: readiness can answer progress, maturity, distance-to-target, roadmap-gap, delivery-gap, and blocker questions. It does not backport upstream brand rename, semantic short-skill rename, or governance article.
