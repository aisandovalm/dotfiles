#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
ln -sfn "$DIR" ~/.dotfiles
# --impure: home.nix reads the protex-intelligence/brain repo (outside this
# flake) at eval time to auto-discover skills; pure eval silently treats
# that path as nonexistent and returns no skills, so this flag is required.
exec sudo darwin-rebuild switch --flake ~/.dotfiles#mac --impure
