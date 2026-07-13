# Install Harness Skills

Harness is distributed as a **Skill suite** with an optional hook runtime.

Basic install: Skills only. Install the directories under `skills/` into the skills directory used by your agent, then restart the agent so it can discover the new Skill metadata.

Enhanced install: Skills + optional Hooks. Default hook examples enable Stop-time completion checks only; hooks are not required for Harness to work.

Hook installation failure must not roll back Skills, block Skill loading, or make the Skill-only workflow unusable.

## Codex

Install globally with the helper script:

```bash
git clone https://github.com/solitudeTG/using-harness.git
cd using-harness
bash scripts/install.sh codex
bash scripts/install.sh --verify codex
```

Windows PowerShell:

```powershell
git clone https://github.com/solitudeTG/using-harness.git
Set-Location using-harness
.\scripts\install.ps1 codex
.\scripts\install.ps1 -Verify codex
```

Restart Codex after installation. In a project, mention Harness or ask the agent to use `using-harness`; the entrypoint Skill will route to the focused workflow skills such as `harness-start-gate` and `harness-readiness-dashboard` for progress, maturity, and gap checks.

Breaking rename note: the formal system name is `Harness`. The installed slugs are `using-harness` plus short semantic workflow slugs such as `harness-start-gate` and `harness-readiness-dashboard`; pre-rename skill directories should be removed before reinstalling this version. See `docs/skill-index.md` for the current skill list.

If your Codex environment has the skill installer available, you can also ask Codex to install this repository as a Skill source.

## Claude Code

Install globally with the helper script:

```bash
git clone https://github.com/solitudeTG/using-harness.git
cd using-harness
bash scripts/install.sh claude
bash scripts/install.sh --verify claude
```

Windows PowerShell:

```powershell
git clone https://github.com/solitudeTG/using-harness.git
Set-Location using-harness
.\scripts\install.ps1 claude
.\scripts\install.ps1 -Verify claude
```

Restart Claude Code after installation.

For project-local installation, copy the skills into the project:

```bash
mkdir -p .claude/skills
cp -R /path/to/using-harness/skills/* .claude/skills/
```

Claude Code expects each Skill to have this shape:

```text
<skills-root>/<skill-name>/SKILL.md
```

## Manual Install

If you do not want to run the helper script, copy the Skill directories directly.

Codex:

```bash
mkdir -p ~/.codex/skills
cp -R skills/* ~/.codex/skills/
```

Claude Code:

```bash
mkdir -p ~/.claude/skills
cp -R skills/* ~/.claude/skills/
```

Windows PowerShell:

```powershell
New-Item -ItemType Directory -Force "$HOME\.codex\skills", "$HOME\.claude\skills"
Copy-Item ".\skills\*" "$HOME\.codex\skills\" -Recurse -Force
Copy-Item ".\skills\*" "$HOME\.claude\skills\" -Recurse -Force
```

## Install Verification

The helper scripts install Skills only and verify the result by default. Verification checks that all formal Harness Skill slugs and the bundled validators, templates, usage recorder, and optional hook runner are present.

Run verification without copying files:

```bash
bash scripts/install.sh --verify codex
bash scripts/install.sh --verify claude
```

Windows PowerShell:

```powershell
.\scripts\install.ps1 -Verify codex
.\scripts\install.ps1 -Verify claude
```

For tests, CI, or agent sandbox installs, override the destination instead of touching real global Skill directories:

```bash
HARNESS_CODEX_SKILLS_DIR=/tmp/codex-skills bash scripts/install.sh codex
HARNESS_CLAUDE_SKILLS_DIR=/tmp/claude-skills bash scripts/install.sh claude
```

Windows PowerShell:

```powershell
$env:HARNESS_CODEX_SKILLS_DIR = "C:\tmp\codex-skills"
.\scripts\install.ps1 codex
$env:HARNESS_CLAUDE_SKILLS_DIR = "C:\tmp\claude-skills"
.\scripts\install.ps1 claude
```

## Optional Project Rules

Installing Skills teaches the agent workflows and installs bundled Harness scripts/templates under `using-harness/`. Adding `AGENTS.md` teaches project-specific operating rules.

Harness does not automatically modify global or project `AGENTS.md` files. You may copy the bundled `AGENTS.md` template when a project needs repository-level rules:

```bash
cp ~/.codex/skills/using-harness/assets/templates/AGENTS.md /path/to/your-project/AGENTS.md
```

Windows PowerShell:

