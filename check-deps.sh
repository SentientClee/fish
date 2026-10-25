#!/usr/bin/env bash
# Checks that everything this fish config depends on is installed.
# It never installs anything: it only reports what is missing.

set -u

# --- Dependency lists (edit these) -------------------------------------------
# Programs that must be on PATH
REQUIRED_COMMANDS=(fish eza zoxide bat fzf fastfetch starship)

# Programs that are nice to have but not essential
OPTIONAL_COMMANDS=(tldr pkgfile)

# Fish functions that prove a fish plugin is installed (checked from inside fish)
# _pure_prompt comes from the Pure prompt
# REQUIRED_FISH_FUNCTIONS=(fisher _pure_prompt _autopair_insert_left)
# -----------------------------------------------------------------------------

missing=0

warn() { printf 'WARN: %s\n' "$1" >&2; }
ok()   { printf 'ok:   %s\n' "$1"; }

# 1. Required commands
for cmd in "${REQUIRED_COMMANDS[@]}"; do
  if command -v "$cmd" >/dev/null 2>&1; then
    ok "$cmd"
  else
    warn "required command not found: $cmd"
    missing=1
  fi
done

# 2. Optional commands
for cmd in "${OPTIONAL_COMMANDS[@]}"; do
  if command -v "$cmd" >/dev/null 2>&1; then
    ok "$cmd (optional)"
  else
    warn "optional command not found: $cmd"
  fi
done

# NOTE: Avoiding the use of plugins for now for a lean config.
#
# 3. Fish plugins (needs fish itself)
# if command -v fish >/dev/null 2>&1; then
#   for fn in "${REQUIRED_FISH_FUNCTIONS[@]}"; do
#     if fish -c "functions -q $fn" >/dev/null 2>&1; then
#       ok "fish function $fn"
#     else
#       warn "fish function not found: $fn (is the plugin installed?)"
#       missing=1
#     fi
#   done
# else
#   warn "skipping fish plugin checks because fish is missing"
# fi

# 4. Nerd Font for eza's icons (only a hint: can't verify what the terminal uses)
if command -v fc-list >/dev/null 2>&1; then
  if fc-list | grep -qi 'nerd'; then
    ok "a Nerd Font is installed"
  else
    warn "no Nerd Font found; eza icons may show as boxes"
  fi
fi

# check pkgfile database exists
if command -v pkgfile >/dev/null 2>&1; then
  if pkgfile pacman 2>&1 | grep -q 'Database version file not found'; then
    warn "pkgfile database missing: run 'sudo pkgfile --update'"
  else
    ok "pkgfile database present"
  fi
fi

# 5. Is this repo where fish will read it from?
fish_dir="${XDG_CONFIG_HOME:-$HOME/.config}/fish"
repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
if [ -d "$fish_dir" ] && [ "$(cd "$fish_dir" && pwd -P)" = "$repo_dir" ]; then
  ok "config is at $fish_dir"
else
  warn "this repo is not at $fish_dir (clone or symlink it there)"
fi

echo
if [ "$missing" -eq 0 ]; then
  echo "All required dependencies found."
else
  echo "Some required dependencies are missing. Install them with your package manager and re-run." >&2
  exit 1
fi
