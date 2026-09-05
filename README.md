# git-token-auth

A lightweight, zero-dependency Git credential helper designed for shared development environments (e.g., Virtual Machines, jump hosts, or shared servers).

It bypasses the redundant `Username` prompt from Git HTTPS authentication and prompts **only** for your GitHub Personal Access Token (PAT).

## Problem

Since GitHub deprecated password authentication, standard Git HTTPS authentication requires:
1. Entering a username (which GitHub ignores when a PAT is provided).
2. Entering the Personal Access Token as the password.

In shared environments where developers share system accounts, saving global credentials is unsafe. Typing an unnecessary username on every `git pull` or `git push` creates friction.

## Solution

`git-token-auth` intercepts Git credential requests at the repository level and automatically injects the required token scope, prompting the user exclusively for their Personal Access Token.

- **Single Prompt:** Asks only for the PAT.
- **Zero Disk Persistence:** Tokens exist in memory only during the Git action execution.
- **Accurate Audit Trails:** Ensures GitHub logs reflect the exact developer token used for the operation.
- **Local Scope:** Configured per-repository without altering global system settings.

## Installation

### Option 1: Quick Install (Recommended)

Run the installation script to place the binary into `~/.local/bin`:

```bash
curl -sSL [https://raw.githubusercontent.com/ale94lko/git-token-auth/main/install.sh](https://raw.githubusercontent.com/ale94lko/git-token-auth/main/install.sh) | bash
```

### Option 2: Manual Clone

```bash
git clone [https://github.com/ale94lko/git-token-auth.git](https://github.com/ale94lko/git-token-auth.git)
cd git-token-auth
chmod +x bin/git-token-auth
# Optionally add ./bin to your PATH or copy to /usr/local/bin
```

## Usage

1. Navigate to any Git repository where you want to enable token-only prompts:

```bash
cd /path/to/your/repository
```
2. Initialize `git-token-auth` for the current repository:

```bash
git-token-auth init
```

3. Run standard Git commands:

```bash
git pull
```

Output:

```
🔑 Enter your GitHub Personal Access Token:
Already up to date.
```

## How It Works
`git-token-auth` leverages Git's native `credential.helper` hook configured at the local repository level (`.git/config`):

```
Ini, TOML

[credential]
    helper = !/path/to/git-token-auth
```

When Git requests authentication credentials, the helper outputs username=x-access-token (the standard username header accepted by GitHub for PATs) alongside the interactively collected token.

## License

**git-token-auth** is an open source project licensed under [MIT](https://opensource.org/licenses/MIT).