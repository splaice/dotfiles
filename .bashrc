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

[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] &&
  . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

# ── SSH Remote Colors ─────────────────────────────────
# Visual indicator that you're on a remote host. The local terminal's
# palette swaps to "ember" (red/orange) for the duration of the ssh
# session, then restores the currently-active theme on disconnect.
# Pure local OSC-escape mechanism — the remote host needs nothing.
_apply_palette() {
  local p="$HOME/.config/themes/$1/palette.sh"
  [[ -r "$p" ]] && . "$p"
}

_current_theme() {
  [[ -L "$HOME/.config/themes/current" ]] || return 1
  basename "$(readlink "$HOME/.config/themes/current")"
}

_ssh_color_wrap() {
  _apply_palette ember
  command ssh "$@"
  _apply_palette "$(_current_theme)"
}
alias ssh='_ssh_color_wrap'

# reset term if busted
printf '\e[>0u' 2>/dev/null

# Added by tally installer
export PATH="$HOME/.tally/bin:$PATH"
