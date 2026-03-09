#!/usr/bin/env bash
# ╔═══════════════════════════════════════════════════════════╗
# ║  TOOLSCAN v1.0 — Cyberdeck Dependency Tracker            ║
# ║  Verifies & installs tools required by dotfiles           ║
# ╚═══════════════════════════════════════════════════════════╝
set -euo pipefail

# ── Colors ───────────────────────────────────────────────────
R=$'\e[0m'
DIM=$'\e[2m'
BOLD=$'\e[1m'

CYAN=$'\e[38;2;125;207;255m'
MAGENTA=$'\e[38;2;187;154;247m'
PINK=$'\e[38;2;247;118;142m'
YELLOW=$'\e[38;2;224;175;104m'
GREEN=$'\e[38;2;158;206;106m'
BLUE=$'\e[38;2;122;162;247m'
GREY=$'\e[38;2;65;72;104m'
WHITE=$'\e[38;2;192;202;245m'

BG_GREEN=$'\e[48;2;20;50;30m'
BG_RED=$'\e[48;2;60;20;30m'
BG_YELLOW=$'\e[48;2;50;40;15m'

# ── Tool Registry ────────────────────────────────────────────
# Format: "command:brew_package:used_by"
# Use "CASK:" prefix for cask installs, "SKIP" for manual installs
TOOLS=(
  "git:git:.gitconfig"
  "vim:vim:.vimrc .gitconfig"
  "tmux:tmux:tmux.conf"
  "starship:starship:.zshrc"
  "zoxide:zoxide:.zshrc"
  "fzf:fzf:.zshrc .vimrc"
  "fd:fd:.zshrc .vimrc"
  "atuin:atuin:.zshrc"
  "direnv:direnv:.zshrc"
  "eza:eza:.zshrc"
  "bat:bat:.zshrc"
  "rg:ripgrep:.zshrc"
  "lazygit:lazygit:.zshrc"
  "delta:git-delta:.gitconfig .zshrc"
  "rtk:rtk:claude-code"
)

FONTS=(
  "JetBrainsMonoNerdFont-Regular:font-jetbrains-mono-nerd-font:ghostty/config"
)

APPS=(
  "ghostty:ghostty:ghostty/config"
)

# ── Counters ─────────────────────────────────────────────────
TOTAL=0
OK=0
MISSING=0
MISSING_LIST=()

# ── Helpers ──────────────────────────────────────────────────
scan_line() {
  local label="$1"
  printf "  ${GREY}│${R}  ${DIM}${CYAN}▸ scanning ${WHITE}%-20s${R}" "$label"
  sleep 0.03
}

# ── Banner ───────────────────────────────────────────────────
echo ""
echo "  ${MAGENTA}${BOLD}┌──────────────────────────────────────────────────────┐${R}"
echo "  ${MAGENTA}${BOLD}│${R}  ${CYAN}${BOLD}▓▓▓${R} ${WHITE}${BOLD}TOOLSCAN${R}  ${DIM}${GREY}Cyberdeck Dependency Tracker v1.0${R}"
echo "  ${MAGENTA}${BOLD}└──────────────────────────────────────────────────────┘${R}"
echo ""

# ── Boot ─────────────────────────────────────────────────────
frames=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
msgs=("Loading tool registry" "Scanning PATH" "Checking fonts")
for msg in "${msgs[@]}"; do
  for i in 0 1 2 3 4; do
    printf "\r  ${MAGENTA}${frames[$((i % ${#frames[@]}))]}${R} ${DIM}${WHITE}%s${GREY}...${R}   " "$msg"
    sleep 0.04
  done
  printf "\r  ${GREEN}✓${R} ${WHITE}%s${R}                          \n" "$msg"
done
echo ""

# ── Check Homebrew ───────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "  ${PINK}${BOLD}✗ Homebrew not found${R}"
  echo "  ${DIM}${WHITE}Install from ${CYAN}https://brew.sh${R}"
  echo ""
  exit 1
fi

# ── Scan CLI Tools ───────────────────────────────────────────
echo "  ${BLUE}${BOLD}┌─ CLI TOOLS ─────────────────────────────────────────${R}"
echo "  ${BLUE}${BOLD}│${R}  ${DIM}${WHITE}Homebrew formulae required by dotfiles${R}"
echo "  ${BLUE}${BOLD}│${R}"

for entry in "${TOOLS[@]}"; do
  cmd="${entry%%:*}"
  rest="${entry#*:}"
  pkg="${rest%%:*}"
  used_by="${rest#*:}"
  ((TOTAL++)) || true

  scan_line "$cmd"

  if command -v "$cmd" &>/dev/null; then
    version=$(command "$cmd" --version 2>/dev/null | head -1 | sed 's/.*[vV]\{0,1\}\([0-9][0-9.]*\).*/\1/' || echo "?")
    printf "${BG_GREEN} ${GREEN}${BOLD}OK${R}  ${DIM}${GREY}${version}${R}\n"
    ((OK++)) || true
  else
    printf "${BG_RED} ${PINK}${BOLD}MISSING${R}\n"
    echo "  ${BLUE}${BOLD}│${R}    ${DIM}${YELLOW}used by: ${WHITE}${used_by}${R}"
    echo "  ${BLUE}${BOLD}│${R}    ${DIM}${YELLOW}install: ${CYAN}brew install ${pkg}${R}"
    ((MISSING++)) || true
    MISSING_LIST+=("brew install ${pkg}")
  fi
done

echo "  ${BLUE}${BOLD}│${R}"
echo "  ${BLUE}${BOLD}└──────────────────────────────────────────────────────${R}"

