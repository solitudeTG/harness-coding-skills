---
id: EV-028
doc_kind: evidence
feature_refs:
  - F017-harness-vnext-gpt56-workflow
scope: Harness vNext cross-repository isomorphic synchronization
created: 2026-09-11
---

# EV-028: vNext 同构同步验证

## Supports Claim

Harness 的 `vnext` 分支已同步至固定上游 `main` 基线所包含的 v2 检索边界、条件化交互意图和 CI 修复；运行时保持同构，品牌、公开文档结构、安装变量与历史归档保持本仓独立。

## Verification Scope

覆盖六个 vNext Skill、脚本、测试、CI 工作流、交互意图契约及公开使用说明。安装器仅允许保留清理本仓历史 Skill 名称和使用 `HARNESS_*` 环境变量的差异。未覆盖 GitHub Actions 的实际 Ubuntu 执行结果或真实历史任务的语义选择质量。

## Checks

```text
python -m py_compile scripts\generate_index.py scripts\knowledge_check.py scripts\skill_metadata_check.py
python -m pytest -q
python scripts\skill_metadata_check.py --root . --skills-path skills --strict
python scripts\generate_index.py --root . --check
python scripts\knowledge_check.py --root . --docs-path docs --strict
git diff --check
normalized runtime comparison against the fixed upstream main baseline
git log solitude/vnext --format="%an <%ae>|%cn <%ce>"
```

## Results

Pass：在干净 Git worktree 中，Python 编译通过，9 项测试通过，Skill 元数据、Index 与知识文档校验均为 0 errors，空白检查通过。23 个核心运行时文件完成归一化对照；仅安装器及其测试保留本仓历史清理和环境变量差异。活跃内容未检出上游品牌标识；远端 `vnext` 可达提交的作者与提交者均为 `solitudeTG` 的 GitHub noreply 身份。

## Artifacts

- `b2882a8`: CI 测试依赖与调用修复。
- `146c403`: Feature 交互意图契约、测试与 Evidence。
- `707b746`: 检索边界和公开文档说明。
- `docs/decisions/ADR-012-feature-interaction-intent.md`
- `skills/harness/SKILL.md`
- `skills/harness-intent/SKILL.md`

## Limitations

当前机器的 Bash runtime 不可用，因此 `bash -n scripts/install.sh` 和 Bash 安装流程由 GitHub Ubuntu CI 覆盖。该同步不宣称真实历史任务上的召回质量或端到端性能已经改善；这些仍需要 F017 约定的真实样本基准。
