#!/usr/bin/env bash
# dontslopme zero-dependency installer for macOS, Linux, and WSL
# Supports: --global (default), --project, and --uninstall

set -euo pipefail

REPO_OWNER="zchuwie"
REPO_NAME="dontslopme"
REPO_BRANCH="main"
RAW_BASE="https://raw.githubusercontent.com/${REPO_OWNER}/${REPO_NAME}/${REPO_BRANCH}"

MODE="global"
UNINSTALL=false

for arg in "$@"; do
  case "$arg" in
    --global|-g)
      MODE="global"
      ;;
    --project|-p)
      MODE="project"
      ;;
    --uninstall|-u)
      UNINSTALL=true
      ;;
    --help|-h)
      echo "dontslopme installer"
      echo "Usage: ./install.sh [--global | --project | --uninstall]"
      echo "  --global    Install to user skills and detected IDE configurations (default)"
      echo "  --project   Install into current working directory"
      echo "  --uninstall Remove installed dontslopme skills"
      exit 0
      ;;
    *)
      echo "Unknown argument: $arg"
      exit 1
      ;;
  esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || echo "")"
LOCAL_SOURCE=""
if [ -n "$SCRIPT_DIR" ] && [ -d "$SCRIPT_DIR/skills/dontslopme" ]; then
  LOCAL_SOURCE="$SCRIPT_DIR"
fi

get_global_destinations() {
  local dests=()
  dests+=("$HOME/.agents/skills")

  if [ -d "$HOME/.cursor" ]; then
    dests+=("$HOME/.cursor/rules")
  fi
  if [ -d "$HOME/.continue" ]; then
    dests+=("$HOME/.continue/prompts")
  fi
  if [ -d "$HOME/.codeium/windsurf" ]; then
    dests+=("$HOME/.codeium/windsurf/memories")
  fi
  if [ -d "$HOME/.claude" ]; then
    dests+=("$HOME/.claude/skills")
  fi
  if [ -d "$HOME/.gemini" ]; then
    dests+=("$HOME/.gemini/skills")
  fi
  if [ -d "$HOME/.codex" ]; then
    dests+=("$HOME/.codex/skills")
  fi

  echo "${dests[@]}"
}

get_project_destinations() {
  local dests=()
  dests+=("$(pwd)/.agents/skills")

  if [ -d "$(pwd)/.cursor" ]; then
    dests+=("$(pwd)/.cursor/rules")
  fi
  if [ -d "$(pwd)/.continue" ]; then
    dests+=("$(pwd)/.continue/prompts")
  fi
  if [ -d "$(pwd)/.claude" ]; then
    dests+=("$(pwd)/.claude/skills")
  fi

  echo "${dests[@]}"
}

SKILL_FILES=(
  "skills/dontslopme/SKILL.md"
  "skills/dontslopme/references/codebase-discovery.md"
  "skills/dontslopme/references/copy-and-code-hygiene.md"
  "skills/dontslopme-ui/SKILL.md"
  "skills/dontslopme-ui/references/anti-slop-checklist.md"
  "skills/dontslopme-ui/references/ux-and-motion-spec.md"
)

install_to_dir() {
  local target_root="$1"
  echo "Installing dontslopme to: $target_root"

  for rel_path in "${SKILL_FILES[@]}"; do
    local stripped="${rel_path#skills/}"
    local dest_file="$target_root/$stripped"
    local dest_dir
    dest_dir="$(dirname "$dest_file")"
    mkdir -p "$dest_dir"

    if [ -n "$LOCAL_SOURCE" ] && [ -f "$LOCAL_SOURCE/$rel_path" ]; then
      cp "$LOCAL_SOURCE/$rel_path" "$dest_file"
    else
      local url="${RAW_BASE}/${rel_path}"
      curl -fsSL "$url" -o "$dest_file"
    fi
  done
}

uninstall_from_dir() {
  local target_root="$1"
  echo "Uninstalling dontslopme from: $target_root"
  rm -rf "$target_root/dontslopme"
  rm -rf "$target_root/dontslopme-ui"
}

if [ "$UNINSTALL" = true ]; then
  if [ "$MODE" = "global" ]; then
    DESTS=($(get_global_destinations))
  else
    DESTS=($(get_project_destinations))
  fi
  for d in "${DESTS[@]}"; do
    if [ -d "$d" ]; then
      uninstall_from_dir "$d"
    fi
  done
  echo "dontslopme uninstalled successfully."
  exit 0
fi

if [ "$MODE" = "global" ]; then
  DESTS=($(get_global_destinations))
else
  DESTS=($(get_project_destinations))
fi

for d in "${DESTS[@]}"; do
  install_to_dir "$d"
done

echo ""
echo "dontslopme installed successfully in $MODE mode."
echo "Active skills: dontslopme, dontslopme-ui"
