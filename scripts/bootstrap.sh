#!/bin/bash
set -euo pipefail

# bootstrap.sh — source .env and orient the system

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$DIR/.." && pwd)"

# Source environment if present
ENV_FILE="$ROOT/.env"
if [ -f "$ENV_FILE" ]; then
  set -a
  source "$ENV_FILE"
  set +a
  echo "✅ Loaded .env"
else
  echo "⚠️  No .env found at $ENV_FILE — some CLI commands may fail."
fi

# Show state
if command -v af &> /dev/null; then
  af doctor --json --strict || true
  echo "---"
  af bootstrap --json 2>/dev/null || echo "⚠️ af bootstrap failed — check API key / network."
else
  echo "❌ AgenticFlow CLI not found. Install with: npm install -g @pixelml/agenticflow-cli"
  exit 1
fi
