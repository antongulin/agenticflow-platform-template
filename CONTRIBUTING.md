# Contributing to AgenticFlow Platform Template

First off, thank you for considering contributing! This is a community template for anyone building AI-native automations on the [AgenticFlow](https://agenticflow.ai) platform.

## How to contribute

### Reporting issues

Found a bug, outdated node reference, or unclear documentation?

1. Check if the issue already exists in [GitHub Issues](../../issues).
2. If not, open a new issue with:
   - A clear title (e.g., "nodes.md outdated: `instagram-scraper` renamed to `instagram-scrapper`")
   - Steps to reproduce or the exact discrepancy you found
   - Expected vs actual behavior
   - If relevant, paste the output of `af bootstrap --json` (remove any API keys)

### Suggesting improvements

Have an idea for a better convention, a new skill, or a missing playbook mapping?

1. Open an issue labeled `enhancement`.
2. Describe the problem and your proposed solution.
3. If you're willing to implement it, say so — maintainers will assign it to you.

### Pull requests

We follow a simple process:

1. **Fork** the repository and create your branch from `main`.
2. **Make your changes** — keep them focused. One PR per concern.
3. **Update documentation** — if you change a convention, update `AGENTS.md`, `README.md`, and `docs/` as needed.
4. **Test** — run `./scripts/bootstrap.sh` and verify `af bootstrap --json` connectivity.
5. **Submit** your PR with a clear description.

#### PR checklist

- [ ] I have read `AGENTS.md` and followed the naming conventions.
- [ ] I did not commit `.env` or any real API keys.
- [ ] I updated the relevant `reference/*.md` if I changed node/model/playbook data.
- [ ] I checked that my changes do not break existing projects in `workspaces/` (if any).
- [ ] I added a line to the relevant `CHANGELOG.md` or `docs/decisions/` if this is an architecture change.

### Code conventions

- **No hardcoded secrets** — ever.
- **No hardcoded node IDs** in payload examples unless confirmed via `af node-types get`.
- **Use kebab-case** for filenames.
- **Keep references live-ish** — if the platform changes, mention it in the PR description.

### Commit messages

Use conventional commit prefixes:

| Prefix | Use for |
|---|---|
| `feat:` | New project skeleton, new skill, new reference doc |
| `fix:` | Outdated node name, broken command, typo |
| `docs:` | README, AGENTS.md, reference/*.md changes |
| `refactor:` | Restructuring without behavior change |
| `chore:` | Build scripts, .gitignore, formatting |

Example: `fix(nodes): rename instagram-scraper to instagram-scrapper per CLI output`

### What NOT to contribute

- **Your private workspace payloads** — `workspaces/` is meant for YOUR projects. Do not submit your business logic.
- **Your `.env`** — it's in `.gitignore` for a reason.
- **Vendor-specific integrations that require paid accounts** without documenting the free-tier fallback.

## Development setup

```bash
git clone <this-repo>
cd <repo-folder>
cp .env.example .env
# Edit .env with your keys
npm install -g @pixelml/agenticflow-cli
./scripts/bootstrap.sh
```

## Questions?

- Read [AGENTS.md](AGENTS.md) for the AI-agent guide.
- Read [README.md](README.md) for the human guide.
- Check [reference/](reference/) for platform docs.

Thanks for making the AgenticFlow ecosystem better!
