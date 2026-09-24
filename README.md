# AgenticFlow Platform Template

> A public, community-driven template for building AI-native automations on the [AgenticFlow](https://agenticflow.ai) platform.

## What this is

This template gives you a **disciplined, multi-project structure** that scales from a single chatbot to a full multi-agent workforce. It replaces ad-hoc workflow building with infrastructure-as-code:

- Versioned agents, workflows, and workforces
- Reusable skills for AI tools (Claude, Cursor, Codex)
- Live platform reference docs (nodes, models, playbooks)
- Node taxonomy and model selection guides

## Quick start

```bash
# 1. Fork or clone this template
git clone https://github.com/YOUR_USERNAME/agenticflow-platform-template.git
cd agenticflow-platform-template

# 2. Configure
npm install -g @pixelml/agenticflow-cli
cp .env.example .env
# Edit .env with your real API key, workspace ID, and project ID

# 3. Verify connectivity
source .env
af doctor --json --strict

# 4. Orient
af bootstrap --json
```

## What's inside

| Directory | Purpose |
|---|---|
| `AGENTS.md` | 🧭 **AI agents start here** — canonical entry point for Claude, Cursor, etc. |
| `CLAUDE.md` | Compatibility redirect → `AGENTS.md` for Claude Code users |
| `skills/` | SKILL.md files for AI tools (agent, workforce, MCP, models, credits) |
| `templates/project-skeleton/` | Ready-to-copy scaffold for new projects |
| `reference/` | Live platform docs (nodes, models, MCP clients, playbooks) |
| `scripts/` | Reusable helpers (`bootstrap.sh`) |
| `docs/public/` | External-facing guides (getting started, comparisons) |

## Quick example: deploy a Hello World agent

This repo includes a ready-to-run example in `workspaces/demo/hello-world-agent.json`.

```bash
# 1. Set up environment
cp .env.example .env
# Edit .env with your AGENTICFLOW_API_KEY, WORKSPACE_ID, PROJECT_ID
source .env

# 2. Create the agent (always --dry-run first)
af agent create --body @workspaces/demo/hello-world-agent.json --dry-run --json
af agent create --body @workspaces/demo/hello-world-agent.json --json

# 3. Talk to it
af agent run --agent-id <agent_id_from_step_2> --message "Hello!" --json
```

**Expected output:** an enthusiastic greeting confirming the platform is connected and working.

See [`workspaces/demo/README.md`](workspaces/demo/README.md) for the full walkthrough with troubleshooting.

## The three building blocks

| Block | What it is | CLI command | Use when |
|---|---|---|---|
| **Agent** | Single LLM + tools + prompt | `af agent create / run` | Chatbots, FAQ, research assistants |
| **Workflow** | DAG of prompt/tool/logic nodes | `af workflow create / run` | Classic automation (scrape → summarize → email) |
| **Workforce** | Multi-agent team with wired hand-offs | `af workforce init` | Researcher → Writer → Editor pipelines |

## Features

- ✅ **No-code friendly** — start with blueprints, then customize
- ✅ **AI-native** — built-in RAG, image generation, web search
- ✅ **Multi-agent** — deploy entire teams with one CLI command
- ✅ **Free-tier models** — GLM-4.7 Flash, Gemini 2.5 Flash Lite, and more
- ✅ **Extensible** — attach Composio/Pipedream MCP tools
- ✅ **Versioned** — Git-managed payloads, not fragile UI history

## Model cheat sheet

| # | Model | Best for |
|---|---|---|
| 1 | **GLM-4.7 Flash** | Default for 80% of tasks — fast, smart, reliable |
| 2 | **Gemini 2.5 Flash Lite** | Media (image/audio/video) + 1M context |
| 3 | **GPT-5 Nano** | Deep reasoning + vision combined |
| 4 | **Qwen 3.5 Flash** | Verification, QA |
| 5 | **DeepSeek V3.2 Speciale** | Hardest coding / competition math |

## Pricing (AgenticFlow plans)

| Plan | Price | Credits / month | Multi-Agent |
|---|---|---|---|
| **Free** | $0 | ~3,000 (100/day) | No |
| **Pro** | $19 | 7,500 | No |
| **Team** | $199 | 100,000 | No |
| **Business** | $599 | 300,000 | Yes |
| **Enterprise** | Custom | Custom | Yes |

Extra credits: $20 per 10,000.

## Code intelligence (CodeGraph)

This repo ships project-local [CodeGraph](https://github.com/colbymchenry/codegraph) wiring for
local symbol navigation. It is a **developer aid only** — nothing here imports it and it is not
needed to use the template.

Setup (once per checkout; the `codegraph` CLI is a user-managed global install):

```bash
export CODEGRAPH_TELEMETRY=0
codegraph init .          # build the local index into .codegraph/
codegraph status          # check index health
```

`.codegraph/` is gitignored and never committed. The committed, secret-free MCP configs —
`.mcp.json` (Claude), `.codex/config.toml` (Codex), `opencode.jsonc` (OpenCode),
`.cursor/mcp.json` (Cursor), and `.vscode/mcp.json` (VS Code) — each launch `codegraph serve --mcp`;
Cursor and VS Code also pass `--path ${workspaceFolder}`. Telemetry is disabled via
`CODEGRAPH_TELEMETRY=0` in every config.

**Coverage — effectively none for this repo.** This template is Markdown, shell, YAML, and JSON.
A fresh index reports **5 files / 4 nodes / 0 edges**. The four nodes are file nodes for
`templates/project-skeleton/*.json` payloads (detected as `liquid`);
`.github/workflows/code-review.yml` is included as YAML with zero symbols. It indexes **zero** code symbols and does
not index Markdown (`AGENTS.md`, `README.md`, `docs/`), `.gitignore`, `.env.example`,
`scripts/bootstrap.sh`, or any MCP config. **Use ordinary file reads for this repo's content.**
CodeGraph is included for consistency with other repos and for forks that add real code. A
configured entry is not proof a client loaded it; confirm `codegraph --version` resolves first.

## Contributing

We welcome contributions! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines, conventions, and the PR process.

Quick ways to help:
- Update `reference/*.md` when the platform changes
- Add new project skeletons to `templates/`
- Translate guides in `docs/public/`
- Report outdated nodes or models

## Public vs private usage

This template is designed as a **hybrid**:

| What stays public | What stays private |
|---|---|
| Structure, conventions, reference docs | Your workspace payloads in `workspaces/` |
| Shared skills and templates | Your API keys in `.env` |
| ADRs about architecture choices | Your business logic and datasets |

## License

MIT — see [LICENSE](LICENSE).

## Community

- 📖 [Getting started guide](docs/public/getting-started.md)
- 📊 [AgenticFlow vs alternatives](docs/public/why-agenticflow.md)
- 🛠️ [AI agent canonical guide](AGENTS.md)

---

*This is a template, not an official AgenticFlow product. Use it, modify it, and share your improvements.*
