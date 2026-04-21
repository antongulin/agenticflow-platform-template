# Why AgenticFlow?

A pragmatic comparison for automation builders.

## The landscape

| Tool | Good at | Less good at |
|---|---|---|
| **n8n** | 400+ native app integrations; self-hosting | No native multi-agent orchestration; manual LLM wiring |
| **Zapier** | Simple 1:1 triggers; non-technical users | Expensive at scale; no reasoning steps |
| **Make** | Visual builders; complex conditional logic | No built-in LLM / RAG |
| **AgenticFlow** | Native LLM agents, workflows, AND workforces; built-in RAG | Fewer native app integrations (use MCP to compensate) |

## When to choose AgenticFlow

- Your automations **need reasoning** (not just "when X, do Y")
- You want **multi-agent pipelines** (researcher → writer → editor)
- You want **built-in vector search** without setting up Pinecone/Weaviate
- You want **free-tier LLMs** that are genuinely useful (GLM-4.7 Flash)
- You're comfortable with a CLI and infrastructure-as-code

## When to stick with n8n/Zapier

- Your pipelines are purely app-to-app (e.g. "new Stripe charge → add to Google Sheet → Slack notify")
- You have non-technical team members who need a visual builder
- You need advanced error handling / branching that no-code tools handle better

## The hybrid approach

Many teams use **both**:
- n8n for simple integrations and triggers
- AgenticFlow for anything involving LLM reasoning, research, content generation, or multi-agent collaboration

That's exactly what this template repo is designed for.
