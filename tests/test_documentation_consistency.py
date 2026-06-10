from __future__ import annotations

import re
from pathlib import Path
import unittest


REPO_ROOT = Path(__file__).resolve().parents[1]


def read(path: str) -> str:
    return (REPO_ROOT / path).read_text(encoding="utf-8")


def markdown_links(content: str) -> list[str]:
    links = re.findall(r"\[[^\]]+\]\(([^)]+)\)", content)
    return [
        link
        for link in links
        if not link.startswith(("http://", "https://", "mailto:"))
    ]


class DocumentationConsistencyTests(unittest.TestCase):
    def test_readiness_scope_is_consistent_across_public_docs(self) -> None:
        docs = {
            "README.md": read("README.md"),
            "README.en.md": read("README.en.md"),
            "INSTALL.md": read("INSTALL.md"),
            "docs/skill-index.md": read("docs/skill-index.md"),
            "docs/workflow.md": read("docs/workflow.md"),
            "examples/minimal-harness/README.md": read("examples/minimal-harness/README.md"),
            "examples/project-harness/README.md": read("examples/project-harness/README.md"),
        }

        for path, content in docs.items():
            with self.subTest(path=path):
                self.assertIn("harness-readiness-dashboard", content)
                self.assertIn("progress", content)
                self.assertIn("maturity", content)
                self.assertIn("gap", content)

    def test_public_markdown_links_resolve_inside_repo(self) -> None:
        for path in ["README.md", "README.en.md", "INSTALL.md", "docs/skill-index.md"]:
            content = read(path)
            for link in markdown_links(content):
                target = link.split("#", 1)[0]
                if not target:
                    continue
                with self.subTest(path=path, link=link):
                    source_dir = (REPO_ROOT / path).parent
                    self.assertTrue((source_dir / target).exists(), f"missing markdown link target: {link}")


if __name__ == "__main__":
    unittest.main()
