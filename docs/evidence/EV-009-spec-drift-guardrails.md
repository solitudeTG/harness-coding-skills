---
id: EV-009
doc_kind: evidence
scope: feature
feature_refs: [docs/features/F006-spec-drift-guardrails.md]
created: 2026-06-08
updated: 2026-06-08
---

# EV-009: Spec Drift Guardrails

## Scope

验证 F006：Harness 已新增 Spec Drift Guardrails，并能在旧 spec / acceptance criteria 被真实案例、验证失败或用户反馈挑战时，把 Agent 从继续局部打补丁分流到 `harness-spec-drift` 判断。

## Commands

```text
python -m pytest tests/test_spec_drift_guardrails.py -q
python scripts\skill_metadata_check.py --root . --skills-path skills --strict
python skills\using-harness\scripts\skill_metadata_check.py --root . --skills-path skills --strict
python -m pytest -q
python skills\using-harness\scripts\knowledge_check.py --root . --docs-path docs --strict
```

## Results

- Targeted Spec Drift tests: Pass, `6 passed`.
- Root `skill_metadata_check.py --strict`: Pass, scanned 12 skill files, 0 errors, 0 warnings.
- Bundled `using-harness/scripts/skill_metadata_check.py --strict`: Pass, scanned 12 skill files, 0 errors, 0 warnings.
- Full pytest suite: Pass, `80 passed`.
- `knowledge_check.py --strict`: Pass, scanned 35 markdown files, checked 28 knowledge artifacts, 0 errors, 0 warnings.

## Harness Validation

```text
python skills\using-harness\scripts\knowledge_check.py --root . --docs-path docs --strict
Scanned 35 markdown file(s). Checked 28 knowledge artifact(s). Errors: 0. Warnings: 0.
```

## Artifacts

- `skills/harness-spec-drift/SKILL.md`
- `skills/harness-spec-drift/references/spec-drift-decision-rules.md`
- `skills/using-harness/SKILL.md`
- `skills/harness-start-gate/SKILL.md`
- `skills/harness-start-gate/references/start-gate-decision-rules.md`
- `skills/harness-start-gate/references/bug-intake-and-patch-churn.md`
- `skills/harness-vision-gate/SKILL.md`
- `scripts/skill_metadata_check.py`
- `skills/using-harness/scripts/skill_metadata_check.py`
- `tests/test_spec_drift_guardrails.py`
- `README.md`
- `README.en.md`
- `INSTALL.md`
- `docs/skill-index.md`

## Notes

本轮增强刻意保持克制：Start Gate 只识别并分流 Spec Drift 风险；Vision Gate 继续守护原始目标；Spec Drift 只判断 spec 是否仍可信。AGENTS 规则仍由用户手动复制和维护，避免把 Harness 从辅助治理能力变成侵入式项目配置接管。
