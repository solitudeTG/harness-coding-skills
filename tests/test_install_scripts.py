from __future__ import annotations

import os
import subprocess
import tempfile
import unittest
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
LEGACY_SKILLS = {
    "using-harness",
    "harness-start-gate",
    "harness-delegation-gate",
    "harness-knowledge-retrieval",
    "harness-spec-drift",
    "harness-doc-lifecycle",
    "harness-incident-learning",
    "harness-vision-gate",
    "harness-readiness-dashboard",
    "harness-change-narrative",
    "harness-knowledge-capture",
    "harness-project-rules",
}


class InstallScriptTests(unittest.TestCase):
    def test_powershell_install_copies_vnext_and_removes_legacy(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            destination = Path(directory) / "skills"
            for legacy_skill in LEGACY_SKILLS:
                (destination / legacy_skill).mkdir(parents=True)
            environment = os.environ | {"HARNESS_CODEX_SKILLS_DIR": str(destination)}
            result = subprocess.run(["powershell", "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "scripts/install.ps1", "codex"], cwd=REPO_ROOT, text=True, capture_output=True, env=environment)
            self.assertEqual(0, result.returncode, result.stdout + result.stderr)
            self.assertTrue((destination / "harness" / "SKILL.md").exists())
            for legacy_skill in LEGACY_SKILLS:
                self.assertFalse((destination / legacy_skill).exists(), legacy_skill)
