# Reference — Playbooks

> Source of truth: `af playbook --list --json`  
003e Last synced: April 21, 2026

---

## Available playbooks (17 total)

| Topic | Title | When to use |
|---|---|---|
| `first-touch` | First Touch — AI Agent Onboarding | **Start here.** Returns auth, agents, models, blueprints. |
| `quickstart` | Quickstart: Zero to Working Agent in 5 Min | Executable onboarding, every step has verification. |
| `composition-ladder` | Composition Ladder — Workflow → Agent → Workforce | Learn when to use workflow vs agent vs workforce. |
| `agent-build` | Build Agents | Create and operate agents with tool configs. |
| `workflow-build` | Build Workflows | Design a linear node pipeline and publish it. |
| `workflow-run` | Run Workflows | Execute a workflow and monitor the run lifecycle. |
| `agent-channels` | Connect Agents to External Channels | Route work from Linear, GitHub, Slack, webhooks. |
| `gateway-setup` | Gateway: Receive Tasks From Any Platform | Set up webhook gateway for external routing. |
| `mcp-client-quirks` | MCP Client Quirks — Pipedream vs Composio | Learn the known Pipedream write-tool failure mode. |
| `mcp-to-cli-map` | MCP To CLI Mapping | Replace MCP actions with native CLI commands. |
| `marketplace-vs-blueprint` | Blueprint vs Marketplace | Choose CLI blueprints vs marketplace templates. |
| `amazon-seller` | Amazon Seller AI Team | Deploy a 5-agent team for Amazon SG sellers. |
| `company-from-scratch` | Create an AI Company from Scratch | Build a complete Paperclip company from commands. |
| `migrate-from-paperclip` | Migrate from `af paperclip` to `af workforce` | Paperclip is deprecated (sunset 2026-10-14). |
| `deploy-to-paperclip` | Deploy Agents to Paperclip (DEPRECATED) | Don't use — prefer `af workforce`. |
| `template-bootstrap` | Bootstrap From Templates | Fetch template samples locally for composition. |
| `ready-prompts` | Copy-Paste User Prompts | Hand pre-written prompts to users for common flows. |

---

## How to run

```bash
# Full walkthrough (text output)
af playbook first-touch

# Quick list
af playbook --list --json
```
