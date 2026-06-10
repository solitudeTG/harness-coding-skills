---
id: EV-011
doc_kind: evidence
scope: feature
feature_refs: [docs/features/F008-doc-install-example-consistency.md]
created: 2026-06-10
updated: 2026-06-10
---

# EV-011: Doc Install Example Consistency

## Scope

验证 F008：公开文档、安装说明、workflow 和 examples 对 `harness-readiness-dashboard` 的 progress、maturity、gap、distance-to-target 与 blocker 触发表面保持一致，且仓库内 Markdown 链接可解析。

## Commands

```text
python -m unittest tests.test_documentation_consistency
python -m pytest -q
python skills\using-harness\scripts\skill_metadata_check.py --root . --skills-path skills --strict
python skills\using-harness\scripts\knowledge_check.py --root . --docs-path docs --strict
```

## Results

- Documentation consistency tests: Pass, 2 tests passed.
- Full pytest suite: Pass, 83 tests and 19 subtests passed.
- Bundled skill metadata check: Pass, scanned 12 skill files, 0 errors, 0 warnings.
- Knowledge check: Pass, scanned 39 markdown files, checked 32 knowledge artifacts, 0 errors, 0 warnings.

## Harness Validation

```text
python skills\using-harness\scripts\knowledge_check.py --root . --docs-path docs --strict
Scanned 39 markdown file(s). Checked 32 knowledge artifact(s). Errors: 0. Warnings: 0.
```

## Artifacts

- `README.md`
- `README.en.md`
- `INSTALL.md`
- `docs/workflow.md`
- `examples/minimal-harness/README.md`
- `examples/project-harness/README.md`
- `tests/test_documentation_consistency.py`
- `docs/features/F008-doc-install-example-consistency.md`
- `docs/evidence/EV-011-doc-install-example-consistency.md`

## Notes

本批次只收口文档、安装和示例层的一致性。Hook runtime、Skill slug、品牌身份和脚本行为保持不变。
