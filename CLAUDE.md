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
| `.config/ghostty/config` | `~/.config/ghostty/config` |
| `.config/bat/config` | `~/.config/bat/config` |

When adding a new dotfile to the repo, also add it to the `LINKS` array in `link.sh`.

## Key Files

- **`.zshrc`** — shell config with aliases, tool init (starship, zoxide, fzf, atuin, direnv), and cyberpunk MOTD cheatsheet
- **`.vimrc`** — Vim 9.1 config using vim-plug. Tokyo Night theme, lightline, fzf.vim, tpope essentials (commentary, surround, sleuth, fugitive, repeat), gitgutter, editorconfig. All default keybindings preserved — user is an experienced vi user
- **`.gitconfig`** — delta as pager (side-by-side), vim as editor, pull rebase, auto stash
- **`.config/starship.toml`** — prompt with git branch/status, language versions, Tokyo Night colors, Nerd Font icons
- **`.config/ghostty/config`** — terminal: Tokyo Night palette, JetBrainsMono Nerd Font, bar cursor
- **`.config/bat/config`** — syntax highlighting with tokyonight_night theme
- **`link.sh`** — symlink integrity scanner/repairer with cyberpunk UI (run `./link.sh` to verify all links)

## Vim Plugins (managed by vim-plug)

Plugins live in `~/.vim/plugged/` (not tracked in this repo). Run `:PlugInstall` after a fresh clone.

- tokyonight-vim, lightline.vim
- vim-commentary, vim-surround, vim-sleuth, vim-fugitive, vim-repeat
- vim-gitgutter, fzf.vim, editorconfig-vim

## Setup on a Fresh Machine

```sh
git clone git@github.com:splaice/dotfiles.git ~/Code/dotfiles
cd ~/Code/dotfiles
./link.sh          # creates all symlinks
vim +PlugInstall   # installs vim plugins
```

## Conventions

- Commit messages: short imperative subject, optional body explaining why
- Shell aliases go in the Aliases section of `.zshrc`
- MOTD updates should maintain the cyberpunk box-drawing style with truecolor Tokyo Night palette
- Never commit secrets — `.env` is sourced but not tracked
