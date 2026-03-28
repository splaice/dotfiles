#!/usr/bin/env bash
# ╔═══════════════════════════════════════════════════════════╗
# ║  DOTLINK v1.0 — Neural Symlink Integrity Scanner         ║
# ║  Cyberdeck Dotfile Management System                      ║
# ╚═══════════════════════════════════════════════════════════╝
set -euo pipefail

DOTFILES="$HOME/Code/dotfiles"

# ── Colors ───────────────────────────────────────────────────
R=$'\e[0m'         # reset
DIM=$'\e[2m'
BOLD=$'\e[1m'
BLINK=$'\e[5m'

# Neon palette
CYAN=$'\e[38;2;125;207;255m'
MAGENTA=$'\e[38;2;187;154;247m'
PINK=$'\e[38;2;247;118;142m'
YELLOW=$'\e[38;2;224;175;104m'
GREEN=$'\e[38;2;158;206;106m'
BLUE=$'\e[38;2;122;162;247m'
GREY=$'\e[38;2;65;72;104m'
WHITE=$'\e[38;2;192;202;245m'

BG_RED=$'\e[48;2;60;20;30m'
BG_GREEN=$'\e[48;2;20;50;30m'
BG_CYAN=$'\e[48;2;15;30;50m'

# ── Symlink Registry ────────────────────────────────────────
# Format: "source:target"
LINKS=(
  ".zshrc:$HOME/.zshrc"
  ".vimrc:$HOME/.vimrc"
  ".gitconfig:$HOME/.gitconfig"
  ".ssh/config:$HOME/.ssh/config"
  ".ssh/config.d/private:$HOME/.ssh/config.d/private"
  ".config/starship.toml:$HOME/.config/starship.toml"
  ".config/ghostty/config:$HOME/.config/ghostty/config"
  ".config/bat/config:$HOME/.config/bat/config"
  ".config/tmux/tmux.conf:$HOME/.config/tmux/tmux.conf"
  ".config/tmux/tmux-ember.conf:$HOME/.config/tmux/tmux-ember.conf"
  ".vim/colors/ember.vim:$HOME/.vim/colors/ember.vim"
  ".config/ranger/scope.sh:$HOME/.config/ranger/scope.sh"
  ".config/ranger/rifle.conf:$HOME/.config/ranger/rifle.conf"
)

