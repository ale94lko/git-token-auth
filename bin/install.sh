#!/bin/bash
set -e

INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"

echo "Downloading git-token-auth..."
curl -sSL https://raw.githubusercontent.com/ale94lko/git-token-auth/main/bin/git-token-auth -o "$INSTALL_DIR/git-token-auth"
chmod +x "$INSTALL_DIR/git-token-auth"

echo "✅ Installed to $INSTALL_DIR/git-token-auth"

case ":$PATH:" in
  *":$INSTALL_DIR:"*)
    echo "Run 'git-token-auth init' inside any repository to enable it."
    ;;
  *)
    PATH_LINE='export PATH="$HOME/.local/bin:$PATH"'
    SHELL_RC=""
    if [ -n "${BASH_VERSION:-}" ] || [ -f "$HOME/.bashrc" ]; then
      SHELL_RC="$HOME/.bashrc"
    elif [ -f "$HOME/.zshrc" ]; then
      SHELL_RC="$HOME/.zshrc"
    elif [ -f "$HOME/.profile" ]; then
      SHELL_RC="$HOME/.profile"
    fi

    if [ -n "$SHELL_RC" ] && ! grep -qsF "$PATH_LINE" "$SHELL_RC"; then
      echo "" >> "$SHELL_RC"
      echo "# Added by git-token-auth installer" >> "$SHELL_RC"
      echo "$PATH_LINE" >> "$SHELL_RC"
      echo "Added $INSTALL_DIR to PATH in $SHELL_RC"
    fi

    echo "For this session, run:"
    echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo "Then run 'git-token-auth init' inside any repository."
    ;;
esac
