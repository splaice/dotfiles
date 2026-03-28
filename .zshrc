# ── PATH ──────────────────────────────────────────────
export PATH=/opt/homebrew/share/google-cloud-sdk/bin:"$PATH"
export PATH="/opt/homebrew/bin/go:$PATH"
export PATH="$HOME/go/bin:$PATH"

# ── Secrets ──────────────────────────────────────────────
[[ -f ~/.env ]] && source ~/.env

# ── Starship prompt ─────────────────────────────────────
eval "$(starship init zsh)"

# ── Zoxide (smart cd) ──────────────────────────────────
eval "$(zoxide init zsh)"

# ── fzf ─────────────────────────────────────────────────
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='
  --color=bg+:#283457,bg:#1a1b26,spinner:#7dcfff,hl:#7aa2f7
  --color=fg:#c0caf5,header:#7aa2f7,info:#e0af68,pointer:#7dcfff
  --color=marker:#9ece6a,fg+:#c0caf5,prompt:#e0af68,hl+:#7aa2f7
  --height=40% --layout=reverse --border'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"

# ── Atuin (shell history) ──────────────────────────────
eval "$(atuin init zsh)"

# ── direnv ──────────────────────────────────────────────
eval "$(direnv hook zsh)"

# ── Aliases ─────────────────────────────────────────────
alias ls='eza --time-style=long-iso'
alias ll='eza -la --git --time-style=long-iso'
alias lt='eza --tree --level=2'
alias lls='eza -la --sort=modified -r --time-style=long-iso'
alias cat='bat'
alias grep='rg'
alias lg='lazygit'
alias diff='delta'
alias o='open'
alias tclaude='~/Code/dotfiles/bin/tclaude'
alias a='cd ~/Agents'
alias c='cd ~/Code'
alias d='cd ~/Data'
alias o='open'

# ── Hooks ─────────────────────────────────────────────
# Auto-rename cmux workspace when cd'ing into a Claude project
#function _cmux_auto_rename() {
#  if [[ -n "$CMUX_WORKSPACE_ID" ]]; then
#    cmux rename-workspace "${SHELL##*/}" 2>&1 >/dev/null
#  fi
#}
#
#if [[ -n "$CMUX_WORKSPACE_ID" ]]; then
#  autoload -Uz add-zsh-hook
#  add-zsh-hook chpwd _cmux_auto_rename
#  _cmux_auto_rename  # run once on shell start too
#fi
#

# reset term if busted
printf '\e[>0u' 2>/dev/null

# ── MOTD — Cyberdeck Shell Interface ──────────────────
() {
  local R=$'\e[0m'
  local DIM=$'\e[2m'
  local BOLD=$'\e[1m'
  local CYAN=$'\e[38;2;125;207;255m'
  local MAGENTA=$'\e[38;2;187;154;247m'
  local PINK=$'\e[38;2;247;118;142m'
  local YELLOW=$'\e[38;2;224;175;104m'
  local GREEN=$'\e[38;2;158;206;106m'
  local BLUE=$'\e[38;2;122;162;247m'
  local GREY=$'\e[38;2;65;72;104m'
  local WHITE=$'\e[38;2;192;202;245m'

  print ""
  print "  ${MAGENTA}${BOLD}┌──────────────────────────────────────────────────────┐${R}"
  print "  ${MAGENTA}${BOLD}│${R}  ${CYAN}${BOLD}▓▓▓${R} ${WHITE}${BOLD}CYBERDECK SHELL INTERFACE${R}         ${DIM}${GREY}v2.0 // online${R}"
  print "  ${MAGENTA}${BOLD}└──────────────────────────────────────────────────────┘${R}"
  print ""
  print "  ${BLUE}${BOLD}┌─ UPGRADED COMMANDS ─────────────────────────────────${R}"
  print "  ${BLUE}${BOLD}│${R}  ${YELLOW}ls${R}       ${WHITE}eza ${R}               ${DIM}${GREY}was ls${R}"
  print "  ${BLUE}${BOLD}│${R}  ${YELLOW}ll${R}       ${WHITE}eza -la --git${R}     ${DIM}${GREY}was ls -la${R}"
  print "  ${BLUE}${BOLD}│${R}  ${YELLOW}lt${R}       ${WHITE}eza --tree --level=2${R}      ${DIM}${GREY}was tree${R}"
  print "  ${BLUE}${BOLD}│${R}  ${YELLOW}cat${R}      ${WHITE}bat (syntax highlight)${R}    ${DIM}${GREY}was cat${R}"
  print "  ${BLUE}${BOLD}│${R}  ${YELLOW}grep${R}     ${WHITE}ripgrep${R}                   ${DIM}${GREY}was grep${R}"
  print "  ${BLUE}${BOLD}│${R}  ${YELLOW}find${R}     ${WHITE}fd${R}                        ${DIM}${GREY}was find${R}"
  print "  ${BLUE}${BOLD}│${R}  ${YELLOW}diff${R}     ${WHITE}delta (side-by-side)${R}      ${DIM}${GREY}was diff${R}"
  print "  ${BLUE}${BOLD}│${R}"
  print "  ${BLUE}${BOLD}├─ NAVIGATION ───────────────────────────────────────${R}"
  print "  ${BLUE}${BOLD}│${R}  ${GREEN}z${R}        ${WHITE}zoxide (smart cd)${R}          ${MAGENTA}Ctrl+R${R}  ${DIM}${WHITE}atuin history${R}"
  print "  ${BLUE}${BOLD}│${R}  ${GREEN}lg${R}       ${WHITE}lazygit${R}                    ${MAGENTA}Ctrl+T${R}  ${DIM}${WHITE}fzf file picker${R}"
  print "  ${BLUE}${BOLD}│${R}  ${GREEN}o${R}        ${WHITE}open (macOS)${R}               ${MAGENTA}tldr${R}    ${DIM}${WHITE}simplified man${R}"
  print "  ${BLUE}${BOLD}│${R}"
  print "  ${BLUE}${BOLD}├─ VIM PLUGINS ──────────────────────${DIM}${GREY} default keys ${R}${BLUE}${BOLD}─${R}"
  print "  ${BLUE}${BOLD}│${R}  ${YELLOW}gc${R}       ${WHITE}comment (visual/motion)${R}   ${DIM}${GREY}commentary${R}"
  print "  ${BLUE}${BOLD}│${R}  ${YELLOW}cs/ds/ys${R} ${WHITE}change/del/add surrounds${R}  ${DIM}${GREY}surround${R}"
  print "  ${BLUE}${BOLD}│${R}  ${GREEN}:Files${R}   ${WHITE}fzf file picker${R}            ${GREEN}:Rg${R}     ${DIM}${WHITE}fzf search${R}"
  print "  ${BLUE}${BOLD}│${R}  ${GREEN}:Git${R}     ${WHITE}fugitive git${R}               ${GREEN}:Ex${R}     ${DIM}${WHITE}file browser${R}"
  print "  ${BLUE}${BOLD}│${R}"
  print "  ${BLUE}${BOLD}└──────────────────────────────────────────────────────${R}"
  print ""
}

# Added by tally installer
export PATH="$HOME/.tally/bin:$PATH"
