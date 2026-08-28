---
id: EV-025
doc_kind: evidence
feature_refs:
  - F017-harness-vnext-gpt56-workflow
scope: Harness vNext initial implementation slice
created: 2026-08-27
---

# EV-025: Harness vNext 初始实现验证

## Supports Claim

Harness vNext 的六个 Skill 表面、统一工程 Index、文档 Schema、安装器和替换后的行为测试已在 solitude 的迁移分支中实现；旧 12 Skill 与旧默认 Hook 不再属于运行时表面。

## Verification Scope

覆盖 Skill 元数据、vNext 文档校验、统一 Index、临时安装目标以及 Python 测试套件。未覆盖真实历史任务的语义选择质量或端到端耗时比较。

## Checks

```text
python -m py_compile scripts\generate_index.py scripts\knowledge_check.py scripts\skill_metadata_check.py
python -m unittest tests.test_skills tests.test_generate_index tests.test_install_scripts tests.test_knowledge_check
python -m pytest -q
python scripts/skill_metadata_check.py --root . --strict
python scripts/generate_index.py --root . --check
python scripts/knowledge_check.py --root . --docs-path docs --strict
git diff --check
```

## Results

Pass：8 项测试通过；Skill 元数据、统一 Index 和 vNext 知识文档校验均通过；Python 编译与 diff 空白检查通过。当前机器的 Bash 指向不可用的 WSL runtime，因此 Bash 安装器语法检查留给 Ubuntu CI 执行。

## Artifacts

- `skills/harness/scripts/knowledge_check.py`
- `skills/harness/scripts/generate_index.py`
- `tests/test_knowledge_check.py`
- `tests/test_install_scripts.py`
- `tests/test_skills.py`

## Limitations

这不是性能 Evidence，也不证明真实 Agent 的语义选择质量。当前测试使用合成的最小文档夹；尚未建立 10–20 个真实历史变更的关键召回、误召回、文本量、工具调用数和端到端时间基准。
