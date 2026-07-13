---
id: EV-024
doc_kind: evidence
scope: feature
feature_refs:
  - docs/features/F008-doc-install-example-consistency.md
  - docs/features/F015-stop-only-hook-runtime.md
created: 2026-07-13
---

# EV-024: Install Script Verification

## Supports Claim

Harness 的 Skills-only 安装入口已经具备可验收结果：安装脚本会在复制后验证 12 个正式 Skill 和关键 bundled 资源，并提供 `--verify` / `-Verify` 只读模式与目标目录环境变量覆盖，便于 Agent、测试和 CI 在不触碰真实全局目录的情况下检查安装结果。

## Verification Scope

覆盖 `scripts/install.ps1`、`scripts/install.sh`、安装脚本测试、公开安装说明和 `using-harness` 入口提示。验证检查正式 Skill、knowledge/closeout/metadata/hook validators、usage recorder、AGENTS 模板与可选 hook runner。

不覆盖真实 Codex Desktop 或 Claude Code 插件安装、真实平台 Stop hook lifecycle dispatch，也不覆盖当前机器不可用的 Bash runtime 实际执行。

## Checks

```text
python -m unittest tests.test_install_scripts
python -m pytest -q
python skills\using-harness\scripts\skill_metadata_check.py --root . --skills-path skills --strict
python skills\using-harness\scripts\knowledge_check.py --root . --docs-path docs --strict
git diff --check
```

## Results

- `python -m unittest tests.test_install_scripts`: passed 1 PowerShell test; Bash test skipped because the local Bash runtime is unusable.
- `python -m pytest -q`: passed 112 tests, skipped 2 tests, and passed 21 subtests.
- Skill metadata strict check: scanned 12 Skill files with 0 errors and 0 warnings.
- Knowledge strict check: scanned 61 Markdown files and checked 52 knowledge artifacts with 0 errors and 0 warnings.
- Brand scan found no upstream brand or upstream account identity strings in the implementation batch.

## Artifacts

- `scripts/install.ps1`
- `scripts/install.sh`
- `tests/test_install_scripts.py`
- `README.md`
- `README.en.md`
- `INSTALL.md`
- `docs/quickstart.md`
- `skills/using-harness/SKILL.md`
- `docs/features/F008-doc-install-example-consistency.md`
- `docs/features/F015-stop-only-hook-runtime.md`
- `docs/evidence/EV-024-install-script-verification.md`

## Limitations

本 Evidence 证明 PowerShell 安装、只读验证和仓库级回归结果；不证明当前机器上的 Bash 路径可执行，也不证明 Codex、Claude Code 或 OpenCode 的真实 hook lifecycle 已触发。Hooks 仍是可选增强，安装验证不能替代目标平台上的 `hook_diagnostics.py` 或 runtime trace。

## Notes

本次同步只迁移安装验收能力及其公开说明，没有复制上游品牌定位文章、账号级 usage 事件或提交身份。solitude 仓继续使用独立的 Harness 品牌、公开目录和 `solitudeTG` 提交身份。
