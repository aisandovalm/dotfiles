# Project notes for agents

## Installing new apps/CLI tools on this machine

Never `brew install` or otherwise install software ad-hoc - `homebrew.onActivation.cleanup = "zap"` (see below) means anything not declared here gets removed on the next rebuild anyway. Everything must be declared in this repo:

- CLI tools available via nixpkgs -> add to `home.packages` in `home.nix` (e.g. `ripgrep`, `jq`, `gh`).
- GUI apps, or things only available/better maintained via Homebrew -> add to `homebrew.casks` (GUI apps) or `homebrew.brews` (CLI) in `configuration.nix`.
- After editing either file, apply with `./rebuild.sh`, which runs `sudo darwin-rebuild switch --flake ~/.dotfiles#mac --impure` (the `--impure` flag is required because `home.nix` reads the protex-intelligence/brain repo, which lives outside this flake, to auto-discover Claude Code skills).
  - This needs an interactive TTY for the sudo password prompt. It fails with "a terminal is required to read the password" when run from a non-interactive shell (e.g. an agent's sandboxed Bash tool) - it must be run by the user directly in a real terminal app (Terminal.app, iTerm, etc.), not piped through automated tooling.

Deliberate decisions in this repo - do NOT silently revert them:

- `homebrew.onActivation.cleanup = "zap"` in `configuration.nix` is intentional. It forces the good habit of declaring every Homebrew package in the Nix config instead of installing things ad-hoc, which keeps the machine reproducible. Do not soften it to `uninstall` or `none`. Users are warned about its effect in README.md; this note is for anyone tempted to change the setting itself.
- Never commit `.no-mistakes/` validation evidence to this public repo. `.no-mistakes/` is gitignored; if a validation pipeline stages evidence into a branch, drop it before merging.