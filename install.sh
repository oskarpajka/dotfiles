#!/usr/bin/env bash
# Runs automatically when a GitHub Codespace is created or rebuilt.
# 1. Installs Claude Code.
# 2. Writes the Hackatime config from the HACKATIME_API_KEY Codespaces secret,
#    so time keeps tracking after rebuilds.

set -u

# --- Claude Code ---
if command -v claude >/dev/null 2>&1; then
  echo "Claude Code already installed: $(claude --version 2>/dev/null)"
else
  echo "Installing Claude Code..."
  if command -v npm >/dev/null 2>&1; then
    npm install -g @anthropic-ai/claude-code
  else
    curl -fsSL https://claude.ai/install.sh | bash
  fi
fi

# --- Hackatime ---
if [ -n "${HACKATIME_API_KEY:-}" ]; then
  cat > "$HOME/.wakatime.cfg" <<CFG
[settings]
api_url = https://hackatime.hackclub.com/api/hackatime/v1
api_key = ${HACKATIME_API_KEY}
heartbeat_rate_limit_seconds = 30
CFG
  chmod 600 "$HOME/.wakatime.cfg"
  echo "Hackatime config written."
else
  echo "HACKATIME_API_KEY secret not set, skipping Hackatime config."
fi

echo "Done."
