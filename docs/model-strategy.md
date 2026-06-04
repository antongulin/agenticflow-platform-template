# Model Strategy & Credit Optimization — AgenticFlow Platform Template

## Free-tier model stack

The platform has ~30+ models. For 90% of work, use these five:

| Slot | Model | When to use |
|------|-------|-------------|
| **Default** | GLM-4.7 Flash | 80% of tasks — chat, reasoning, JSON, tools, coding. Fastest + cheapest. |
| **Multimodal** | Gemini 2.5 Flash Lite | Images, audio, video, OCR, docs >200K tokens |
| **Deep reasoning** | GPT-5 Nano | Vision + logic combined, OpenAI-style workflows |
| **Verification** | Qwen 3.5 Flash | QA passes, fact-checking, accuracy-critical steps |
| **Hardest problems** | DeepSeek V3.2 Speciale | Competition math, complex code generation |

Model IDs change between CLI releases. Always read from `af bootstrap --json > models[]` rather than hardcoding. The CLI validates your model string at create time and lists the known set on error.

## Credit consumption reference

| Plan | Credits/month | Break-even examples |
|------|--------------|---------------------|
| Free ($0) | ~3,000 (100/day) | 6 daily workflow runs |
| Pro ($19) | 7,500 | 1–2 daily workflows |
| Team ($199) | 100,000 | Multiple teams, moderate volume |
| Business ($599) | 300,000 | Production workforces, high volume |
| Enterprise | Custom | — |

Add-on packs: $20 per 10,000 credits.

Approximate costs:
- Single workflow run: ~5,000 credits
- Weekly workforce run: ~15,000 credits
- Single knowledge query: ~500 credits
- Full-context chat (500 turns): ~1,000 each (500K total — exceeds Business)

## Cost optimization rules

1. **Default to GLM-4.7 Flash** — it handles 80% of tasks at the lowest credit cost.
2. **Gemini only for media or long context** — don't use 1M context when 8K is enough.
3. **Cache in variables/datasets** — don't re-query the same data on every run.
4. **Use Extract Content with tight schemas** — minimize output tokens by specifying exactly what fields you need.
5. **Use Knowledge Retrieval instead of full-doc context** — semantic search is much cheaper than stuffing entire documents into the system prompt.
6. **Batch with workflows** — one workflow run that processes 10 items costs less than 10 agent runs.

## Model selection decision tree

```
Does the task involve images, audio, video, or docs > 200K tokens?
  → YES: Gemini 2.5 Flash Lite
  → NO: Does it require verified, high-stakes accuracy?
    → YES: Qwen 3.5 Flash (verification pass after GLM draft)
    → NO: Is it a hard coding or math problem?
      → YES: DeepSeek V3.2 Speciale
      → NO: GLM-4.7 Flash (default)
```

When in doubt, GLM-4.7 Flash first — escalate only if quality is insufficient.

## External model escalation

If no free-tier model meets quality requirements, escalate via:
1. API Call node → any external provider endpoint
2. Custom MCP with your own provider key

Document the escalation decision in the project's `docs/decisions/` folder as an ADR.
