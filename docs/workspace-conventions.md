# Workspace Conventions — AgenticFlow Platform Template

Conventions for naming, organizing, and maintaining projects in the `workspaces/` tree.

## Folder structure

```
workspaces/
└── <workspace-slug>/           ← matches your AgenticFlow workspace name, kebab-case
    └── <lane>-<id>-<name>/     ← one folder per project
        ├── README.md           ← project manifest (required)
        ├── .env.example        ← project-specific env vars
        ├── agents/             ← agent JSON payloads
        ├── workflows/          ← workflow JSON payloads
        ├── workforces/         ← workforce graph payloads
        ├── datasets/           ← CSV/JSON seed files
        ├── test-inputs/        ← sample payloads for --dry-run
        ├── docs/
        │   ├── conventions.md  ← domain-specific naming rules
        │   └── decisions/      ← Architecture Decision Records
        └── changelog.md
```

Never put files directly under `workspaces/` or `workspaces/<workspace>/`. Always inside a project folder.

## Project ID ranges

| Lane prefix | ID range | Purpose |
|-------------|----------|---------|
| `prod` | 100–299 | Live production automations |
| `exp` | 300–699 | Experiments, POCs, temporary builds |
| `diag` | 900–949 | Diagnostics, health checks, monitors |
| `util` | 950–999 | Shared utilities, reusable helpers |

IDs are permanent. When a project is retired, move its folder to `archive/` inside the workspace folder — never delete, never reuse the ID.

**Examples:**
- `workspaces/boostbusiness/prod-110-gbp-daily-posts/`
- `workspaces/boostbusiness/exp-310-image-model-benchmark/`
- `workspaces/personal/util-955-cleanup-routine/`
- `workspaces/boostbusiness/archive/exp-420-retired-scraper/`

## Resource naming conventions

### Agents
Format: `<domain>-<role>-<purpose>`
Examples: `seo-researcher-keyword-gap`, `support-agent-billing`, `content-writer-linkedin`

### Workflows
Format: `<Domain> | <Lane> | <ID> | <Purpose>`
Examples: `SEO | EXP | 310 | Image Model Benchmark`, `GBP | PROD | 110 | Daily Posts`

### Workforces
Format: `<domain>-<team>-<purpose>`
Examples: `marketing-agency-spring-launch`, `content-studio-client-acme`

### Files (payload JSON)
Always kebab-case. One file per logical resource:
- `daily-report-agent.json`
- `scrape-summarize-email.json`
- `research-write-publish-workforce.json`

## Project README template

Every project folder must have a `README.md`:

```markdown
# <Project-ID> — <Short Name>

**Status**: [DRAFT | TESTING | PRODUCTION | ARCHIVED]
**Type**: [agent | workflow | workforce]
**Primary model**: [GLM-4.7 Flash | ...]
**Trigger**: [Manual | Schedule | Webhook | Agent task]

## Purpose
One paragraph: what this does and why it exists.

## Input / Output
What flows in, what comes out.

## How to run
af agent run --agent-id <id> --message "..." --json

## Changelog
- YYYY-MM-DD: created / changed / archived
```

## Hard rules

1. **Never commit `.env`** — it is gitignored forever. Use `.env.example` for templates.
2. **Never put API keys in JSON payloads** — use env var interpolation or CLI flags.
3. **Never delete a project folder** — move to `archive/`, preserve the ID.
4. **Never treat the UI as source of truth** — export payloads back to repo after every UI change.
5. **Always `--dry-run` before deploy** — no exceptions.
6. **Always `--json` in automation** — machine-readable output carries schema discriminators.
7. **Always `--patch` for agent iteration** — never full-body replace for small changes.

## Architecture Decision Records (ADRs)

For significant design choices in a project (model selection, node topology, escalation decisions), create an ADR in `docs/decisions/`:

```
docs/decisions/
├── 001-model-selection.md
├── 002-why-workforce-not-agent.md
└── 003-external-mcp-escalation.md
```

ADR format: Context → Decision → Rationale → Consequences (one page max).
