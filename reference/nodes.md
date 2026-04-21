# Node Type Reference — AgenticFlow.ai

> Auto-generated or manually maintained from `af node-types list --json` and `af node-types search --query "..." --json`.  
> Last updated: April 21, 2026. Run `af node-types list --json` to verify freshness.

---

## Node taxonomy

Nodes are grouped by **functional layer**. This helps you quickly pick the right tool for your workflow/agent.

### A — Intelligence (web + reasoning)
These nodes give agents eyes on the internet + direct LLM prompting.

| Node ID | Description | Typical use |
|---|---|---|
| `web-scraping` | Extract raw HTML/content from a URL | Price monitoring, news aggregation |
| `web-search` | Real-time web search for recent results | Trend research, competitive intel |
| `web-retrieval` | Feed specific URLs as context to LLM | Deep-dive reading, citation chains |
| `url-to-markdown` | Clean article extraction | Newsletter generation, report sourcing |
| `extract-content` | Structured content extraction (schema-defined) | Parse product specs, form fields, tables |
| `ask-ai` | Direct LLM prompt — classify, summarize, rewrite | Any reasoning step inside a workflow |
| `run-javascript` | Execute custom JS for data transformation | String parsing, calculations, reformatting |
| `get-current-datetime` | Get current date/time with components | Scheduling, TTL checks, timestamping |

**Usage frequency:** High. Most workflows contain at least one of these.

---

### B — Knowledge (native RAG / data layer)
These nodes manage structured datasets and perform semantic search — replacing the need for external vector DBs.

| Node ID | Description | Typical use |
|---|---|---|
| `knowledge-retrieval` | Semantic search over uploaded datasets | FAQ bot, runbook lookup, internal wiki |
| `query-data` | SQL-like filter/sort on dataset rows | Reporting, conditional routing |
| `update-data` | Conditional row update | Mark processed leads, update statuses |
| `insert-data` | Append new rows to a dataset | Capture form submissions, log decisions |
| `get-item-by-path` | Navigate Drive-like storage by absolute path | Pull a specific file for analysis |
| `list-items` | Browse Drive folders | "List all files in /reports/Q2" |
| `export-data-to-file` | Write to S3, get public URL | CSV/JSON export for download |
| `convert-string-to-json` | Parse text to structured JSON | Normalize LLM outputs |
| `get-value-by-key` | Object path extraction | Pull nested fields from JSON |

**Usage frequency:** High for agent-backed workflows. Medium for pure automation.

---

### C — Action (output to world)
These nodes act on external systems or generate media.

| Node ID | Description | Typical use |
|---|---|---|
| `send-email` | SMTP dispatch to arbitrary recipients | Alerts, digests, outreach |
| `json-to-google-sheet` | Create/populate a Google Sheet | Reporting, dashboards, shared logs |
| `generate-image` | AI image generation from text prompt | Marketing creatives, thumbnails, social media |
| `html-to-image` | Render HTML to image file | Invoice snapshots, report cards |
| `text-to-music` | AI music/audio generation | Podcast intros, background tracks |
| `api-call` | Generic HTTP request (GET/POST/PUT/DELETE) | Any REST API not covered by built-ins |

**Usage frequency:** Medium. Usually at the end of a workflow.

---

### D — Social & Marketing
Vertical tools for brand, content, and paid media workflows.

| Node ID | Description | Typical use |
|---|---|---|
| `instagram-scrapper` | Pull posts from a public Instagram profile | Content audit, influencer vetting |
| `instagram-profile-analyzer` | Extract metrics + demographics | "Should we partner with this influencer?" |
| `social-profile-analyzer` | Cross-platform brand health check | Monitor mentions, sentiment trends |
| `search-video-in-pexels` | Search stock video | Video ad assembly |
| `search-sound-in-youtube-sound-library` | Search royalty-free audio | Background music for content |
| `create-pinpoint-campaign` | Paid media campaign creation | Media activation |
| `import-pinpoint-segment` | Audience segment import | Targeted campaign setup |
| `segment-user` / `segment-user-v2` | Behavioral user segmentation | "Users who did X but not Y in last 30 days" |
| `create-cx-agent` / `create-cx-agent-v2` | Create a customer experience bot | Tier-1 support automation |

**Usage frequency:** Low to medium. Depends on domain (GBP, marketing agency, etc.).

---

### E — Orchestration (meta)
These nodes control other workflows, manage state, and handle task delegation.

| Node ID | Description | Typical use |
|---|---|---|
| `list-agent-tasks` | List all agent tasks with optional filters | Dashboard, SLA tracking |
| `create-agent-task` | Assign work to a specific agent | "Research this topic and report back" |
| `get-agent-task` | Check task status by ID | Polling for completion |
| `update-agent-task` | Modify task parameters | Re-prioritize, change deadline |
| `delete-agent-task` | Cancel an assigned task | Error recovery |
| `create-multiple-agent-tasks` | Batch delegation (JSON input) | Campaign launches, bulk processing |
| `call-other-workflow` | Reusable sub-workflow invocation | DRY principle — shared components |
| `set-variable` | Store a value for downstream nodes | Workflow memory, counters, flags |
| `get-variable` | Retrieve stored value | Read state set by `set-variable` |
| `echo` | Passthrough / debug inspector | Inspect intermediate state |

**Usage frequency:** Medium to high for multi-step workflows.

---

## Node properties reference

To see the **exact schema** of a node (parameters, required fields, dynamic options):

```bash
# Full node definition
af node-types get --name <node-id> --json

# Example: send-email
af node-types get --name send-email --json

# Search by keyword
af node-types search --query "email" --json
af node-types search --query "knowledge" --json
af node-types search --query "image" --json
```

## Dynamic options

Some nodes expose **dynamic options** — values that change based on your workspace state (e.g., available connections, knowledge bases):

```bash
af node-types dynamic-options --node-name <name> --field <field> --json
```

## How to update this file

When the platform adds or removes nodes:

1. Run `af node-types list --json`
2. Compare output to this file
3. Add/remove rows accordingly
4. Update the "Last updated" date at the top

Do **not** hard-code node IDs in workflow JSONs without verifying them through `af node-types get` first — IDs are mostly stable, but new versions occasionally change parameter schemas.
