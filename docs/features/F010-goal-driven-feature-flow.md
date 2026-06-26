---
id: F010
doc_kind: feature
status: completed
created: 2026-06-26
updated: 2026-06-26
---

# F010: Goal Driven Feature Flow

## Goal

把默认逐 Feature 设计审批收敛为 Goal 驱动执行：用户已经给出清晰 Goal 后，Agent 可以在 Goal 范围内连续创建或更新 Feature 记忆并推进实现；只有目标不清、范围越界、重大取舍、验收冲突或 patch churn 时才回问用户。

## Vision Anchor

- 原始请求或来源：上游项目新增 Goal-driven Feature Flow 和 Empty Approval Guard，用户要求同步通用逻辑到 solitude。
- 用户痛点或工程问题：要求用户批准不存在或未展示的 Feature/design/plan，会把工程记忆误当成审批关卡，也会打断连续开发。
- 期望结果：`using-harness`、`harness-start-gate` 和 `harness-knowledge-capture` 明确 Goal 是授权边界，Feature 是工程记忆，不默认逐 Feature 设计审批。
- 非目标或边界：不移除 closeout/knowledge-capture 完成门禁；不新增复杂状态机；不把 Hook 变成 Start Gate 或 Feature ownership 判断器。
- Exit Gate 对照来源：EV-012、`tests/test_goal_driven_feature_flow.py`、全量 pytest。

## Feature Intake

- Original problem: Agent 可能要求用户批准不存在或未展示的设计。
- User pain point: 用户无法审批空 artifact，且逐 Feature 暂停会破坏 Goal 范围内的连续开发。
- Capability promise: Harness 明确 Goal 授权边界和 Empty Approval Guard。
- Non-goals: 不取消完成声明前的 Evidence/closeout 门禁。
- Acceptance source: EV-012 和 Goal-driven regression tests。
- Open questions: 是否未来需要 Goal Intake 模板，等待真实使用反馈后决定。

## Capability Contract

- 清晰 Goal 授权范围内，Agent 可连续拆分并推进多个 Feature。
- 非平凡工作仍需创建或更新 Feature 记忆，用于恢复、验收、Evidence 和 Patch History。
- 默认不要求用户逐 Feature 审批设计。
- 只有 Goal 缺失/模糊、Feature 越界、重大取舍、验收冲突或 patch churn 时才 ask user。

## Decision Context

### Why

Goal 是用户授权边界。Feature 是工程记忆，不是审批关卡。把两者混在一起会让 Agent 在没有真实 artifact 的情况下请求“批准设计”，反而降低推进效率和可追溯性。

### Why Not

没有删除 closeout 门禁，因为 Goal 授权只回答“能否推进”，不回答“是否完成且有证据”。完成声明仍由 Knowledge Capture 和 Evidence 约束。

### If Modifying This Area, Check

- `using-harness` 的 Goal-Driven Feature Flow。
- `harness-start-gate` 的 Goal-Driven Feature Flow 和 Empty Approval Guard。
- `harness-knowledge-capture` 是否仍拥有 closeout/completion permission。
- `tests/test_goal_driven_feature_flow.py`。

## Current Status

Completed。Goal-driven flow 和 Empty Approval Guard 已进入 Harness 热路径，并由测试覆盖。

## Links

- [EV-012 Feature Governance Sync](../evidence/EV-012-feature-governance-sync.md)
- [F009 Feature Intake Governance](F009-feature-intake-governance.md)

## Acceptance Criteria

- [x] `using-harness` 明确 Goal 是用户授权边界。
- [x] `harness-start-gate` 明确 Feature 记忆不是用户审批 checkpoint。
- [x] `harness-knowledge-capture` 保留 closeout/completion permission。
- [x] Empty Approval Guard 禁止请求用户批准不存在或未展示的 artifact。

## Acceptance Map

| Claim | Acceptance | Evidence | Status |
| --- | --- | --- | --- |
| Goal 替代默认逐 Feature 审批 | Skill 热路径和测试包含 Goal/Feature/approval guard 契约 | [EV-012](../evidence/EV-012-feature-governance-sync.md) | completed |
| closeout 门禁保留 | Knowledge Capture completion permission 文案保留 | [EV-012](../evidence/EV-012-feature-governance-sync.md) | completed |

## State Timeline

| Date | State | Trigger | Evidence | Note |
| --- | --- | --- | --- | --- |
| 2026-06-26 | completed | solitude 同步 Goal-driven flow | [EV-012](../evidence/EV-012-feature-governance-sync.md) | 默认设计审批移除，Feature 作为记忆保留。 |

## Patch History

None yet.

## Evidence

[EV-012 Feature Governance Sync](../evidence/EV-012-feature-governance-sync.md)

## Recovery Snapshot

- Read first: this Feature page, then EV-012.
- Current capability state: completed; Goal-driven Feature flow is in primary Skill text.
- Known risks: Goal Intake 仍是会话层判断，不是独立模板。
- Next safe action: 观察真实多 Feature 任务是否仍过度请求审批。
- Unblock condition: not blocked.

## Next Step

若后续再次出现“批准不存在的 Fxxx 设计”或每个 Feature 都停下审批，优先补 routing fixture 和 tests，而不是新增状态机。