# ── Scan Fonts ───────────────────────────────────────────────
echo ""
echo "  ${BLUE}${BOLD}┌─ FONTS ─────────────────────────────────────────────${R}"
echo "  ${BLUE}${BOLD}│${R}  ${DIM}${WHITE}Nerd Font casks required by dotfiles${R}"
echo "  ${BLUE}${BOLD}│${R}"

for entry in "${FONTS[@]}"; do
  font_file="${entry%%:*}"
  rest="${entry#*:}"
  cask="${rest%%:*}"
  used_by="${rest#*:}"
  ((TOTAL++)) || true

  scan_line "$cask"

  # Check if font is installed (look in both user and system font dirs)
  if fc-list 2>/dev/null | grep -qi "JetBrainsMono Nerd" || \
     find ~/Library/Fonts /Library/Fonts -name "*JetBrainsMono*Nerd*" -print -quit 2>/dev/null | grep -q .; then
    printf "${BG_GREEN} ${GREEN}${BOLD}OK${R}\n"
    ((OK++)) || true
  else
    printf "${BG_RED} ${PINK}${BOLD}MISSING${R}\n"
    echo "  ${BLUE}${BOLD}│${R}    ${DIM}${YELLOW}used by: ${WHITE}${used_by}${R}"
    echo "  ${BLUE}${BOLD}│${R}    ${DIM}${YELLOW}install: ${CYAN}brew install --cask ${cask}${R}"
    ((MISSING++)) || true
    MISSING_LIST+=("brew install --cask ${cask}")
  fi
done

echo "  ${BLUE}${BOLD}│${R}"
echo "  ${BLUE}${BOLD}└──────────────────────────────────────────────────────${R}"

# ── Scan Apps ────────────────────────────────────────────────
echo ""
echo "  ${BLUE}${BOLD}┌─ APPS ──────────────────────────────────────────────${R}"
echo "  ${BLUE}${BOLD}│${R}  ${DIM}${WHITE}GUI applications required by dotfiles${R}"
echo "  ${BLUE}${BOLD}│${R}"

for entry in "${APPS[@]}"; do
  cmd="${entry%%:*}"
  rest="${entry#*:}"
  cask="${rest%%:*}"
  used_by="${rest#*:}"
  ((TOTAL++)) || true

  scan_line "$cmd"

  if command -v "$cmd" &>/dev/null || [[ -d "/Applications/Ghostty.app" ]]; then
    printf "${BG_GREEN} ${GREEN}${BOLD}OK${R}\n"
    ((OK++)) || true
  else
    printf "${BG_YELLOW} ${YELLOW}${BOLD}NOT FOUND${R}\n"
    echo "  ${BLUE}${BOLD}│${R}    ${DIM}${YELLOW}used by: ${WHITE}${used_by}${R}"
    echo "  ${BLUE}${BOLD}│${R}    ${DIM}${YELLOW}install: ${CYAN}brew install --cask ${cask}${R}"
    ((MISSING++)) || true
    MISSING_LIST+=("brew install --cask ${cask}")
  fi
done

echo "  ${BLUE}${BOLD}│${R}"
echo "  ${BLUE}${BOLD}└──────────────────────────────────────────────────────${R}"

# ── Results ──────────────────────────────────────────────────
echo ""

if [[ $MISSING -eq 0 ]]; then
  echo "  ${GREEN}${BOLD}┌─ ALL SYSTEMS NOMINAL ───────────────────────────────${R}"
  echo "  ${GREEN}${BOLD}│${R}"
  echo "  ${GREEN}${BOLD}│${R}  ${GREEN}◆${R} ${WHITE}${BOLD}${OK}${R}${WHITE}/${TOTAL} dependencies verified${R}  ${DIM}${GREEN}// fully operational${R}"
  echo "  ${GREEN}${BOLD}│${R}"
  echo "  ${GREEN}${BOLD}└──────────────────────────────────────────────────────${R}"
else
  echo "  ${YELLOW}${BOLD}┌─ SCAN COMPLETE ─────────────────────────────────────${R}"
  echo "  ${YELLOW}${BOLD}│${R}"
  echo "  ${YELLOW}${BOLD}│${R}  ${GREEN}◆${R} ${GREEN}${BOLD}${OK}${R} ${WHITE}installed${R}"
  echo "  ${YELLOW}${BOLD}│${R}  ${PINK}◆${R} ${PINK}${BOLD}${MISSING}${R} ${WHITE}missing${R}"
  echo "  ${YELLOW}${BOLD}│${R}"
  echo "  ${YELLOW}${BOLD}├─ INSTALL ALL MISSING ───────────────────────────────${R}"
  echo "  ${YELLOW}${BOLD}│${R}"

  for install_cmd in "${MISSING_LIST[@]}"; do
    echo "  ${YELLOW}${BOLD}│${R}  ${CYAN}${install_cmd}${R}"
  done

  echo "  ${YELLOW}${BOLD}│${R}"
  echo "  ${YELLOW}${BOLD}└──────────────────────────────────────────────────────${R}"

  # Offer to install
  echo ""
  printf "  ${WHITE}${BOLD}Install all missing tools? ${DIM}[y/N]${R} "
  read -r answer
  if [[ "$answer" =~ ^[Yy]$ ]]; then
    echo ""
    for install_cmd in "${MISSING_LIST[@]}"; do
      echo "  ${MAGENTA}▸${R} ${WHITE}${install_cmd}${R}"
      eval "$install_cmd"
      echo "  ${GREEN}✓${R} ${WHITE}done${R}"
      echo ""
    done
    echo "  ${GREEN}${BOLD}All tools installed.${R} Run ${CYAN}./tools.sh${R} again to verify."
  fi
fi

echo ""
