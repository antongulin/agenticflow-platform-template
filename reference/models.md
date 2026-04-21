# Reference — Models

> Source of truth: `af bootstrap --json | jq '.models[]'`  
> Last synced: April 21, 2026 (from unauthenticated CLI call — models list is public)

---

## Available models (AgenticFlow free tier)

| Model ID | Tier | Notes |
|---|---|---|
| `agenticflow/gemma-4-31b-it` | Free | General-purpose, correct |
| `agenticflow/gemma-4-26b-a4b-it` | Free | General-purpose, slightly smaller |
| `agenticflow/gemini-2.0-flash` | Free | Deprecated / legacy, use with caution |
| `agenticflow/gpt-4o-mini` | Free | Fast (6s), high-volume, good for simple tasks |
| `agenticflow/deepseek-v3.2` | Free | Heavier reasoning |
| `agenticflow/qwen-3.5-flash` | Free | Deep verification, deepest thinker |

### Not confirmed by bootstrap but known from model-benchmark

These may be account-dependent or require a specific plan:

| Model ID | Tier | Notes |
|---|---|---|
| `agenticflow/glm-4.7-flash` | Free | **Smartest text model** — default for 80% of tasks |
| `agenticflow/gemini-2.5-flash-lite` | Free | **Only model with audio + video**, 1M context |
| `agenticflow/gpt-5-nano` | Free | Deep reasoning + vision combined |
| `agenticflow/deepseek-v3.2-speciale` | Free | Hardest coding/competition math |

**Note from CLI:** Model IDs are never hardcoded — the CLI validates your string at create time. Typos fail fast with an actionable hint listing the known set.

---

## Model selection guide

See `skills/agenticflow-llm-models/SKILL.md` for full decision flow and reasoning configuration.

Quick table:

| Task | Recommended model |
|---|---|
| Default text agent | GLM-4.7 Flash |
| Image/audio/video input | Gemini 2.5 Flash Lite |
| Deep verification / QA | Qwen 3.5 Flash |
| Hard coding / math | DeepSeek V3.2 Speciale |
| Vision + reasoning | GPT-5 Nano |
| Maximum speed (no reasoning) | GPT-4o-mini |

---

## How to update

Run `af bootstrap --json` and replace the models table above.
