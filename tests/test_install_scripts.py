from __future__ import annotations

import os
import shutil
import subprocess
import tempfile
import unittest
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]

FORMAL_SKILLS = [
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
]

REQUIRED_RESOURCES = [
    "using-harness/scripts/knowledge_check.py",
    "using-harness/scripts/harness_closeout_check.py",
    "using-harness/scripts/hook_diagnostics.py",
    "using-harness/scripts/skill_metadata_check.py",
    "using-harness/scripts/usage_record.py",
    "using-harness/hooks/harness_hook.py",
    "using-harness/assets/templates/AGENTS.md",
]


def bash_is_usable() -> bool:
    if shutil.which("bash") is None:
        return False
    result = subprocess.run(
        ["bash", "--version"],
        text=True,
        encoding="utf-8",
        errors="replace",
        capture_output=True,
    )
    return result.returncode == 0


def assert_install_is_complete(test: unittest.TestCase, destination: Path) -> None:
    for skill in FORMAL_SKILLS:
        test.assertTrue((destination / skill / "SKILL.md").exists(), skill)
    for resource in REQUIRED_RESOURCES:
        test.assertTrue((destination / resource).exists(), resource)


@unittest.skipIf(not bash_is_usable(), "bash is not usable")
class BashInstallScriptTests(unittest.TestCase):
    def test_installs_to_overridden_destination_and_verifies(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            codex = Path(tmp) / "codex-skills"
            claude = Path(tmp) / "claude-skills"
            env = os.environ.copy()
            env["HARNESS_CODEX_SKILLS_DIR"] = str(codex)
            env["HARNESS_CLAUDE_SKILLS_DIR"] = str(claude)

            install = subprocess.run(
                ["bash", "scripts/install.sh", "codex"],
                cwd=REPO_ROOT,
                env=env,
                text=True,
                encoding="utf-8",
                errors="replace",
                capture_output=True,
            )

            self.assertEqual(install.returncode, 0, install.stderr)
            self.assertIn("Verification: passed", install.stdout)
            self.assertIn("Hooks are optional", install.stdout)
            assert_install_is_complete(self, codex)
            self.assertFalse(claude.exists())

            verify = subprocess.run(
                ["bash", "scripts/install.sh", "--verify", "codex"],
                cwd=REPO_ROOT,
                env=env,
                text=True,
                encoding="utf-8",
                errors="replace",
                capture_output=True,
            )

            self.assertEqual(verify.returncode, 0, verify.stderr)
            self.assertIn("Verify-only: no files were copied", verify.stdout)
            self.assertIn("Verification: passed", verify.stdout)


@unittest.skipIf(shutil.which("powershell") is None, "powershell is not available")
class PowerShellInstallScriptTests(unittest.TestCase):
    def test_installs_to_overridden_destination_and_verifies(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            codex = Path(tmp) / "codex-skills"
            claude = Path(tmp) / "claude-skills"
            env = os.environ.copy()
            env["HARNESS_CODEX_SKILLS_DIR"] = str(codex)
            env["HARNESS_CLAUDE_SKILLS_DIR"] = str(claude)

            install = subprocess.run(
                [
                    "powershell",
                    "-NoProfile",
                    "-ExecutionPolicy",
                    "Bypass",
                    "-File",
                    ".\\scripts\\install.ps1",
                    "claude",
                ],
                cwd=REPO_ROOT,
                env=env,
                text=True,
                encoding="utf-8",
                errors="replace",
                capture_output=True,
            )

            self.assertEqual(install.returncode, 0, install.stderr)
            self.assertIn("Verification: passed", install.stdout)
            self.assertIn("Hooks are optional", install.stdout)
            assert_install_is_complete(self, claude)
            self.assertFalse(codex.exists())

            verify = subprocess.run(
                [
                    "powershell",
                    "-NoProfile",
                    "-ExecutionPolicy",
                    "Bypass",
                    "-File",
                    ".\\scripts\\install.ps1",
                    "-Verify",
                    "claude",
                ],
                cwd=REPO_ROOT,
                env=env,
                text=True,
                encoding="utf-8",
                errors="replace",
                capture_output=True,
            )

            self.assertEqual(verify.returncode, 0, verify.stderr)
            self.assertIn("Verify-only: no files were copied", verify.stdout)
            self.assertIn("Verification: passed", verify.stdout)


if __name__ == "__main__":
    unittest.main()
