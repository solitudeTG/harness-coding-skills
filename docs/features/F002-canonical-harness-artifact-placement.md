---
id: F002
doc_kind: feature
status: completed
created: 2026-05-26
updated: 2026-05-26
---

# F002: Canonical Harness Artifact Placement

## Goal

让 Harness knowledge artifacts 使用稳定、可校验的 canonical 目录，避免 Agent 把 Superpowers spec/plan 路径和 Harness Feature/Evidence 语义混用后仍然通过校验。

## Vision Anchor

- 原始请求或来源：用户指出某次 Harness skill 会话沉淀的 Feature 没有使用 `F001` 编码，且路径落在 `docs/superpowers/**`，要求分析后优化 Harness skill 并同步到本机。
- 用户痛点或工程问题：`knowledge_check.py` 默认忽略 `doc_kind: spec`，同时接受 `docs/superpowers/evidence` 下的 Evidence，导致错误沉淀路径没有被闸门发现。
- 期望结果：带 `doc_kind` 的 Markdown 默认都被检查；Harness Feature、ADR、Lesson、Evidence 必须位于 canonical 目录；skill 文案明确 `docs/superpowers/**` 只能作为 legacy spec/plan 被链接。
- 非目标或边界：不迁移其他项目的历史文档，不把 Superpowers spec/plan 本身纳入 Harness artifact 类型，不引入项目级 registry。
- Exit Gate 对照来源：本 Feature 的 Acceptance Criteria、ADR-005、EV-003、`tests.test_knowledge_check.KnowledgeCheckPlacementTests`。


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

This Feature preserves durable recovery context for `F002: Canonical Harness Artifact Placement`.

### Why Not

Do not replace this Feature with chat-only memory; future agents need a stable source of truth.

### If Modifying This Area, Check

- This Feature's Acceptance Criteria, Acceptance Map, Evidence, and Patch History.
- Linked ADR, Lesson, Evidence, and related specs or plans.

## Current Status

Done。validator、bundled skill validator 和 Harness skill 文案已经更新；本机 Codex skills 已同步。

## Links

- [ADR-005 Canonical Harness Artifact Placement](../decisions/ADR-005-canonical-harness-artifact-placement.md)
- [ADR-006 Skill Progressive Disclosure Boundary](../decisions/ADR-006-skill-progressive-disclosure-boundary.md)
- [LL-002 Skill Hot Path Constraints Must Stay Visible](../lessons/LL-002-skill-hot-path-constraints.md)
- [EV-003 Canonical Artifact Placement](../evidence/EV-003-canonical-artifact-placement.md)
- [EV-004 Hot Path Harness Constraints](../evidence/EV-004-hot-path-harness-constraints.md)
- [EV-005 Skill Iteration Learning Docs](../evidence/EV-005-skill-iteration-learning-docs.md)
- [Guide: Harness Skill 迭代复盘](../guides/skill-iteration-lessons.md)

## Acceptance Criteria

- [x] `knowledge_check.py` 默认检查所有带 `doc_kind` frontmatter 的 Markdown。
- [x] `doc_kind: spec` 在默认校验中被拒绝，而不是只在 `--all-markdown` 下暴露。
- [x] `doc_kind: evidence` 放在 `docs/superpowers/evidence` 会被拒绝，并提示应放在 `docs/evidence/`。
- [x] root validator 与 bundled `skills/using-harness/scripts/knowledge_check.py` 行为一致。
- [x] `using-harness`、`harness-start-gate`、`harness-knowledge-capture` 明确禁止把 Harness artifacts 放进 `docs/superpowers/**`。
- [x] `scripts/install.ps1 codex` 可把更新后的 Harness skills 同步到本机 Codex skills。


## Acceptance Map

| Claim | Acceptance | Evidence | Status |
| --- | --- | --- | --- |
| F002: Canonical Harness Artifact Placement remains recoverable | Acceptance Criteria describe the expected state | Linked Evidence or this Feature history | active |

## State Timeline

| Date | State | Trigger | Evidence | Note |
| --- | --- | --- | --- | --- |
| 2026-06-26 | active | Feature governance migration | This Feature | Added recall and recovery structure |

## Patch History

| Patch | Date | Commit | Symptom | Root Cause | Protection | Status |
| --- | --- | --- | --- | --- | --- | --- |
| F002.1 | 2026-05-27 | pending | Agent could still follow Superpowers spec/plan naming during real development even though canonical Harness placement existed in validator and references. | 2026-05-26 slimming moved some action-changing constraints out of primary `SKILL.md` hot paths while trying to avoid session stalls; the actual stall root cause was elsewhere. | Restored Entry/Exit Gate, placement, template, task-class, risk-trigger, and patch-churn constraints in primary skill text; added a regression test and Feature template path hint. | Done |

## Evidence

[EV-003 Canonical Artifact Placement](../evidence/EV-003-canonical-artifact-placement.md)
[EV-004 Hot Path Harness Constraints](../evidence/EV-004-hot-path-harness-constraints.md)
[EV-005 Skill Iteration Learning Docs](../evidence/EV-005-skill-iteration-learning-docs.md)


## Recovery Snapshot

- Read first: this Feature page.
- Current capability state: see Current Status.
- Known risks: see Patch History and linked Evidence.
- Next safe action: follow Next Step after running required gates.
- Unblock condition: not blocked unless Current Status says otherwise.

## Next Step

若后续发现其他 legacy docs 路径仍能伪装为 Harness memory，通过本 Feature 的 Patch History 记录补丁，并优先补 validator 测试。
