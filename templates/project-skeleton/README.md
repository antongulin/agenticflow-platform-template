# \u003cProject-ID\u003e — \u003cShort Name\u003e

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
| `agents/` | Agent JSON payloads (`af agent create --body @agent.json`) |
| `workflows/` | Workflow JSON payloads (`af workflow create --body @workflow.json`) |
| `workforces/` | Workforce graph payloads (`af workforce deploy --body @graph.json`) |
| `datasets/` | CSV / JSON seed files for knowledge base |
| `test-inputs/` | Sample payloads for `--dry-run` validation |

## How to run

```bash
# Example: run the agent
af agent run --agent-id \u003cagent_id\u003e --message \"Your prompt here\" --json

# Example: run the workflow
af workflow run --workflow-id \u003cworkflow_id\u003e --input @test-inputs/sample.json

# Example: run the workforce
af workforce run --workforce-id \u003cworkforce_id\u003e --trigger-data '{"message":"Your input"}'
```

## Changelog

- YYYY-MM-DD: created, tested, deployed.
