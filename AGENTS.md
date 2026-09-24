# AGENTS.md — AgenticFlow Platform Workspaces

> **For AI agents and developers.** This is the canonical entry point for this repository.
> If you are human, read [README.md](README.md) first. If you are an AI agent (Claude, Cursor, Sourcegraph, etc.), **read this file first** before touching anything.
> If you use Claude Code, this repository also has `CLAUDE.md` which redirects here.
>
> **Prerequisite:** AgenticFlow CLI (`af`) must be installed. See step 2 below.

---

## What this repository is

This is the **infrastructure-as-code + documentation workspace** for building AI-native automations on the [AgenticFlow](https://agenticflow.ai) platform.

It replaces ad-hoc workflow building with a disciplined, multi-project structure that scales from a single agent to multi-agent workforces.

**Key principle:** Every idea starts as a project folder. Every project contains agents, workflows, workforces, datasets, and docs. Nothing lives at random paths. Everything is discoverable, versionable, and reusable.

---

## Repository layout

```
agenticflow-platform-template/
├── AGENTS.md                  ← You are here — canonical AI agent entry point
├── README.md                  ← Human-facing overview
├── .env.example               ← Template — copy to .env, add your keys
├── .gitignore                 ← .env, node_modules, CodeGraph index, local artifacts
│
├── .mcp.json                  ← Project-local MCP config (CodeGraph) — Claude-compatible
├── .codex/config.toml         ← Project-local MCP config (CodeGraph) — Codex
├── opencode.jsonc             ← Project-local MCP config (CodeGraph) — OpenCode
├── .cursor/mcp.json           ← Project-local MCP config (CodeGraph) — Cursor
├── .vscode/mcp.json           ← Project-local MCP config (CodeGraph) — VS Code
│
├── scripts/                   ← Reusable shell helpers
│   └── bootstrap.sh           ← source .env, run af bootstrap --json
│
├── templates/                 ← Skeletons for new projects
│   └── project-skeleton/
│       ├── README.md          ← Project manifest
│       ├── .env.example       ← Project-specific overrides
│       ├── agents/            ← Agent JSON payloads (af agent create --body @agent.json)
│       ├── workflows/         ← Workflow JSON payloads (af workflow create --body @wf.json)
│       ├── workforces/        ← Workforce graph payloads (af workforce deploy --body @graph.json)
│       ├── datasets/          ← CSV / JSON seed files for knowledge base
│       ├── docs/
│       │   ├── decisions/     ← ADRs (Architecture Decision Records)
│       │   └── conventions.md ← Domain-specific naming rules
│       └── test-inputs/       ← Sample payloads for --dry-run validation
│
├── reference/                 ← Live platform reference (auto-synced where possible)
│   ├── nodes.md               ← All available node types
│   ├── models.md              ← Model roster + selection guide
│   ├── mcp-clients.md         ← Available MCP integrations + inspect status
│   └── playbooks.md           ← CLI playbooks list
│
├── docs/
│   ├── conventions.md         ← Global naming, ID ranges, folder rules
│   ├── decisions/             ← ADRs for this workspace
│   └── public/                ← Content intended for external sharing
│
└── workspaces/
    └── <workspace-slug>/      ← One folder per workspace (mirrors AgenticFlow workspace)
        └── <project-id>/      ← One folder per project within the workspace
            └── ...            ← Same structure as templates/project-skeleton
```

### Directory rules

- **Never** create files directly under `workspaces/` or `workspaces/<workspace>/`. Always inside a project folder.
- **Never** reuse project IDs. If a project dies, move it to an `archive/` subfolder and keep the ID.
- **Always** keep the canonical version of any payload JSON in this repo — AgenticFlow UI is not the source of truth.

---

## Code intelligence: CodeGraph

CodeGraph (`codegraph`) is an optional local symbol index for developer navigation. It is a
**developer aid, not a runtime dependency** — nothing in this repo imports it, and it is never
required to build, run, or use the template.

- **This repo has no useful indexed symbols.** The template is Markdown, YAML, shell, and JSON.
  A fresh `codegraph init .` reports **5 files / 4 nodes / 0 edges**. The four nodes are file
  nodes for `templates/project-skeleton/*.json` payloads (misdetected as `liquid`);
  `.github/workflows/code-review.yml` is included as YAML with zero symbols. Markdown (`AGENTS.md`, `README.md`,
  `docs/`), `.gitignore`, `.env.example`, `scripts/bootstrap.sh`, and every MCP config are **not
  indexed**. **Use ordinary file reads** (`Read`/`Grep`/`Glob`) for all of this repo's content;
  do not rely on CodeGraph results here.
- **Telemetry is off** (`CODEGRAPH_TELEMETRY=0` in every client config). Keep it off; repo
  contents must not be sent to a vendor. For direct CLI use, `export CODEGRAPH_TELEMETRY=0` once
  per shell.
- **The index and daemon state are local.** `.codegraph/` is gitignored and never committed.
  Initialize once per checkout with `CODEGRAPH_TELEMETRY=0 codegraph init .`; check health with
  `codegraph status`.
- **Committed MCP wiring** (project-local, secret-free): `.mcp.json` (Claude-compatible),
  `.codex/config.toml` (Codex), `opencode.jsonc` (OpenCode), `.cursor/mcp.json` (Cursor), and
  `.vscode/mcp.json` (VS Code). Each launches `codegraph serve --mcp`; Cursor and VS Code add
  `--path ${workspaceFolder}` because their formats support it. Merge new servers into these
  files; never clobber existing entries and never copy credentials between repos.
- **Provenance before trust:** a configured entry is not proof a client loaded it. Confirm the
  file exists and `codegraph --version` resolves before relying on the MCP. Canonical source:
  `https://github.com/colbymchenry/codegraph` (the `codegraph` binary is a user-managed global
  install; ask first to add or update it).

---

## Before you begin

Start every session by inspecting Git status and worktrees, fetching origin with pruning, safely fast-forwarding local main, and verifying main matches origin/main. Only then create a task branch from synchronized main if needed. Preserve existing task branches and unfinished work. Never reset, discard changes, auto-stash, or force-push merely to synchronize. If safe synchronization is blocked, resolve the blocker before editing or branching.


### 1. Environment

```bash
cp .env.example .env
# Edit .env with your real API key, workspace ID, and project ID
```

Required variables (for programmatic auth):

| Variable | How to get it |
|---|---|
| `AGENTICFLOW_API_KEY` | Log in to app.agenticflow.ai → Settings → API Keys |
| `AGENTICFLOW_WORKSPACE_ID` | Browser URL when inside a workspace, or `af bootstrap --json` |
| `AGENTICFLOW_PROJECT_ID` | Browser URL when inside a project, or `af bootstrap --json` |

Source it before any CLI work:
```bash
source .env
```

### 2. Install the CLI

```bash
npm install -g @pixelml/agenticflow-cli
af version   # should be >= 1.10.4
```

### 3. First-time orientation

```bash
af bootstrap --json    # see auth state, agents, models, blueprints
af doctor --json --strict   # verify connectivity
```

---

## Quick decision guide: Agent vs Workflow vs Workforce

| I want to build… | Use | Because |
|---|---|---|
| A single chatbot, FAQ, or research assistant | **Agent** | One prompt + tools. Simplest to iterate. |
| A DAG of nodes: scrape → summarize → email | **Workflow** | Classic automation. No AI hand-offs needed. |
| A team where roles hand off: researcher → writer → editor | **Workforce** | Native multi-agent orchestration. Wired graph with 1 command deploy. |

**Rule of thumb:** Start with the simplest layer that solves the problem. Only escalate to Workforce when you genuinely need multiple AI roles collaborating.

---

## Working loop for any task

Every task you receive from the human owner follows this loop. Do not skip steps.

1. **Orient** — `af bootstrap --json` to check current workspace, agents, models.
2. **Discover** — `af node-types search --query "<keyword>" --json` to find the right tools.
3. **Draft** — Write payload JSON in the correct project folder (agents/, workflows/, or workforces/).
4. **Validate** — Use `--dry-run` before any create or deploy.
5. **Deploy** — Create / update the resource via CLI.
6. **Test** — Run with minimal input, inspect output.
7. **Iterate** — Use `--patch` for agents, partial update for workforces.
8. **Document** — Update the project's README.md and changelog.md.

---

## Naming conventions

### Projects

Format: `workspaces/<workspace-slug>/<project-id>-<short-kebab-name>/`

Examples:
- `workspaces/boostbusiness/prod-110-gbp-daily-posts/`
- `workspaces/boostbusiness/exp-310-image-model-benchmark/`
- `workspaces/personal/util-955-cleanup-routine/`

### ID ranges (per workspace)

| Lane | Range | Use for |
|---|---|---|
| `prod` | 100–299 | Production automations |
| `exp` | 300–699 | Experiments, POCs, temporary |
| `diag` | 900–949 | Diagnostics, health checks |
| `util` | 950–999 | Shared utilities, reusable helpers |
| `archive` | any | Dead projects moved here |

### Resource naming

- **Agent names:** `<domain>-<role>-<purpose>` — e.g. `seo-researcher-keyword-gap`
- **Workflow names:** `<domain> | <lane> | <id> | <purpose>` — e.g. `SEO | EXP | 310 | Image Model Benchmark`
- **Workforce names:** `<domain>-<team>-<purpose>` — e.g. `marketing-agency-spring-launch`
- **File names:** kebab-case — e.g. `web-scraper-config.json`, `daily-report-agent.json`

### Project README template

Every project folder must have a `README.md` with:

```markdown
# <Project-ID> — <Short Name>

**Status**: [DRAFT | TESTING | PRODUCTION | ARCHIVED]
**Type**: [agent | workflow | workforce]
**Primary model**: [GLM-4.7 Flash | Gemini 2.5 Flash Lite | ...]
**Trigger**: [Manual | Schedule | Webhook | Agent task]

## Purpose
One paragraph: what this does and why it exists.

## Input
What data flows in.

## Output
What it produces.

## Files
| File | Purpose |
|---|---|
| agent.json / workflow.json / workforce.json | Canonical payload — the source of truth |

## How to run
```bash
af agent run --agent-id <id> --message "..." --json
```

## Changelog
- YYYY-MM-DD: created, tested, deployed.
```

---

## Node taxonomy (built-in tools)

Group them by capability so you know which drawer to open.

### A — Intelligence (web + reasoning)
| Node | When to use |
|---|---|
| Web Scraping | Extract raw HTML from any URL |
| Web Search | Real-time search for recent info |
| Web Retrieval | Feed specific URLs as LLM context |
| URL to Markdown | Clean article extraction |
| Extract Content | Schema-based structured extraction |
| Ask AI | Direct LLM prompt (classify, summarize, rewrite) |
| Run JavaScript | Custom data transformation logic |
| Get Current Datetime | Scheduling, timestamps, TTL checks |

### B — Knowledge (native RAG)
| Node | When to use |
|---|---|
| Knowledge Retrieval | Semantic search over uploaded datasets |
| Query Data | SQL-like filter/sort on datasets |
| Update Data | Conditional row updates |
| Insert Data | Append new rows |
| Get Item by Path / List Items | Drive storage navigation |
| Export Data to File | Write to S3, get URL back |
| Convert String to JSON / Get Value by Key | Data normalization |

### C — Action (output to world)
| Node | When to use |
|---|---|
| Send Email | SMTP dispatch, alerts, digests |
| JSON to Google Sheet | Reporting, dashboards |
| Generate Image | AI image generation |
| HTML to Image | Screenshot/render HTML |
| Text to Music | Audio generation |
| API Call | Generic HTTP for anything not covered |

### D — Social & Marketing
| Node | When to use |
|---|---|
| Instagram Scraper | Pull posts from a profile |
| Instagram Profile Analyzer | Metrics + demographics |
| Social Profile Analyzer | Cross-platform brand health |
| Search video in Pexels | Stock video search |
| Search sound in YouTube Sound Library | Royalty-free audio |
| Create PinPoint Campaign | Paid media activation |
| Import PinPoint Segment | Audience import |
| Segment User / Segment User V2 | Behavioral segmentation |
| Create CX Agent / Create CX Agent V2 | Customer experience bot |

### E — Orchestration (meta)
| Node | When to use |
|---|---|
| List / Create / Get / Update / Delete Agent Task | Assign and monitor work |
| Create Multiple Agent Tasks | Batch delegation |
| Call Other Workflow | Reusable sub-workflows |
| Set Variable / Get Variable | Pass state between nodes |
| Echo | Debug / inspect intermediate state |

---

## Model strategy

Your primary free-tier stack:

| Slot | Model | Index | Use for |
|---|---|---|---|
| Default text | **GLM-4.7 Flash** | 30 | 80% of tasks: chat, reasoning, JSON, tools, coding |
| Multimodal / long context | **Gemini 2.5 Flash Lite** | 13–19 | Media (image, audio, video), OCR, 1M token docs |
| Deep reasoning | **GPT-5 Nano** | 26–27 | Vision + logic combined, OpenAI-style workflows |
| Verification | **Qwen 3.5 Flash** | 26 | QA, fact-checking, accuracy-critical steps |
| Hardest problems | **DeepSeek V3.2 Speciale** | 29–32 | Competition math, final-answer coding |

Escalation: if free tier is insufficient → external provider via API Call or custom MCP.

---

## MCP extensibility

The platform supports external tool providers via MCP (Model Context Protocol):

| Provider | What it adds | Safety |
|---|---|---|
| Composio | 100+ integrations (GitHub, Slack, Notion, etc.) | Safe — structured schemas |
| Pipedream | 1,000+ app actions | Inspect first — some write-tools can loop (`TOOL_CONFIGURATION_COMPLETED`) |
| Custom | Any internal tool you build | Varies — classify before attaching |

Before attaching ANY MCP to an agent:
```bash
af mcp-clients inspect --id <id> --json
```
Look for `pattern: "composio"` (safe) vs `pattern: "pipedream"` (caution).

---

## Credit discipline

Check your actual plan in the web UI or via `af bootstrap --json`. The workspace owner currently has the **Business** plan at $599/month (300,000 credits / month). Other users may have different tiers:

| Plan | Credits / month | Best for |
|---|---|---|
| Free | ~3,000 (100/day) | Experimenting, hobby projects |
| Pro $19 | 7,500 | Personal automations |
| Team $199 | 100,000 | Small team workflows |
| **Business $599** | **300,000** | Production workforces + high-volume agents |
| Enterprise | Custom | Custom integrations, SSO, multi-region |

300K credits is generous for workflows, tight for raw chat.

| Workload | Credits/run | Monthly budget |
|---|---|---|
| Daily workflow | ~5,000 | ~150K/mo |
| Weekly workforce | ~15,000 | ~60K/mo |
| Single knowledge query | ~500 | ~50K for 100 queries |
| 500 full-context chats | ~1,000 each | ~500K ❌ (exceeds Business plan) |

**Optimize:**
1. Use GLM-4.7 for 80% of tasks (cheapest, fastest).
2. Use Gemini ONLY for media or >200K context.
3. Cache data in variables or datasets — don't re-query.
4. Use Extract Content with tight schemas to minimize output tokens.
5. Use Knowledge Retrieval instead of stuffing full docs into context.

**Need more credits?** Add-on packs: $20 per 10,000 credits. Or upgrade plan.

---

## Skills directory

This repo contains a `skills/` directory with `SKILL.md` files that teach other AI tools (Claude Code, Cursor, Codex, Gemini CLI) how to operate the AgenticFlow CLI:

| Skill | Path | Purpose |
|---|---|---|
| `agenticflow-agent` | `skills/agenticflow-agent/SKILL.md` | Single agent create/run/iterate (`af agent *`) |
| `agenticflow-workforce` | `skills/agenticflow-workforce/SKILL.md` | Multi-agent team deploy (`af workforce *`, blueprints) |
| `agenticflow-mcp` | `skills/agenticflow-mcp/SKILL.md` | MCP tool attach/inspect (`af mcp-clients *`) |
| `agenticflow-llm-models` | `skills/agenticflow-llm-models/SKILL.md` | Model selection + reasoning config |
| `agenticflow-built-in-credits` | `skills/agenticflow-built-in-credits/SKILL.md` | Credits-first philosophy + cost optimization |

AI agents working in this repo should load the relevant skill before executing commands.

---

## Public vs private content

This repo is a **hybrid**: a public version exists for community sharing, while the private version contains proprietary business logic.

| What goes public | What stays private |
|---|---|
| `README.md`, `AGENTS.md`, `docs/public/`, `reference/` | Project payloads with business logic, API keys, client names |
| Generic templates in `templates/` | Credentials in `.env` (never committed) |
| ADRs about architecture choices | Proprietary datasets in `datasets/` |

When building, assume the `docs/public/` folder will be published. Move any sensitive analysis to project-specific docs.

---

## Hard rules

1. **Never commit `.env`.** It lives in `.gitignore` forever.
2. **Never put API keys in JSON payloads.** Use env var interpolation or CLI flags.
3. **Never delete a project folder.** Move to `archive/` and preserve the ID.
4. **Never treat the UI as source of truth.** Export payloads back to this repo after every change.
5. **Always `--dry-run` before deploy.**
6. **Always `--json` in automation.** Machine-readable output carries `schema:` discriminators.
7. **Always `--patch` for agent iteration.** Don't round-trip full bodies.

---

## When in doubt

- Use `af schema <resource> --field <name> --json` instead of trial-and-error on nested payloads.
- Use `af playbook <topic>` for guided walkthroughs.
- Check `reference/nodes.md` and `reference/models.md` before designing a new workflow.
- Read `docs/conventions.md` before creating a new project.

---

## File ownership

| File | Purpose |
|---|---|
| `AGENTS.md` | ← This file. AI agent canonical entry point. |
| `README.md` | Human-facing overview + quick start. |
| `.env.example` | Template for required environment variables. |
| `.mcp.json`, `.codex/`, `opencode.jsonc`, `.cursor/`, `.vscode/` | Project-local CodeGraph MCP wiring (secret-free). |
| `scripts/` | Shell helpers for auth and orientation (`bootstrap.sh`). |
| `templates/` | Skeletons for new projects. |
| `reference/` | Live-ish platform documentation (nodes, models, MCP, playbooks). |
| `docs/` | Global conventions + ADRs + public-facing guides. |
| `workspaces/` | Actual project payloads, organized by workspace + project. |

If you find yourself putting platform-wide docs in a project folder, move it up to `docs/` or `reference/` instead.

<!-- DOX:BEGIN (canonical: github.com/agent0ai/dox AGENTS.md — always-latest copy; safe to edit/extend the block below, e.g. fill in Child DOX Index) -->
# DOX framework

- DOX is highly performant AGENTS.md hierarchy installed here
- Agent must follow DOX instructions across any edits

## Core Contract

- AGENTS.md files are binding work contracts for their subtrees
- Work products, source materials, instructions, records, assets, and durable docs must stay understandable from the nearest applicable AGENTS.md plus every parent AGENTS.md above it

## Read Before Editing

1. Read the root AGENTS.md
2. Identify every file or folder you expect to touch
3. Walk from the repository root to each target path
4. Read every AGENTS.md found along each route
5. If a parent AGENTS.md lists a child AGENTS.md whose scope contains the path, read that child and continue from there
6. Use the nearest AGENTS.md as the local contract and parent docs for repo-wide rules
7. If docs conflict, the closer doc controls local work details, but no child doc may weaken DOX

Do not rely on memory. Re-read the applicable DOX chain in the current session before editing.

## Update After Editing

Every meaningful change requires a DOX pass before the task is done.

Update the closest owning AGENTS.md when a change affects:

- purpose, scope, ownership, or responsibilities
- durable structure, contracts, workflows, or operating rules
- required inputs, outputs, permissions, constraints, side effects, or artifacts
- user preferences about behavior, communication, process, organization, or quality
- AGENTS.md creation, deletion, move, rename, or index contents

Update parent docs when parent-level structure, ownership, workflow, or child index changes. Update child docs when parent changes alter local rules. Remove stale or contradictory text immediately. Small edits that do not change behavior or contracts may leave docs unchanged, but the DOX pass still must happen.

## Hierarchy

- Root AGENTS.md is the DOX rail: project-wide instructions, global preferences, durable workflow rules, and the top-level Child DOX Index
- Child AGENTS.md files own domain-specific instructions and their own Child DOX Index
- Each parent explains what its direct children cover and what stays owned by the parent
- The closer a doc is to the work, the more specific and practical it must be

## Child Doc Shape

- Create a child AGENTS.md when a folder becomes a durable boundary with its own purpose, rules, responsibilities, workflow, materials, or quality standards
- Work Guidance must reflect the current standards of the project or user instructions; if there are no specific standards or instructions yet, leave it empty
- Verification must reflect an existing check; if no verification framework exists yet, leave it empty and update it when one exists

Default section order:
- Purpose
- Ownership
- Local Contracts
- Work Guidance
- Verification
- Child DOX Index

## Style

- Keep docs concise, current, and operational
- Document stable contracts, not diary entries
- Put broad rules in parent docs and concrete details in child docs
- Prefer direct bullets with explicit names
- Do not duplicate rules across many files unless each scope needs a local version
- Delete stale notes instead of explaining history
- Trim obvious statements, repeated rules, misplaced detail, and warnings for risks that no longer exist

## Closeout

1. Re-check changed paths against the DOX chain
2. Update nearest owning docs and any affected parents or children
3. Refresh every affected Child DOX Index
4. Remove stale or contradictory text
5. Run existing verification when relevant
6. Report any docs intentionally left unchanged and why

## User Preferences

When the user requests a durable behavior change, record it here or in the relevant child AGENTS.md

## Child DOX Index

This project is not yet indexed. Before continuing you must scan the project, build the DOX tree and replace this message with the actual index. Go deep and scan files recursively to properly evaluate complexity and create nested DOX files where needed.
<!-- DOX:END -->

<!-- BASELINE:BEGIN (managed by agents-md-bootstrap) -->
## Engineering baseline

This repo follows the baseline: `~/Code/700 systems/baseline` (https://github.com/antongulin/baseline, private).
Read `baseline/00-laws.md` first; pillars 01–07 hold the law (workspace, agents, project,
stacks, infra, delivery, knowledge). Answer standards questions from those files, not memory.
Anything missing or broken against the baseline is surfaced loudly — never skipped (law 2).
<!-- BASELINE:END -->
