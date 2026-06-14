#!/usr/bin/env bash
set -euo pipefail

# Installs caffeinate on macOS (built-in) or Linux (via caffeinate-linux).
# Source: https://github.com/ArpitSuthar/caffeinate-linux (AGPL-3.0)

OS="$(uname -s)"

if [[ "$OS" == "Darwin" ]]; then
    if command -v caffeinate &>/dev/null; then
        echo "caffeinate is already available at $(command -v caffeinate)"
    else
        echo "caffeinate not found — it should be built into macOS at /usr/bin/caffeinate"
        echo "Try: xcode-select --install"
        exit 1
    fi
elif [[ "$OS" == "Linux" ]]; then
    if command -v caffeinate &>/dev/null; then
        echo "caffeinate is already available at $(command -v caffeinate)"
        exit 0
    fi

    echo "Installing caffeinate-linux..."
    curl -fsSL https://raw.githubusercontent.com/ArpitSuthar/caffeinate-linux/main/caffeinate \
        | sudo install -m 755 /dev/stdin /usr/local/bin/caffeinate

    echo "Installed: $(command -v caffeinate)"
else
    echo "Unsupported OS: $OS"
    exit 1
fi

echo ""
echo "Usage:"
echo "  caffeinate                  keep system awake indefinitely"
echo "  caffeinate -t 3600          prevent sleep for 1 hour"
echo "  caffeinate -i ./script.sh   run command with idle sleep blocked"
echo ""
echo "Claude Code plugin (macOS):"
echo "  /plugin marketplace add jul-sh/claude-plugins"
echo "  /plugin install caffeinate@jul-sh"
