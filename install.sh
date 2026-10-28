#!/usr/bin/env bash
# Runs automatically when a GitHub Codespace is created or rebuilt.
# Installs Claude Code so it is ready in every Codespace.

set -u

if command -v claude >/dev/null 2>&1; then
  echo "Claude Code already installed: $(claude --version 2>/dev/null)"
  exit 0
fi

echo "Installing Claude Code..."
if command -v npm >/dev/null 2>&1; then
  npm install -g @anthropic-ai/claude-code
else
  curl -fsSL https://claude.ai/install.sh | bash
fi

echo "Done. Run 'claude' to start."
