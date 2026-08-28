---
id: F008
doc_kind: feature
status: completed
created: 2026-06-10
updated: 2026-06-10
---

# F008: 文档安装示例一致性收口

## Goal

让公开 README、英文 README、INSTALL、workflow、skill index 和 examples 对 Harness readiness 能力保持一致描述，尤其是批次 3 新增的 progress、maturity、gap、distance-to-target 与 blocker 状态评估。

## Vision Anchor

- 原始请求或来源：批次 4 要收口文档、安装和示例一致性，同时保持 solitude 仓品牌独立。
- 用户痛点或工程问题：如果 README/INSTALL/示例仍只说 review/release/handoff/completion，用户问“整体进展、成熟度、还差多少、阻塞在哪里”时，Agent 可能不会稳定路由到 `harness-readiness-dashboard`。
- 期望结果：公开文档、安装说明、示例和 workflow 都把 `harness-readiness-dashboard` 描述为 readiness、progress、maturity、gap、distance-to-target 和 blocker 状态汇总入口。
- 非目标或边界：不改 hook runtime；不改 skill slug；不引入上游品牌文章或命名迁移。
- Exit Gate 对照来源：EV-011、文档一致性测试、全量 pytest、metadata check、knowledge check。


## Feature Intake

- Original problem: See Vision Anchor.
- User pain point: See Vision Anchor.
- Capability promise: Preserve the capability described by this Feature.
- Non-goals: See Vision Anchor non-goals or boundaries.
- Acceptance source: Acceptance Criteria and linked Evidence.
- Open questions: none known.

## Capability Contract

- Maintain the current capability boundary described by this Feature.

## Decision Context

### Why

This Feature preserves durable recovery context for `F008: 文档安装示例一致性收口`.

### Why Not

Do not replace this Feature with chat-only memory; future agents need a stable source of truth.

### If Modifying This Area, Check

- This Feature's Acceptance Criteria, Acceptance Map, Evidence, and Patch History.
- Linked ADR, Lesson, Evidence, and related specs or plans.

## Current Status

Done。README、README.en、INSTALL、docs/workflow 和两个 examples 已同步 readiness 扩展语义，并新增文档一致性测试防止未来回退。

## Links

- [EV-011 Doc Install Example Consistency](../evidence/EV-011-doc-install-example-consistency.md)
- [EV-024 Install Script Verification](../evidence/EV-024-install-script-verification.md)

### Evidence

See linked Evidence in this Feature, if present.

### Decisions / ADRs

None recorded.

### Lessons

None recorded.

### Specs / Plans

None recorded.

### Related Features

None recorded.

### External Context

None recorded.

## Acceptance Criteria

- [x] README 和 README.en 的 Skill 列表、典型流程与仓库能力说明覆盖 progress、maturity、gap。
- [x] INSTALL 明确安装后可用 `harness-readiness-dashboard` 查询 readiness、progress、maturity、gap、distance-to-target 和 blocker。
- [x] docs/workflow 使用正式 skill slug，而不是只写自然语言 dashboard。
- [x] minimal 和 project examples 都说明何时使用 `harness-readiness-dashboard`。
- [x] 文档一致性测试检查公开 Markdown 的 readiness 触发表面和仓库内链接。
- [x] 验证命令通过后再提交。


## Acceptance Map

| Claim | Acceptance | Evidence | Status |
| --- | --- | --- | --- |
| F008: 文档安装示例一致性收口 remains recoverable | Acceptance Criteria describe the expected state | Linked Evidence or this Feature history | active |

## State Timeline

| Date | State | Trigger | Evidence | Note |
| --- | --- | --- | --- | --- |
| 2026-06-26 | active | Feature governance migration | This Feature | Added recall and recovery structure |

## Patch History

None yet.

## Evidence

[EV-011 Doc Install Example Consistency](../evidence/EV-011-doc-install-example-consistency.md)

[EV-024 Install Script Verification](../evidence/EV-024-install-script-verification.md)


## Recovery Snapshot

- Read first: this Feature page.
- Current capability state: see Current Status.
- Known risks: see Patch History and linked Evidence.
- Next safe action: follow Next Step after running required gates.
- Unblock condition: not blocked unless Current Status says otherwise.

## Next Step

后续新增公开入口文档时，把 `tests/test_documentation_consistency.py` 扩展到新文件，避免示例与正式 Skill 能力再次漂移。





