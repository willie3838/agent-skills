#!/usr/bin/env bash
# install.sh - Port and install agent skills into local agent environments
# Supported targets:
#   - Google Jetski / Gemini CLI: ~/.gemini/config/skills/
#   - Google Agents CLI (ADK):    ~/.agents/skills/
#   - Anthropic Claude Code:      ~/.claude/skills/
#   - Custom directory:           -d /path/to/target

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="${SCRIPT_DIR}/skills"

# Defaults
MODE="copy" # copy or symlink
TARGET_DIR="${HOME}/.gemini/config/skills"
CHOSEN_SKILLS=()

usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS] [SKILL_NAME ...]

Install or link agent skills into your agent harness directory.

Options:
  -d, --target <path>     Target skills directory (default: ~/.gemini/config/skills)
  -g, --gemini            Install into ~/.gemini/config/skills (default)
  -a, --agents            Install into ~/.agents/skills
  -c, --claude            Install into ~/.claude/skills
  -s, --symlink           Symlink skills instead of copying
  -cp, --copy             Copy files directly (default)
  -l, --list              List available skills in this repository
  -h, --help              Show this help message

Examples:
  ./install.sh                       # Copies all skills to ~/.gemini/config/skills
  ./install.sh -s                    # Symlinks all skills to ~/.gemini/config/skills
  ./install.sh i-have-adhd           # Installs only the 'i-have-adhd' skill
  ./install.sh -d ~/.claude/skills   # Installs into Claude skills directory
EOF
  exit 0
}

list_skills() {
  echo "Available skills in this repository:"
  for dir in "${SKILLS_DIR}"/*; do
    if [ -d "${dir}" ] && [ -f "${dir}/SKILL.md" ]; then
      name="$(basename "${dir}")"
      desc="$(grep -m 1 "^description:" "${dir}/SKILL.md" | sed 's/^description:[[:space:]]*//' | tr -d "'" | tr -d '"' | cut -c 1-80)"
      printf "  %-20s %s...\n" "${name}" "${desc}"
    fi
  done
  exit 0
}

# Parse flags
while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      usage
      ;;
    -l|--list)
      list_skills
      ;;
    -d|--target)
      TARGET_DIR="$2"
      shift 2
      ;;
    -g|--gemini)
      TARGET_DIR="${HOME}/.gemini/config/skills"
      shift
      ;;
    -a|--agents)
      TARGET_DIR="${HOME}/.agents/skills"
      shift
      ;;
    -c|--claude)
      TARGET_DIR="${HOME}/.claude/skills"
      shift
      ;;
    -s|--symlink)
      MODE="symlink"
      shift
      ;;
    -cp|--copy)
      MODE="copy"
      shift
      ;;
    -*)
      echo "Unknown option: $1" >&2
      usage
      ;;
    *)
      CHOSEN_SKILLS+=("$1")
      shift
      ;;
  esac
done

# If no skills specified, select all available
if [ ${#CHOSEN_SKILLS[@]} -eq 0 ]; then
  for dir in "${SKILLS_DIR}"/*; do
    if [ -d "${dir}" ] && [ -f "${dir}/SKILL.md" ]; then
      CHOSEN_SKILLS+=("$(basename "${dir}")")
    fi
  done
fi

mkdir -p "${TARGET_DIR}"

echo "=========================================================="
echo " Agent Skills Installer"
echo " Target directory: ${TARGET_DIR}"
echo " Mode:             ${MODE}"
echo " Skills to install: ${CHOSEN_SKILLS[*]}"
echo "=========================================================="

for skill in "${CHOSEN_SKILLS[@]}"; do
  src="${SKILLS_DIR}/${skill}"
  dest="${TARGET_DIR}/${skill}"

  if [ ! -d "${src}" ]; then
    echo "[-] Error: Skill '${skill}' does not exist in ${SKILLS_DIR}" >&2
    continue
  fi

  if [ -e "${dest}" ] || [ -L "${dest}" ]; then
    echo "[!] Removing existing destination: ${dest}"
    rm -rf "${dest}"
  fi

  if [ "${MODE}" = "symlink" ]; then
    ln -s "${src}" "${dest}"
    echo "[+] Symlinked: ${dest} -> ${src}"
  else
    cp -r "${src}" "${dest}"
    echo "[+] Copied: ${src} -> ${dest}"
  fi
done

echo ""
echo "Installation complete!"
