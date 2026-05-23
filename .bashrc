# ── PATH ──────────────────────────────────────────────
export PATH=/opt/homebrew/share/google-cloud-sdk/bin:"$PATH"
export PATH="/opt/homebrew/bin/go:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Code/dotfiles/bin:$PATH"

# ── Secrets ──────────────────────────────────────────────
[[ -f ~/.env ]] && source ~/.env

# ── Theme (starship, fzf, eza colors) ───────────────────
# Active theme is the symlink ~/.config/themes/current. Switch with `theme <name>`.
[[ -f ~/.config/themes/current/starship.toml ]] && export STARSHIP_CONFIG=~/.config/themes/current/starship.toml
[[ -f ~/.config/themes/current/fzf ]] && source ~/.config/themes/current/fzf
[[ -f ~/.config/themes/current/eza ]] && source ~/.config/themes/current/eza

# ── Starship prompt ─────────────────────────────────────
eval "$(starship init bash)"

# ── Zoxide (smart cd) ──────────────────────────────────
eval "$(zoxide init bash)"

# ── fzf ─────────────────────────────────────────────────
eval "$(fzf --bash)"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
# FZF_DEFAULT_OPTS comes from ~/.config/themes/current/fzf (sourced above).
export FZF_CTRL_T_OPTS="--preview 'cat {}' --preview-window=right:60%"

# ── Editor ──────────────────────────────────────────────
export EDITOR=nvim
export VISUAL=nvim
alias vim='nvim'
alias vi='nvim'

# ── Aliases ─────────────────────────────────────────────
alias ls='eza --time-style=long-iso'
alias ll='eza -la --git --time-style=long-iso'
alias lt='eza --tree --level=2'
alias lls='eza -la --sort=modified -r --time-style=long-iso'
alias diff='delta'
alias o='open'
alias tclaude='~/Code/dotfiles/bin/tclaude'
alias a='cd ~/Agents'
alias c='cd ~/Code'
alias d='cd ~/Data'
alias claud='claude && reset'
alias m='cd ~/Maniple'
alias mosh='mosh --server=/opt/homebrew/bin/mosh-server'

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

# reset term if busted
printf '\e[>0u' 2>/dev/null

# Added by tally installer
export PATH="$HOME/.tally/bin:$PATH"
