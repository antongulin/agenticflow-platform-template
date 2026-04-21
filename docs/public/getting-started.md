# Getting Started with AgenticFlow

A step-by-step guide for first-time users who want to build their first AI agent or workflow.

## Before you start

You need:
1. An [AgenticFlow](https://agenticflow.ai) account (free tier works)
2. Node.js 18+ installed locally
3. A terminal (bash, zsh, PowerShell)

## Step 1: Install the CLI

```bash
npm install -g @pixelml/agenticflow-cli
```

Verify:
```bash
af --version   # should print a semver, e.g. 1.10.4
```

## Step 2: Authenticate

```bash
af login
```

This opens a browser and lets you paste your API key.

Or, set it via environment variable:
```bash
export AGENTICFLOW_API_KEY=a9w_xxxx
export AGENTICFLOW_WORKSPACE_ID=xxxx
export AGENTICFLOW_PROJECT_ID=xxxx
```

## Step 3: Orient yourself

```bash
af bootstrap --json
```

This tells you:
- Are you authenticated?
- Which workspace and project are active?
- What models are available?
- What blueprints (templates) can you deploy?

## Step 4: Deploy your first AI agent

```bash
af agent create --body '{"name":"My First Agent","model":"agenticflow/glm-4.7-flash","system_prompt":"You are a helpful assistant.","project_id":"YOUR_PROJECT_ID","tools":[]}' --json
```

Replace `YOUR_PROJECT_ID` with the value from `af bootstrap --json` → `auth.project_id`.

**Pro tip:** Always use `--dry-run` before creating:
```bash
af agent create --body @agent.json --dry-run --json
```

## Step 5: Talk to your agent

```bash
af agent run --agent-id <id-from-step-4> --message "What is 2 + 2?" --json
```

## Step 6: Deploy a pre-built team (optional)

AgenticFlow has ready-made multi-agent teams:

```bash
af workforce init --blueprint content-studio --name "My Content Team" --json
```

This creates:
- 1 coordinator agent
- 1 researcher agent
- 1 writer agent
- 1 designer agent (optional)

## What next?

## What next?

- Read [reference/nodes.md](../../reference/nodes.md) to see what tools are available.
- Read [reference/models.md](../../reference/models.md) to pick the right LLM.
- Try the [Hello World demo](../../workspaces/demo/) to deploy and run your first agent.
- Use this template repo's `templates/project-skeleton/` to scaffold your own projects.

## Need help?

- Join the [AgenticFlow Discord](https://discord.gg/agenticflow) (if applicable)
- Open an issue on GitHub
- Run `af playbook first-touch` for the built-in tutorial