```powershell
Copy-Item "$HOME\.codex\skills\using-harness\assets\templates\AGENTS.md" "C:\path\to\your-project\AGENTS.md"
```

Fill in:

```text
1. The project rules agents must always follow.
2. The verification command that proves the project still works.
3. Where completion evidence should be recorded.
```

Recommended additions:

```text
- Run Start Gate before non-trivial implementation.
- If real cases, validation, or user feedback contradict an existing spec, run Spec Drift before changing code.
- If repeated patches add scenario-specific branches, pause and run Patch Churn Review before continuing.
```

For longer-lived projects, add the optional Harness memory directories:

```text
docs/BACKLOG.md
docs/features/
docs/decisions/
docs/lessons/
docs/evidence/
```

## Optional Hook Runtime

The optional hook runner is bundled under:

```text
<skills-root>/using-harness/hooks/harness_hook.py
```

The runner calls the existing Skill-owned scripts:

```text
<skills-root>/using-harness/scripts/knowledge_check.py
<skills-root>/using-harness/scripts/harness_closeout_check.py
<skills-root>/using-harness/scripts/hook_diagnostics.py
```

For Codex plugin-bundled hooks, use the `Harness@personal` plugin identity and keep both root-level `hooks.json` and `hooks/hooks.json` available, with identical content, because Codex Desktop installations have shown different discovery evidence during local iteration. Enable both `[features].hooks = true` and `[features].plugin_hooks = true` before expecting runtime dispatch. The command should call `hooks/run-harness-hook.cmd`, which resolves the plugin root from the wrapper location and then runs `skills/using-harness/hooks/harness_hook.py`; on Windows, use `commandWindows` with `%PLUGIN_ROOT%` wrapped by `cmd /d /s /c` so it still works when Codex invokes the hook command through PowerShell. Do not call `python ./skills/...` directly from `hooks.json`, because the hook runtime current working directory is not a stable contract. If hook setup fails, remove the hook config and continue using the Skills-only install.

Default hook examples enable only the Stop hook. They do not wire PostToolUse because tool-call granularity is too fine for multi-edit Harness artifacts and can slow down ordinary editing. Run `knowledge_check.py --strict` at Stop/readiness/closeout/CI boundaries instead.

Harness no longer provides default `pre-compact` / `session-start` recovery hooks. Platform compaction remains the platform's responsibility. Use explicit handoff notes only when the user asks for handoff or an unfinished task is intentionally paused.

Codex example:

```text
<skills-root>/using-harness/hooks/codex-hooks.example.json
```

Claude Code example:

```text
<skills-root>/using-harness/hooks/claude-settings.example.json
```

OpenCode example:

```text
<skills-root>/using-harness/hooks/opencode-plugin.example.ts
```

OpenCode examples no longer wire `experimental.session.compacting(input, output)` for Harness recovery. Do not wire `session.created` as an automatic recovery reader; new independent sessions must not inherit prior task context.

These examples are intentionally additive. Merge the Harness entries into existing hook/plugin configuration instead of replacing user or project hooks.

After installing or changing Codex hooks, run the local diagnostic from the project you want to verify:

```bash
python ~/.codex/skills/using-harness/scripts/hook_diagnostics.py codex --project-root /path/to/your-project
```

Windows PowerShell:

```powershell
python "$HOME\.codex\skills\using-harness\scripts\hook_diagnostics.py" codex --project-root "C:\path\to\your-project"
```

The diagnostic performs a Stop runner smoke test. A warning means the Skill suite is still usable, but the optional Codex Stop hook is not proven in that environment.

When a Harness hook actually runs, the runner writes a minimal runtime trace to `.harness/hook-events/events.jsonl` under the project root. The trace records event, platform, session id, decision, check, and severity only; it does not store assistant/user message bodies.

## Verify

Validate Skill metadata from this source checkout:

```bash
python scripts/skill_metadata_check.py --root . --skills-path skills
```

Validate Harness knowledge artifacts:

```bash
python skills/using-harness/scripts/knowledge_check.py --root . --docs-path docs
```

Use strict mode for CI or review gates:

```bash
python scripts/skill_metadata_check.py --root . --skills-path skills --strict
python skills/using-harness/scripts/knowledge_check.py --root . --docs-path docs --strict
```

For an installed Codex skill suite, use `$HOME/.codex/skills/using-harness/scripts/knowledge_check.py` and `$HOME/.codex/skills/using-harness/scripts/harness_closeout_check.py`. Projects may vendor these files for CI, but vendoring is not required for normal Harness use.
