---
id: F003
doc_kind: feature
status: completed
created: 2026-05-30
updated: 2026-05-31
---

# F003: Optional Harness Hook Runtime

## Goal

Add an optional hook runtime for Harness so Codex, Claude Code, and OpenCode can run deterministic checks after Harness artifact edits and before completion claims, while the existing Skill-only installation remains fully usable when hook configuration fails or is disabled.

## Vision Anchor

- Original request or source: The user approved evolving Harness from Skill-only prompt constraints toward a Skill + Hook plugin shape.
- User pain point or engineering problem: Harness Skills can tell agents what to do, but agents may still use completion language before a valid closeout block.
- Desired outcome: First slice provides hard `Stop` completion checks backed by existing `using-harness/scripts/` validators, with fail-open behavior for hook installation/runtime errors. PostToolUse remains available only as an explicit experiment, not a default hook.
- Non-goals or boundaries: Do not replace Harness Skills, do not encode Start Gate or ADR judgment in hook logic, and do not make hook installation a prerequisite for installing or using Skills.
- Exit Gate source: This Feature page, hook runner tests, updated install docs, and the final verification output.


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

This Feature preserves durable recovery context for `F003: Optional Harness Hook Runtime`.

### Why Not

Do not replace this Feature with chat-only memory; future agents need a stable source of truth.

### If Modifying This Area, Check

- This Feature's Acceptance Criteria, Acceptance Map, Evidence, and Patch History.
- Linked ADR, Lesson, Evidence, and related specs or plans.

## Current Status

Done. The optional hook runtime is bundled under `skills/using-harness/hooks/`, tested, and documented as an enhancement that does not replace Skills-only installation. F005 adds the second default slice for session recovery.

## Links

- [F001 Closeout Entry And Vision Anchor Validation](F001-closeout-entry-anchor-validation.md)
- [F002 Canonical Harness Artifact Placement](F002-canonical-harness-artifact-placement.md)
- [ADR-006 Skill Progressive Disclosure Boundary](../decisions/ADR-006-skill-progressive-disclosure-boundary.md)
- [LL-002 Skill Hot Path Constraints Must Stay Visible](../lessons/LL-002-skill-hot-path-constraints.md)
- [LL-004 Verify Codex Hook Schema Before Reinstalling Plugin Cache](../lessons/LL-004-codex-hook-plugin-schema-before-cache.md)
- [F005 Session Recovery Hooks](F005-session-recovery-hooks.md)
- [EV-006 Optional Harness Hook Runtime](../evidence/EV-006-optional-harness-hook-runtime.md)
- [EV-008 Session Recovery Hooks](../evidence/EV-008-session-recovery-hooks.md)

## Acceptance Criteria

- [x] Default hook examples do not wire `PostToolUse`; the runner keeps `post-tool-use` only as an explicit experimental mode.
- [x] `Stop` hook behavior detects completion claims and blocks or continues when the final message lacks a structurally valid Harness closeout block.
- [x] Hook runner failures caused by missing hook dependencies, missing docs roots, or platform JSON differences fail open with a warning instead of breaking Skill-only workflows.
- [x] Hook resources are bundled under `skills/using-harness/` so Skill installation owns the script resources and hook installation can remain optional.
- [x] Installation documentation explains Basic install as Skills-only and Enhanced install as Skills + Hooks for Codex, Claude Code, and OpenCode.
- [x] Session recovery hooks write local runtime context before compaction and expose it at session start without replacing Harness Skills.


## Acceptance Map

| Claim | Acceptance | Evidence | Status |
| --- | --- | --- | --- |
| F003: Optional Harness Hook Runtime remains recoverable | Acceptance Criteria describe the expected state | Linked Evidence or this Feature history | active |

## State Timeline

| Date | State | Trigger | Evidence | Note |
| --- | --- | --- | --- | --- |
| 2026-06-26 | active | Feature governance migration | This Feature | Added recall and recovery structure |

## Patch History

None yet

| Patch | Date | Commit | Symptom | Root Cause | Protection | Status |
| --- | --- | --- | --- | --- | --- | --- |

## Evidence

[EV-006 Optional Harness Hook Runtime](../evidence/EV-006-optional-harness-hook-runtime.md)


## Recovery Snapshot

- Read first: this Feature page.
- Current capability state: see Current Status.
- Known risks: see Patch History and linked Evidence.
- Next safe action: follow Next Step after running required gates.
- Unblock condition: not blocked unless Current Status says otherwise.

## Next Step

Use the Stop and session recovery slices in local plugin trials for Codex, Claude Code, and OpenCode before tightening platform-specific adapters.
