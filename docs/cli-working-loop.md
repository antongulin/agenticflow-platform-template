# CLI Working Loop — AgenticFlow Platform Template

The canonical 7-step loop every agent and developer follows when building on AgenticFlow.

## The loop

```
Orient → Discover → Draft → Validate → Deploy → Test → Iterate
```

### 1. Orient

```bash
af bootstrap --json
```

Read from the response before touching anything:
- `auth.project_id` — required on agent create
- `auth.workspace_id`
- `_links.workspace` — open this in the browser to see what exists
- `models[]` — source of truth for valid model IDs (don't hardcode)
- `agents[]`, `workforces[]` — what already exists

If `data_fresh: false`, the backend is degraded. Run `af doctor --json --strict` first.

### 2. Discover

Find the right building blocks before writing JSON:

```bash
af node-types search --query "<keyword>" --json    # Find nodes for your use case
af mcp-clients list --fields id,name,pattern --json # Available integrations
af schema agent --field <name> --json               # Payload shape for any field
af playbook <topic>                                 # Guided walkthrough
```

### 3. Draft

Write payload JSON in the correct project folder:

```
workspaces/<workspace>/<project-id>-<name>/agents/my-agent.json
```

Minimum valid agent payload:
```json
{
  "name": "My Agent",
  "tools": [],
  "project_id": "<from bootstrap>",
  "model": "agenticflow/glm-4.7-flash",
  "system_prompt": "You are ..."
}
```

Reference `templates/project-skeleton/agents/example-agent.json` for a full example with comments.

### 4. Validate

Always dry-run before deploying:

```bash
af agent create --body @agents/my-agent.json --dry-run --json
af workflow create --body @workflows/my-workflow.json --dry-run --json
af workforce init --blueprint marketing-agency --name "My Team" --dry-run --json
```

A dry-run returns the full payload that would be sent — inspect it for surprises.

### 5. Deploy

```bash
af agent create --body @agents/my-agent.json --json
af workforce init --blueprint <slug> --name "<name>" --json
```

Capture the returned `id` — you need it for run, update, and delete.

### 6. Test

```bash
af agent run --agent-id <id> --message "Hello" --json
af workforce run --workforce-id <id> --trigger-data '{"message":"Test"}'
```

Expect `{response, thread_id, status}`. Pass `--thread-id <tid>` to continue a conversation.

### 7. Iterate

Use `--patch` for incremental changes — never round-trip the full body:

```bash
af agent update --agent-id <id> --patch --body '{"system_prompt":"New prompt"}' --json
af agent update --agent-id <id> --patch --body '{"model":"agenticflow/gemini-2-5-flash-lite"}' --json
```

The CLI strips null-rejected fields automatically; stripped fields are logged to stderr.

## Error handling

Every error returns `{code, message, hint, details}`. Read `hint` first — it tells you the recovery command. Common patterns:

| Code | Cause | Recovery |
|------|-------|----------|
| 404 | Wrong ID | Run the matching `list` command |
| 422 | Bad payload | Check `details.payload.detail` for field name |
| 401 | Auth expired | `af whoami` / `af login` |

## Documentation step (often skipped, never should be)

After every deploy, update:
- `README.md` in the project folder — what it does, how to run it
- `changelog.md` in the project folder — date + what changed
