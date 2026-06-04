# Architecture — AgenticFlow Platform Template

## What this repo solves

AgenticFlow's UI is powerful but not version-controlled. Agents, workflows, and workforces built through the web app have no audit trail, no rollback, and no way to share structure with a team. This template replaces the UI as the source of truth: every AI resource lives as a JSON payload committed to git, and the CLI deploys from those files.

## The three-layer hierarchy

```
Agent        →  Single LLM + system prompt + tools
Workflow     →  DAG of prompt/tool/logic nodes (no AI hand-offs)
Workforce    →  Graph of agents that hand off to each other
```

Start with the simplest layer. An agent with routing logic in its system prompt is always cheaper than a workforce. Only escalate to Workflow when you need DAG automation; only escalate to Workforce when you genuinely need multiple AI roles collaborating with structured hand-offs.

## Repo layout design

```
agenticflow-platform-template/
├── AGENTS.md               ← AI-agent entry point (canonical)
├── README.md               ← Human-facing overview
├── skills/                 ← SKILL.md files teaching AI tools the CLI
├── templates/              ← project-skeleton copied per new project
├── reference/              ← live platform docs (nodes, models, MCP, playbooks)
├── docs/                   ← conventions, ADRs, public guides
└── workspaces/
    └── <workspace-slug>/
        └── <project-id>-<name>/
            ├── agents/
            ├── workflows/
            ├── workforces/
            ├── datasets/
            ├── docs/decisions/
            └── test-inputs/
```

**Key design decisions:**

- `workspaces/` is the runtime layer — one folder per workspace, one subfolder per project. Never put files directly under `workspaces/` root.
- `templates/project-skeleton/` is the template layer — copy the whole folder to create a new project; it contains stub JSONs and placeholder docs.
- `reference/` is community-maintained platform documentation. Update it when the platform changes; don't auto-generate it.
- `skills/` contains SKILL.md files for AI tools (Claude Code, Cursor, Codex, Gemini CLI). These teach the tools how to operate the AgenticFlow CLI without reading the whole AGENTS.md every time.

## Project ID system

Every project under `workspaces/<workspace-slug>/` uses a numeric prefix with a lane prefix:

| Lane | Range | Use for |
|------|-------|---------|
| `prod` | 100–299 | Production automations |
| `exp` | 300–699 | Experiments, POCs |
| `diag` | 900–949 | Health checks |
| `util` | 950–999 | Shared utilities |

Example: `workspaces/boostbusiness/prod-110-gbp-daily-posts/`

IDs are permanent. Dead projects move to `archive/` — never delete the folder or reuse the ID.

## CLI-first discipline

Every resource has a canonical JSON payload in this repo. Workflow:

1. Draft payload JSON in the correct project folder.
2. `--dry-run` before any create or deploy.
3. Deploy with CLI (`af agent create`, `af workflow create`, `af workforce init`).
4. Iterate with `--patch` (never full-body replace for small changes).
5. If UI was used to make changes, export back to repo before committing.

The UI is never the source of truth.

## Public vs private hybrid

This template is designed to be forked publicly while keeping business data private:

| Public (safe to commit) | Private (gitignored) |
|------------------------|----------------------|
| `AGENTS.md`, `README.md`, `reference/`, `docs/public/` | `.env`, `workspaces/` payload with business logic |
| `templates/` generic skeletons | `datasets/` with proprietary data |
| Architecture decision records | Client names, API keys |

Use a private fork of this template for production workspaces.
