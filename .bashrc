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
source ~/.git-completion.bash

# Workaround cmux 0.64.x: bash-5.3 ${ ... ; } PS0 hook leaks "[N] Done"
# notifications for backgrounded cmux helpers (report_shell_state, ports_kick)
# past `disown`, because the funsub runs in the current shell instead of a
# subshell. Swap in the legacy $(...) subshell form (cmux's own bash<5.3
# fallback), which contains the background jobs and doesn't leak.
#
# cmux injects its integration AFTER rc files load, so PS0 is still empty here
# at source time. Run the rewrite from PROMPT_COMMAND (fires every prompt, after
# cmux has set PS0) instead of once inline. It's idempotent, so repeats are safe.
_cmux_fix_ps0_leak() {
    if [[ "$PS0" == *'${ _cmux_bash_preexec_hook'* ]]; then
        PS0="${PS0//\$\{ _cmux_bash_preexec_hook \"\$BASH_COMMAND\"\; \}/\$(_cmux_bash_preexec_hook \"\$BASH_COMMAND\" >/dev/null)}"
    fi
}
case ";${PROMPT_COMMAND};" in
    *";_cmux_fix_ps0_leak;"*) ;;
    *) PROMPT_COMMAND="_cmux_fix_ps0_leak;${PROMPT_COMMAND}" ;;
esac
