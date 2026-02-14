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
alias ls='eza --icons'
alias ll='eza -la --icons --git'
alias lt='eza --tree --icons --level=2'
alias cat='bat'
alias grep='rg'
alias find='fd'
alias lg='lazygit'
alias diff='delta'

# ── MOTD — new shell cheatsheet ────────────────────────
() {
  local dim=$'\e[2m' cyan=$'\e[36m' yellow=$'\e[33m' green=$'\e[32m' purple=$'\e[35m' reset=$'\e[0m'
  print ""
  print "  ${cyan}Modern Shell Cheatsheet${reset}"
  print "  ${dim}──────────────────────────────────────${reset}"
  print "  ${yellow}ls${reset}     eza --icons          ${dim}(was ls)${reset}"
  print "  ${yellow}ll${reset}     eza -la --icons --git ${dim}(was ls -la)${reset}"
  print "  ${yellow}lt${reset}     eza --tree --level=2  ${dim}(was tree)${reset}"
  print "  ${yellow}cat${reset}    bat (syntax highlight) ${dim}(was cat)${reset}"
  print "  ${yellow}grep${reset}   ripgrep              ${dim}(was grep)${reset}"
  print "  ${yellow}find${reset}   fd                   ${dim}(was find)${reset}"
  print "  ${yellow}diff${reset}   delta (side-by-side) ${dim}(was diff)${reset}"
  print "  ${dim}──────────────────────────────────────${reset}"
  print "  ${green}z${reset}      zoxide (smart cd)     ${dim}Ctrl+R${reset} atuin history"
  print "  ${green}lg${reset}     lazygit               ${dim}Ctrl+T${reset} fzf file picker"
  print "  ${purple}tldr${reset}   simplified man pages"
  print ""
}
