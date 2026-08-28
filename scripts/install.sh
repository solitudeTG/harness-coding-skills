#!/usr/bin/env bash
set -euo pipefail

verify=0
target="both"
[[ "${1:-}" == "--verify" ]] && { verify=1; shift; }
[[ $# -gt 0 ]] && target="$1"
[[ "$target" =~ ^(codex|claude|both)$ ]] || { echo "Usage: scripts/install.sh [--verify] [codex|claude|both]" >&2; exit 2; }

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
formal=(harness harness-intent harness-decision harness-learning harness-evidence harness-closeout)
legacy=(using-harness harness-start-gate harness-delegation-gate harness-knowledge-retrieval harness-spec-drift harness-doc-lifecycle harness-incident-learning harness-vision-gate harness-readiness-dashboard harness-change-narrative harness-knowledge-capture harness-project-rules)
resources=(harness/scripts/generate_index.py harness/scripts/knowledge_check.py harness/assets/templates/FEATURE.md harness/assets/templates/ADR.md harness/assets/templates/LESSON.md harness/assets/templates/EVIDENCE.md harness/assets/templates/CLOSEOUT_COMPACT.md)

destination() { [[ "$1" == codex ]] && echo "${HARNESS_CODEX_SKILLS_DIR:-$HOME/.codex/skills}" || echo "${HARNESS_CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"; }
check() {
  local destination="$1" label="$2" errors=0
  for skill in "${formal[@]}"; do [[ -f "$destination/$skill/SKILL.md" ]] || { echo "Verification error: missing $skill/SKILL.md" >&2; errors=$((errors+1)); }; done
  for skill in "${legacy[@]}"; do [[ ! -e "$destination/$skill" ]] || { echo "Verification error: legacy Skill still exists: $skill" >&2; errors=$((errors+1)); }; done
  for resource in "${resources[@]}"; do [[ -f "$destination/$resource" ]] || { echo "Verification error: missing resource: $resource" >&2; errors=$((errors+1)); }; done
  [[ $errors -eq 0 ]] || return 1
  echo "Verification: passed for $label at $destination"
}
install() { local destination="$1" label="$2"; mkdir -p "$destination"; for skill in "${legacy[@]}"; do rm -rf "$destination/$skill"; done; cp -R "$repo_root/skills/." "$destination/"; check "$destination" "$label"; }
for name in $( [[ "$target" == both ]] && echo "codex claude" || echo "$target" ); do dest="$(destination "$name")"; [[ $verify -eq 1 ]] && check "$dest" "$name" || install "$dest" "$name"; done
echo "Restart the agent to reload Harness vNext metadata."
