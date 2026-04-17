# ── PATH ──────────────────────────────────────────────
export PATH=/opt/homebrew/share/google-cloud-sdk/bin:"$PATH"
export PATH="/opt/homebrew/bin/go:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# ── Secrets ──────────────────────────────────────────────
[[ -f ~/.env ]] && source ~/.env

# ── Starship prompt ─────────────────────────────────────
[[ -n "$SSH_CONNECTION" ]] && export STARSHIP_CONFIG=~/.config/starship-ember.toml
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
#alias cat='bat'
#alias grep='rg'
alias lg='lazygit'
alias diff='delta'
alias o='open'
alias tclaude='~/Code/dotfiles/bin/tclaude'
alias a='cd ~/Agents'
alias c='cd ~/Code'
alias d='cd ~/Data'
alias o='open'
alias claud='claude && reset'
alias m='cd ~/Maniple'

# ── SSH Remote Colors ─────────────────────────────────
# Swaps to a red/orange "Ember" palette when SSH'd into a remote host,
# then restores Tokyo Night on disconnect.
_ssh_ember_theme() {
  # bg / fg / cursor
  printf '\e]11;#1c1210\e\\'
  printf '\e]10;#d8c4b0\e\\'
  printf '\e]12;#ff8c42\e\\'
  # palette 0-15
  printf '\e]4;0;#1a1410\e\\'
  printf '\e]4;1;#ff6b6b\e\\'
  printf '\e]4;2;#b8a84a\e\\'
  printf '\e]4;3;#e89048\e\\'
  printf '\e]4;4;#d47850\e\\'
  printf '\e]4;5;#c86878\e\\'
  printf '\e]4;6;#e09860\e\\'
  printf '\e]4;7;#b8a898\e\\'
  printf '\e]4;8;#4a3830\e\\'
  printf '\e]4;9;#ff8888\e\\'
  printf '\e]4;10;#d0bc5c\e\\'
  printf '\e]4;11;#f0a460\e\\'
  printf '\e]4;12;#e09068\e\\'
  printf '\e]4;13;#d87888\e\\'
  printf '\e]4;14;#f0b070\e\\'
  printf '\e]4;15;#e8d4c0\e\\'
}

_ssh_tokyonight_theme() {
  # bg / fg / cursor
  printf '\e]11;#1a1b26\e\\'
  printf '\e]10;#c0caf5\e\\'
  printf '\e]12;#c0caf5\e\\'
  # palette 0-15
  printf '\e]4;0;#15161e\e\\'
  printf '\e]4;1;#f7768e\e\\'
  printf '\e]4;2;#9ece6a\e\\'
  printf '\e]4;3;#e0af68\e\\'
  printf '\e]4;4;#7aa2f7\e\\'
  printf '\e]4;5;#bb9af7\e\\'
  printf '\e]4;6;#7dcfff\e\\'
  printf '\e]4;7;#a9b1d6\e\\'
  printf '\e]4;8;#414868\e\\'
  printf '\e]4;9;#f7768e\e\\'
  printf '\e]4;10;#9ece6a\e\\'
  printf '\e]4;11;#e0af68\e\\'
  printf '\e]4;12;#7aa2f7\e\\'
  printf '\e]4;13;#bb9af7\e\\'
  printf '\e]4;14;#7dcfff\e\\'
  printf '\e]4;15;#c0caf5\e\\'
}

_ssh_color_wrap() {
  _ssh_ember_theme
  command ssh "$@"
  _ssh_tokyonight_theme
}
alias ssh='_ssh_color_wrap'

# Auto-select ember tmux config when in an SSH session
tmux() {
  if [[ -n "$SSH_CONNECTION" && -f ~/.config/tmux/tmux-ember.conf ]]; then
    command tmux -f ~/.config/tmux/tmux-ember.conf "$@"
  else
    command tmux "$@"
  fi
}

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
