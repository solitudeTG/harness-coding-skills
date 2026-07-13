# Quickstart

Harness is a **Codex / Claude Code Skill suite** with optional hook examples for Codex, Claude Code, and OpenCode. Install the Skill directories first, then add the project templates you need.

## Install Skills

From the repository root:

```bash
bash scripts/install.sh codex
bash scripts/install.sh --verify codex
```

For Claude Code:

```bash
bash scripts/install.sh claude
bash scripts/install.sh --verify claude
```

Windows PowerShell:

```powershell
.\scripts\install.ps1 both
.\scripts\install.ps1 -Verify both
```

Restart your agent after installation. Use `using-harness` as the entrypoint.

The installer verifies the formal Harness Skill slugs and bundled resources after copying. Set `HARNESS_CODEX_SKILLS_DIR` or `HARNESS_CLAUDE_SKILLS_DIR` when a test, CI job, or agent sandbox must avoid the real global Skill directories.

## Optional Hooks

Skills-only install remains valid. Hooks are optional runtime checks. Default examples enable only the Stop hook so completion claims can be checked without slowing down every edit.

Examples live under:

```text
using-harness/hooks/
```

If hook setup fails, remove the hook config and continue with the Skill workflow.

Harness no longer provides default `pre-compact` / `session-start` recovery hooks. Platform compaction remains the platform's responsibility. Use explicit handoff notes only when the user asks for handoff or an unfinished task is intentionally paused.

For Codex, verify hook runtime evidence after installation:

```bash
python ~/.codex/skills/using-harness/scripts/hook_diagnostics.py codex --project-root /path/to/project
```

If the diagnostic reports a Stop runner warning, keep using Skills-only closeout until the hook path is fixed on that machine.

## Minimal Harness

Copy the bundled `AGENTS.md` template into your project and fill in:

- Project rules agents must follow.
- When non-trivial work must pass Start Gate before coding.
- Verification commands.
- Evidence expectations.

This gives the project a shared operating surface outside a single prompt.

## Project Harness

When work spans multiple sessions or contributors, add:

```text
docs/BACKLOG.md
docs/features/
docs/decisions/
docs/lessons/
docs/evidence/
```

Use the bundled templates from `using-harness/assets/templates/`:

```text
using-harness/assets/templates/FEATURE.md
using-harness/assets/templates/ADR.md
using-harness/assets/templates/LESSON.md
using-harness/assets/templates/EVIDENCE.md
```

## Validate Knowledge Artifacts

Validate Skill metadata:

```bash
python scripts/skill_metadata_check.py --root . --skills-path skills
```

Run:

```bash
python skills/using-harness/scripts/knowledge_check.py --root . --docs-path docs
```

Use strict mode for review or CI gates:

```bash
python scripts/skill_metadata_check.py --root . --skills-path skills --strict
python skills/using-harness/scripts/knowledge_check.py --root . --docs-path docs --strict
```

## Stop Rule

Do not create Harness artifacts just to look disciplined.

Create the smallest artifact that prevents future confusion, repeated mistakes, or unverifiable completion.
