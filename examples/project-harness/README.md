# Project Harness v1 Example

This example preserves the pre-vNext project-harness document shape for historical reference. It is not a vNext runtime template and does not participate in `docs/INDEX.md` generation.

For vNext projects, begin with the templates under `skills/harness/assets/templates/`, keep current Feature and accepted ADR summaries in `docs/INDEX.md`, and use event Skills only when their named event occurs.

The archived v1 example includes structured docs under `docs/`:

```text
docs/features/F001-harness.md
docs/decisions/ADR-001-markdown-as-source-of-truth.md
docs/lessons/LL-001-evidence-before-completion.md
docs/evidence/EV-001-project-harness-example.md
```

Validate it from the repository root:

```bash
python scripts/knowledge_check.py --root . --docs-path docs --strict
```
