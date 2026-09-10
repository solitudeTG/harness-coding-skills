---
id: EV-027
doc_kind: evidence
feature_refs:
  - F017-harness-vnext-gpt56-workflow
scope: Harness Feature interaction intent specification and conditional runtime guidance
created: 2026-09-11
---

# EV-027: Feature 交互意图实现验证

## Supports Claim

Harness vNext 已将三段式 `Interaction Intent` 作为条件化的 Feature 规格：用户可感知的流程变更会被主 Skill 指向该契约；它不会新增默认 Gate、Skill 或独立知识文档类型。

## Verification Scope

覆盖 Feature 模板、`harness` 的条件化指引、`harness-intent` 的冲突边界、ADR/Feature 链接、Index 再生成、Skill 元数据、知识文档结构和自动化测试。未覆盖真实用户任务中的可用性、Agent 对触发条件的长期一致性，或具体产品的 E2E 体验。

## Checks

```text
python scripts/generate_index.py --root . --check
python scripts/knowledge_check.py --root . --docs-path docs --strict
python scripts/skill_metadata_check.py --root . --strict
python -m pytest -q
git diff --check
```

## Results

Pass：在干净 Git worktree 中，Python 编译通过；统一 Index 为当前生成结果；vNext 文档与 Skill 元数据校验均为 0 errors；自动化测试 9 项通过；diff 空白检查通过。当前机器的 Bash runtime 不可用，Bash 安装器语法由 GitHub Ubuntu CI 覆盖。

## Artifacts

- `docs/decisions/ADR-012-feature-interaction-intent.md`
- `skills/harness/SKILL.md`
- `skills/harness-intent/SKILL.md`
- `skills/harness/assets/templates/FEATURE.md`
- `templates/FEATURE.md`
- `tests/test_skills.py`

## Limitations

本 Evidence 证明仓库内的规格、指引和结构校验已接入，不证明每个后续 Agent 都会正确区分“实质旅程变化”与视觉润色。真实项目应对关键流程追加相应的验收场景，以及按风险选择 E2E、人工走查、截图或原型 Evidence。
