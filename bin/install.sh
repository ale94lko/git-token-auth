#!/bin/bash
set -e

INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"

echo "Downloading git-token-auth..."
curl -sSL https://raw.githubusercontent.com/ale94lko/git-token-auth/main/bin/git-token-auth -o "$INSTALL_DIR/git-token-auth"
chmod +x "$INSTALL_DIR/git-token-auth"

echo "✅ Installed to $INSTALL_DIR/git-token-auth"
echo "Make sure $INSTALL_DIR is in your PATH."
echo "Run 'git-token-auth init' inside any repository to enable it."