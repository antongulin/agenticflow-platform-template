# Skills Directory — AgenticFlow Platform Template

This repo ships five SKILL.md files that teach AI coding tools (Claude Code, Cursor, Codex, Gemini CLI) how to operate the AgenticFlow CLI without reading the full AGENTS.md on every task.

## How skills work

A SKILL.md is a scoped instruction document. When an AI tool reads it, it gains the context needed to execute a narrow class of tasks — analogous to loading a specialist's runbook. Skills reduce context window waste and keep each tool focused.

Load the relevant skill before executing any AgenticFlow CLI commands in an AI coding session.

## Available skills

### agenticflow-agent
**Path:** `skills/agenticflow-agent/SKILL.md`
**Use when:** Creating, running, updating, or deleting a single agent.

Covers:
- `af agent create / run / update / delete`
- The `--patch` partial-update pattern (critical for iteration)
- `af schema agent --field <name>` for nested payload shapes
- `model_user_config`, `code_execution_tool_config`
- Safe iteration loops and thread continuity

Do NOT use for workforces or multi-agent pipelines.

### agenticflow-workforce
**Path:** `skills/agenticflow-workforce/SKILL.md`
**Use when:** Deploying or managing a multi-agent workforce.

Covers:
- All eight built-in blueprints (`dev-shop`, `marketing-agency`, `sales-team`, etc.)
- `af workforce init` one-command deploy + atomic rollback
- Custom graph construction when no blueprint fits
- `af workforce run`, `publish`, `versions publish`
- MCP attachment per agent (delegates to agenticflow-mcp for safety checks)

### agenticflow-mcp
**Path:** `skills/agenticflow-mcp/SKILL.md`
**Use when:** Attaching, inspecting, or managing MCP tool providers.

Covers:
- Composio vs Pipedream safety distinction
- `af mcp-clients inspect` before attaching any tool
- The Pipedream write-loop risk (`TOOL_CONFIGURATION_COMPLETED`)
- Authentication recovery for stale MCP sessions
- Safe attach pattern via `af agent update --patch`

### agenticflow-llm-models
**Path:** `skills/agenticflow-llm-models/SKILL.md`
**Use when:** Selecting or changing the model for an agent or workflow.

Covers:
- Full model roster with capability annotations
- How to read `af bootstrap --json > models[]` as the authoritative list
- Model index numbers (used in some CLI fields)
- Reasoning config (`model_user_config`) for models that support it
- When to escalate from free tier to external provider

### agenticflow-built-in-credits
**Path:** `skills/agenticflow-built-in-credits/SKILL.md`
**Use when:** Optimizing credit usage or planning budget for a new project.

Covers:
- Credit cost estimates per operation type
- Plan tier thresholds and add-on pricing
- The five credit-optimization rules
- When to cache vs. re-query
- How to check current usage via `af bootstrap`

## Skill loading convention

In Claude Code / Cursor, load with:
```
/agenticflow-agent    → skills/agenticflow-agent/SKILL.md
/agenticflow-workforce → skills/agenticflow-workforce/SKILL.md
```

In Gemini CLI, skills auto-register via the skills directory discovery mechanism.

## Extending the skills directory

To add a new skill:
1. Create `skills/<skill-name>/SKILL.md`
2. Follow the frontmatter schema: `name`, `description`, `compatibility`, `triggers`
3. Add an entry to this file (`docs/skills-directory.md`)
4. Register in the platform's skill catalog if publishing publicly
