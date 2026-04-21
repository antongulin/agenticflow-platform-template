# Reference — MCP Clients

> Inspect before attaching.  
> Use `af mcp-clients list --json` and `af mcp-clients inspect --id <id> --json` to get live data.

---

## Safety classification

Before attaching ANY MCP to an agent:
```bash
af mcp-clients inspect --id <id> --json
```

| pattern | Meaning | Writes safe? |
|---|---|---|
| `composio` | Structured schemas, multiple named fields | Yes |
| `pipedream` | Single `{instruction: string}` input | Inspect first — parametric writes may loop |
| `mixed` | Some Composio, some Pipedream | Allow only Composio tools |
| `unknown` | Could not enumerate tool list | Do NOT attach |

---

## Known quirks

- **Pipedream write loop:** Parametric writes (`add-row`, `update-cell`, `append`) may get stuck in `configure_props_<tool>_props` configuration loop. Use Composio-backed clients instead.
- **Stale auth:** `af mcp-clients list` caches `is_authenticated`. Reconcile with `af mcp-clients list --verify-auth --json`.
- **Re-auth:** If `classification_reason: fetch_failed` or `unauthenticated`, re-authenticate via the web UI before attaching.

---

## How to attach safely

```bash
# Step 1: list available
af mcp-clients list --name-contains "google sheets" --fields id,name,is_authenticated --json

# Step 2: inspect before attach
af mcp-clients inspect --id <id> --json

# Step 3: attach with allow/block per tool
af agent update --agent-id <agent_id> --patch --body '{
  "mcp_clients": [
    {
      "mcp_client_id": "<id>",
      "run_behavior": "auto_run",
      "tools": {
        "GOOGLESHEETS_SPREADSHEETS_VALUES_APPEND": {"allowed": true},
        "GOOGLESHEETS_DELETE_SHEET": {"allowed": false}
      }
    }
  ]
}' --json
```

See `skills/agenticflow-mcp/SKILL.md` for full details.
