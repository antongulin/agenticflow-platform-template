# Demo — Hello World Agent

This is the simplest possible AgenticFlow project: a single agent that says hello.

Use it to verify that your CLI authentication, workspace, and project configuration are all working.

## Files

| File | Purpose |
|---|---|
| `hello-world-agent.json` | Agent payload — creates an agent via CLI |

## Prerequisites

1. The [AgenticFlow CLI](https://www.npmjs.com/package/@pixelml/agenticflow-cli) is installed:
   ```bash
   npm install -g @pixelml/agenticflow-cli
   ```
2. You have your `AGENTICFLOW_API_KEY` from [app.agenticflow.ai](https://app.agenticflow.ai) → Settings → API Keys.
3. You know your `AGENTICFLOW_PROJECT_ID` (from the browser URL inside a project, or from `af bootstrap --json`).

## How to run

### Step 1 — Configure and authenticate

```bash
# Copy the env template
cp .env.example .env
# Edit .env and fill in AGENTICFLOW_API_KEY and AGENTICFLOW_PROJECT_ID

# Authenticate
af login --api-key "$AGENTICFLOW_API_KEY"

# Verify
af whoami --json
# Expected: api_key_present: true
```

### Step 2 — Validate the payload locally

```bash
# This checks the JSON shape without touching the server
af agent create --body @hello-world-agent.json --dry-run --json
```

**Expected:** `{"schema":"agenticflow.dry_run.v1","valid":true,"target":"agent.create"}`

### Step 3 — Create the agent

```bash
af agent create --body @hello-world-agent.json --json
```

**Expected on success:**
```json
{
  "schema": "agenticflow.create.v1",
  "id": "ag_xxxxxxxxxx",
  "name": "Hello World Agent",
  ...
}
```

### Step 4 — Talk to it

```bash
af agent run --agent-id <agent_id_from_step_3> --message "Hello!" --json
```

**Expected:**
```json
{
  "response": "Hello! The AgenticFlow platform is up and running!",
  "status": "completed",
  "thread_id": "th_xxxxxxxxxx"
}
```

### Step 5 — Clean up (optional)

```bash
af agent delete --agent-id <agent_id_from_step_3> --json
```

## What this proves

- ✅ CLI is installed and responds
- ✅ JSON payload passes local validation (`--dry-run`)
- ✅ Authentication works (no 401)
- ✅ `PROJECT_ID` is correct (no 404)
- ✅ Agent creation succeeds
- ✅ The default model `glm-4.7-flash` responds

## Common issues

| Symptom | Cause | Fix |
|---|---|---|
| `401 Missing bearer token` | Not logged in | Run `af login --api-key "your-key"` |
| `422` on create | `project_id` is wrong | Copy it from `af bootstrap --json` → `auth.project_id` |
| `404 Agent not found` on run | Wrong `agent_id` | Run `af agent list --fields id,name --json` |

## Next steps

- Read `AGENTS.md` for the full guide.
- Copy `templates/project-skeleton/` to start a real project.
- Explore `reference/nodes.md` to see what tools are available.