# ── Counters ────────────────────────────────────────────────
TOTAL=${#LINKS[@]}
OK=0
REPAIRED=0
FAILED=0

# ── Helpers ─────────────────────────────────────────────────
glyph_ok="${GREEN}◆${R}"
glyph_fix="${YELLOW}◆${R}"
glyph_fail="${PINK}◆${R}"
glyph_dot="${GREY}·${R}"

bar() {
  printf "  ${GREY}│${R}\n"
}

scan_line() {
  local label="$1"
  printf "  ${GREY}│${R}  ${DIM}${CYAN}▸ scanning ${WHITE}%-40s${R}" "$label"
  sleep 0.04
}

# ── Banner ──────────────────────────────────────────────────
clear_banner() {
  echo ""
  echo "  ${MAGENTA}${BOLD}┌─────────────────────────────────────────────────────┐${R}"
  echo "  ${MAGENTA}${BOLD}│${R}  ${CYAN}${BOLD}██████╗  ██████╗ ████████╗██╗     ██╗███╗   ██╗██╗ ██╗${R}"
  echo "  ${MAGENTA}${BOLD}│${R}  ${CYAN}██╔══██╗██╔═══██╗╚══██╔══╝██║     ██║████╗  ██║██║ ██║${R}"
  echo "  ${MAGENTA}${BOLD}│${R}  ${CYAN}██║  ██║██║   ██║   ██║   ██║     ██║██╔██╗ ██║█████╔╝${R}"
  echo "  ${MAGENTA}${BOLD}│${R}  ${CYAN}██║  ██║██║   ██║   ██║   ██║     ██║██║╚██╗██║██╔═██╗${R}"
  echo "  ${MAGENTA}${BOLD}│${R}  ${CYAN}${BOLD}██████╔╝╚██████╔╝   ██║   ███████╗██║██║ ╚████║██║  ██╗${R}"
  echo "  ${MAGENTA}${BOLD}│${R}  ${CYAN}╚═════╝  ╚═════╝    ╚═╝   ╚══════╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝${R}"
  echo "  ${MAGENTA}${BOLD}│${R}"
  echo "  ${MAGENTA}${BOLD}│${R}  ${DIM}${MAGENTA}Neural Symlink Integrity Scanner v1.0${R}"
  echo "  ${MAGENTA}${BOLD}│${R}  ${DIM}${GREY}Cyberdeck Dotfile Management System${R}"
  echo "  ${MAGENTA}${BOLD}└─────────────────────────────────────────────────────┘${R}"
  echo ""
}

# ── Boot Sequence ───────────────────────────────────────────
boot_sequence() {
  local frames=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
  local msgs=(
    "Initializing neural interface"
    "Loading symlink registry"
    "Scanning filesystem nodes"
  )
  for msg in "${msgs[@]}"; do
    for i in 0 1 2 3 4; do
      printf "\r  ${MAGENTA}${frames[$((i % ${#frames[@]}))]}${R} ${DIM}${WHITE}%s${GREY}...${R}   " "$msg"
      sleep 0.05
    done
    printf "\r  ${GREEN}✓${R} ${WHITE}%s${R}                          \n" "$msg"
  done
  echo ""
}

# ── Main Scan ───────────────────────────────────────────────
run_scan() {
  echo "  ${BLUE}${BOLD}┌─ SYMLINK INTEGRITY SCAN ────────────────────────────${R}"
  echo "  ${BLUE}${BOLD}│${R}  ${DIM}${WHITE}Registry: ${CYAN}${TOTAL} nodes${R}  ${DIM}${WHITE}Source: ${CYAN}~/Code/dotfiles${R}"
  echo "  ${BLUE}${BOLD}│${R}"

  for entry in "${LINKS[@]}"; do
    local src="${entry%%:*}"
    local tgt="${entry##*:}"
    local src_full="$DOTFILES/$src"
    local display_tgt="${tgt/#$HOME/~}"

    scan_line "${display_tgt}"

    # Check if source exists in repo
    if [[ ! -e "$src_full" ]]; then
      printf "${BG_RED} ${PINK}${BOLD}MISSING SOURCE${R} \n"
      echo "  ${BLUE}${BOLD}│${R}    ${DIM}${PINK}repo file not found: $src${R}"
      ((FAILED++)) || true
      continue
    fi

    # Check if target is already a correct symlink
    if [[ -L "$tgt" ]]; then
      local current
      current="$(readlink "$tgt")"
      if [[ "$current" == "$src_full" ]]; then
        printf "${BG_GREEN} ${GREEN}${BOLD}LINKED${R} \n"
        ((OK++)) || true
        continue
      else
        printf "${BG_RED} ${YELLOW}${BOLD}WRONG TARGET${R} \n"
        echo "  ${BLUE}${BOLD}│${R}    ${DIM}${YELLOW}points to: $current${R}"
        echo "  ${BLUE}${BOLD}│${R}    ${DIM}${YELLOW}repairing → ${WHITE}$src_full${R}"
        rm "$tgt"
        ln -sf "$src_full" "$tgt"
        printf "  ${BLUE}${BOLD}│${R}    ${GREEN}✓ repaired${R}\n"
        ((REPAIRED++)) || true
        continue
      fi
    fi

    # Target exists but is a regular file (not a symlink)
    if [[ -e "$tgt" ]]; then
      printf "${BG_RED} ${YELLOW}${BOLD}NOT A SYMLINK${R} \n"
      local backup="${tgt}.bak.$(date +%s)"
      echo "  ${BLUE}${BOLD}│${R}    ${DIM}${YELLOW}backing up → ${WHITE}${backup/#$HOME/~}${R}"
      mv "$tgt" "$backup"
      ln -sf "$src_full" "$tgt"
      printf "  ${BLUE}${BOLD}│${R}    ${GREEN}✓ backed up & linked${R}\n"
      ((REPAIRED++)) || true
      continue
    fi

    # Target doesn't exist at all — create parent dir and link
    printf "${BG_RED} ${PINK}${BOLD}MISSING${R} \n"
    local tgt_dir
    tgt_dir="$(dirname "$tgt")"
    if [[ ! -d "$tgt_dir" ]]; then
      echo "  ${BLUE}${BOLD}│${R}    ${DIM}${YELLOW}creating dir: ${WHITE}${tgt_dir/#$HOME/~}${R}"
      mkdir -p "$tgt_dir"
    fi
    ln -sf "$src_full" "$tgt"
    printf "  ${BLUE}${BOLD}│${R}    ${GREEN}✓ linked${R}\n"
    ((REPAIRED++)) || true
  done

  echo "  ${BLUE}${BOLD}│${R}"
  echo "  ${BLUE}${BOLD}└──────────────────────────────────────────────────────${R}"
}

# ── Results ─────────────────────────────────────────────────
print_results() {
  echo ""

  if [[ $FAILED -eq 0 && $REPAIRED -eq 0 ]]; then
    echo "  ${GREEN}${BOLD}┌─ ALL SYSTEMS NOMINAL ───────────────────────────────${R}"
    echo "  ${GREEN}${BOLD}│${R}"
    echo "  ${GREEN}${BOLD}│${R}  ${glyph_ok} ${WHITE}${BOLD}${OK}${R}${WHITE}/${TOTAL} symlinks verified${R}  ${DIM}${GREEN}// no action required${R}"
    echo "  ${GREEN}${BOLD}│${R}"
    echo "  ${GREEN}${BOLD}└──────────────────────────────────────────────────────${R}"
  else
    echo "  ${YELLOW}${BOLD}┌─ SCAN COMPLETE ─────────────────────────────────────${R}"
    echo "  ${YELLOW}${BOLD}│${R}"
    [[ $OK -gt 0 ]]       && echo "  ${YELLOW}${BOLD}│${R}  ${glyph_ok} ${GREEN}${BOLD}${OK}${R} ${WHITE}intact${R}" || true
    [[ $REPAIRED -gt 0 ]] && echo "  ${YELLOW}${BOLD}│${R}  ${glyph_fix} ${YELLOW}${BOLD}${REPAIRED}${R} ${WHITE}repaired${R}" || true
    [[ $FAILED -gt 0 ]]   && echo "  ${YELLOW}${BOLD}│${R}  ${glyph_fail} ${PINK}${BOLD}${FAILED}${R} ${WHITE}failed${R}" || true
    echo "  ${YELLOW}${BOLD}│${R}"
    echo "  ${YELLOW}${BOLD}└──────────────────────────────────────────────────────${R}"
  fi

  echo ""
}

# ── Run ─────────────────────────────────────────────────────
clear_banner
boot_sequence
run_scan
print_results
