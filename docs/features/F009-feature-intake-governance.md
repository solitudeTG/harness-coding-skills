---
id: F009
doc_kind: feature
status: completed
created: 2026-06-26
updated: 2026-06-26
---

# F009: Feature Intake Governance

## Goal

让 Harness Feature 从简略功能记录升级为长期治理入口：创建或重大更新 Feature 前先完成 Intake，并让 Feature 打开后能回答能力边界、决策背景、验收证据、状态变化和恢复入口。

## Vision Anchor

- 原始请求或来源：上游项目已新增 Feature recall / intake / decision-context 治理能力，用户要求同步到 solitude 仓，保持逻辑一致但品牌独立。
- 用户痛点或工程问题：Feature 如果只记录目标和 Patch History，后续 Agent 仍会不知道为什么这样设计、哪些方案被拒绝、验收证据在哪里、修改前该检查什么。
- 期望结果：Feature 模板、Knowledge Capture、Start Gate、Knowledge Retrieval 和 knowledge_check 都把 Feature Intake、Decision Context、Acceptance Map、State Timeline、Recovery Snapshot 作为可验证结构。
- 非目标或边界：不切换 solitude 品牌；不引入上游短 slug；不把 Feature 变成完整 spec、plan 或执行日志容器。
- Exit Gate 对照来源：EV-012、`tests/test_knowledge_check.py`、`tests/test_goal_driven_feature_flow.py`、`knowledge_check.py --strict`。

## Feature Intake

- Original problem: Feature 记忆缺少写入前澄清和打开后的修改决策上下文。
- User pain point: 后续 Agent 容易把未澄清需求写成长期记忆，或在修改时重复已经拒绝的方案。
- Capability promise: Harness 会要求 Feature 具备 Intake、能力边界、决策上下文、验收映射、状态时间线和恢复快照。
- Non-goals: 不复制上游品牌结构，不把 Feature 扩张成完整 spec/plan/log。
- Acceptance source: EV-012 和本仓测试。
- Open questions: 是否未来拆出独立 `harness-feature-intake` Skill，等待真实使用反馈后决定。

## Capability Contract

- `templates/FEATURE.md` 和 bundled `using-harness/assets/templates/FEATURE.md` 包含新版 Feature 结构。
- `knowledge_check.py` 校验 Feature Intake、Decision Context、Acceptance Map、Recovery Snapshot 和 completed/blocked 状态约束。
- Start Gate 在 Feature Intake 缺失时要求澄清，而不是写入猜测。
- Knowledge Retrieval 优先用 `docs/features/INDEX.md` 或文件名粗召回，再打开 1-3 个候选 Feature。

## Decision Context

### Why

代码说明系统现在如何运行；Feature 需要说明为什么系统应该这样运行，以及后续修改前不能忘记什么。把 Intake、Decision Context 和 Recovery Snapshot 放进 Feature，可以让未来 Agent 在不读完整聊天记录的情况下恢复判断。

### Why Not

没有把所有 spec、plan、Evidence 或 handoff 内容复制进 Feature，因为那会让 Feature 膨胀为重复信息仓库。Feature 只作为治理入口，详细材料继续通过链接承载。

### If Modifying This Area, Check

- 同步根 `scripts/knowledge_check.py` 和 bundled `skills/using-harness/scripts/knowledge_check.py`。
- 同步根 `templates/FEATURE.md` 和 bundled `skills/using-harness/assets/templates/FEATURE.md`。
- 运行 `tests/test_knowledge_check.py` 和 `tests/test_goal_driven_feature_flow.py`。
- 确认没有引入上游品牌 slug 或外部账号信息。

## Current Status

Completed。Feature 模板、validator、Skill 热路径、测试和既有 Feature 文档均已迁移到新版结构。

## Links

- [EV-012 Feature Governance Sync](../evidence/EV-012-feature-governance-sync.md)
- [Feature Index](INDEX.md)

## Acceptance Criteria

- [x] Feature 模板包含 Feature Intake、Capability Contract、Decision Context、Acceptance Map、State Timeline、Recovery Snapshot。
- [x] knowledge_check 拒绝缺失 Feature Intake、Decision Context、完成态验收无 Evidence、blocked Feature 无 unblock condition。
- [x] Knowledge Retrieval 先使用 Feature Index 或文件名粗召回，再打开 1-3 个候选 Feature。
- [x] 既有 Feature 文档通过严格 knowledge_check。

## Acceptance Map

| Claim | Acceptance | Evidence | Status |
| --- | --- | --- | --- |
| Feature 结构支持长期治理 | 模板和现有 Feature 均包含新版必备区块 | [EV-012](../evidence/EV-012-feature-governance-sync.md) | completed |
| Validator 固化 Feature 结构 | 新增知识校验测试并通过 | [EV-012](../evidence/EV-012-feature-governance-sync.md) | completed |
| Feature 召回先粗后细 | Feature Index 和 retrieval 文案要求先选 1-3 个候选 | [EV-012](../evidence/EV-012-feature-governance-sync.md) | completed |

## State Timeline

| Date | State | Trigger | Evidence | Note |
| --- | --- | --- | --- | --- |
| 2026-06-26 | completed | solitude 同步 Feature governance | [EV-012](../evidence/EV-012-feature-governance-sync.md) | 回迁通用逻辑，保留 Harness 品牌。 |

## Patch History

None yet.

## Evidence

[EV-012 Feature Governance Sync](../evidence/EV-012-feature-governance-sync.md)

## Recovery Snapshot

- Read first: this Feature page, then EV-012.
- Current capability state: completed; Feature Intake and Decision Context are required Feature structure.
- Known risks: 既有 Feature 的新增结构是简洁迁移，不重写历史事实。
- Next safe action: 用真实 Feature 创建/修改场景观察是否还需要独立 Feature Intake Skill。
- Unblock condition: not blocked.

## Next Step

后续如果 Agent 仍跳过 Feature Intake 或继续粗暴阅读全部 Feature，再补更强 routing fixture 或单独 Skill。
