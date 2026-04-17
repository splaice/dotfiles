# Dotfiles

Personal dotfiles for macOS (Apple Silicon). Managed with symlinks from `~/Code/dotfiles` to `$HOME`.

## Owner

Sean Plaice (`splaice`)

## Design Principles

- **Tokyo Night** color theme everywhere — terminal, prompt, fzf, bat, delta, vim, git
- **Truecolor** (24-bit) throughout — all configs use `#rrggbb` or `38;2;r;g;b` escapes
- **JetBrainsMono Nerd Font** — supports ligatures and icon glyphs
- **Cyberpunk aesthetic** — MOTD and scripts use box-drawing, neon colors, animated spinners
- **Modern CLI replacements** — eza, bat, ripgrep, fd, delta, zoxide, fzf, atuin, lazygit
- Keep configs simple and minimal; avoid over-engineering

## Symlink Map

These are the managed dotfiles and where they link to. The `link.sh` script verifies and repairs all of them.

| Repo path | Symlink target |
|---|---|
| `.zshrc` | `~/.zshrc` |
| `.vimrc` | `~/.vimrc` |
| `.gitconfig` | `~/.gitconfig` |
| `.ssh/config` | `~/.ssh/config` |
| `.config/starship.toml` | `~/.config/starship.toml` |
| `.config/starship-ember.toml` | `~/.config/starship-ember.toml` |
| `.config/ghostty/config` | `~/.config/ghostty/config` |
| `.config/bat/config` | `~/.config/bat/config` |
| `.config/tmux/tmux.conf` | `~/.config/tmux/tmux.conf` |
| `.config/tmux/tmux-ember.conf` | `~/.config/tmux/tmux-ember.conf` |
| `.vim/colors/ember.vim` | `~/.vim/colors/ember.vim` |
| `.config/ranger/scope.sh` | `~/.config/ranger/scope.sh` |
| `.config/ranger/rifle.conf` | `~/.config/ranger/rifle.conf` |
| `.local/bin/git-backup.sh` | `~/.local/bin/git-backup.sh` |
| `.local/bin/tar-backup.sh` | `~/.local/bin/tar-backup.sh` |
| `launch-agent/com.splaice.backup-agents.plist` | `~/Library/LaunchAgents/com.splaice.backup-agents.plist` |
| `launch-agent/com.splaice.backup-code.plist` | `~/Library/LaunchAgents/com.splaice.backup-code.plist` |

When adding a new dotfile to the repo, also add it to the `LINKS` array in `link.sh`. When adding a new tool dependency, add it to the `TOOLS`, `FONTS`, or `APPS` array in `tools.sh`.

**Important:** Never copy files directly between `~/.config/` and the repo. All config files live in the repo and are symlinked to their target locations by `link.sh`. To add a new config: create it in the repo, add a `LINKS` entry, and run `./link.sh`.

## Key Files

- **`.zshrc`** — shell config with aliases, tool init (starship, zoxide, fzf, atuin, direnv), and cyberpunk MOTD cheatsheet
- **`.vimrc`** — Vim 9.1 config using vim-plug. Tokyo Night theme, lightline, fzf.vim, tpope essentials (commentary, surround, sleuth, fugitive, repeat), gitgutter, editorconfig. All default keybindings preserved — user is an experienced vi user
- **`.gitconfig`** — delta as pager (side-by-side), vim as editor, pull rebase, auto stash
- **`.config/starship.toml`** — prompt with git branch/status, language versions, Tokyo Night colors, Nerd Font icons
- **`.config/starship-ember.toml`** — ember variant of starship prompt, auto-loaded via `STARSHIP_CONFIG` when `$SSH_CONNECTION` is set
- **`.config/ghostty/config`** — terminal: Tokyo Night palette, JetBrainsMono Nerd Font, bar cursor
- **`.config/tmux/tmux-ember.conf`** — red/orange tmux theme, auto-loaded via `tmux()` wrapper when in an SSH session (`$SSH_CONNECTION` set)
- **`.vim/colors/ember.vim`** — red/orange vim colorscheme, auto-loaded by `.vimrc` when `$SSH_CONNECTION` is set
- **`.config/bat/config`** — syntax highlighting with tokyonight_night theme
- **`.config/ranger/scope.sh`** — preview script; uses glow for markdown rendering
- **`.config/ranger/rifle.conf`** — file opener config; glow as default for markdown, vim as fallback
- **`link.sh`** — symlink integrity scanner/repairer with cyberpunk UI (run `./link.sh` to verify all links)
- **`tools.sh`** — dependency tracker that verifies all required CLI tools, fonts, and apps are installed (run `./tools.sh` to check; offers to install missing via Homebrew)

## Vim Plugins (managed by vim-plug)

Plugins live in `~/.vim/plugged/` (not tracked in this repo). Run `:PlugInstall` after a fresh clone.

- tokyonight-vim, lightline.vim
- vim-commentary, vim-surround, vim-sleuth, vim-fugitive, vim-repeat
- vim-gitgutter, fzf.vim, editorconfig-vim

## Setup on a Fresh Machine

```sh
git clone git@github.com:splaice/dotfiles.git ~/Code/dotfiles
cd ~/Code/dotfiles
./tools.sh         # checks & installs required tools
./link.sh          # creates all symlinks
vim +PlugInstall   # installs vim plugins
```

## Conventions

- Commit messages: short imperative subject, optional body explaining why
- Shell aliases go in the Aliases section of `.zshrc`
- MOTD updates should maintain the cyberpunk box-drawing style with truecolor Tokyo Night palette
- Never commit secrets — `.env` is sourced but not tracked
