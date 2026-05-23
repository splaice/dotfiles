# macOS terminals open login shells, which read .bash_profile (not .bashrc).
# Source .bashrc so interactive and login shells share the same config.
[[ -f ~/.bashrc ]] && source ~/.bashrc
