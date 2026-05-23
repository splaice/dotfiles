# Dotfiles

Personal dotfiles for macOS (Apple Silicon). Managed with symlinks from `~/Code/dotfiles` to `$HOME`.

## Owner

Sean Plaice (`splaice`)

## Design Principles

- **Switchable themes** — Tokyo Night, Ember, Catppuccin, Gruvbox. Switch any time with `theme <name>`.
- **Truecolor** (24-bit) throughout — all configs use `#rrggbb` or `38;2;r;g;b` escapes
- **JetBrainsMono Nerd Font** — supports ligatures and icon glyphs
- **Cyberpunk aesthetic** — MOTD and scripts use box-drawing, neon colors, animated spinners
- **Modern CLI replacements** — eza, fd, delta, zoxide, fzf
- Keep configs simple and minimal; avoid over-engineering

## Theme System

Themes live under `.config/themes/<name>/`. Each contains theme-specific files for the apps that participate:

| File | Used by |
|---|---|
| `ghostty.conf` | included from `.config/ghostty/config` via `config-file = ../themes/current/ghostty.conf` |
| `tmux.conf` | sourced from `.config/tmux/tmux.conf` via `source-file ~/.config/themes/current/tmux.conf` |
| `starship.toml` | `STARSHIP_CONFIG` env var set from `~/.config/themes/current/starship.toml` |
| `fzf` | sourced by `.bashrc` to set `FZF_DEFAULT_OPTS` |
| `neovim` | one-line file with colorscheme name; read by `lua/plugins/colorscheme.lua` |

The active theme is the symlink `~/.config/themes/current → <name>/` (per-host state, not in repo). `link.sh` sets a default of `tokyo-night` on first run.

Switching:

```sh
theme              # show active
theme list         # show available
theme ember        # activate ember
```

After switching, ghostty and tmux reload immediately; re-source the shell (or open a new one) to pick up starship/fzf colors; nvim re-reads the colorscheme on next launch.

## Symlink Map

These are the managed dotfiles and where they link to. The `link.sh` script verifies and repairs all of them.

| Repo path | Symlink target |
|---|---|
| `.bashrc` | `~/.bashrc` |
| `.bash_profile` | `~/.bash_profile` |
| `.gitconfig` | `~/.gitconfig` |
| `.ssh/config` | `~/.ssh/config` |
| `.config/ghostty/config` | `~/.config/ghostty/config` |
| `.config/tmux/tmux.conf` | `~/.config/tmux/tmux.conf` |
| `.config/themes/<name>` (each) | `~/.config/themes/<name>` |
| `.config/nvim/init.lua` | `~/.config/nvim/init.lua` |
| `.config/nvim/lua/config/*.lua` (each) | `~/.config/nvim/lua/config/*.lua` |
| `.config/nvim/lua/plugins/colorscheme.lua` | `~/.config/nvim/lua/plugins/colorscheme.lua` |
| `.config/nvim/colors/ember.vim` | `~/.config/nvim/colors/ember.vim` |
| `.config/ranger/scope.sh` | `~/.config/ranger/scope.sh` |
| `.config/ranger/rifle.conf` | `~/.config/ranger/rifle.conf` |
| `.local/bin/git-backup.sh` | `~/.local/bin/git-backup.sh` |
| `.local/bin/tar-backup.sh` | `~/.local/bin/tar-backup.sh` |
| `launch-agent/com.splaice.backup-agents.plist` | `~/Library/LaunchAgents/com.splaice.backup-agents.plist` |
| `launch-agent/com.splaice.backup-code.plist` | `~/Library/LaunchAgents/com.splaice.backup-code.plist` |

When adding a new dotfile to the repo, also add it to the `LINKS` array in `link.sh`. When adding a new tool dependency, add it to the `TOOLS`, `FONTS`, or `APPS` array in `tools.sh`.

**Important:** Never copy files directly between `~/.config/` and the repo. All config files live in the repo and are symlinked to their target locations by `link.sh`. To add a new config: create it in the repo, add a `LINKS` entry, and run `./link.sh`.

## Key Files

- **`.bashrc`** — shell config; aliases, tool init (starship, zoxide, fzf), sources `~/.config/themes/current/{starship.toml,fzf}`, cyberpunk MOTD
- **`.bash_profile`** — login-shell entrypoint; sources `.bashrc`
- **`.config/nvim/init.lua`** — LazyVim entry point; bootstraps `lazy.nvim` via `lua/config/lazy.lua`
- **`.config/nvim/lua/config/{lazy,options,keymaps}.lua`** — LazyVim bootstrap, option overrides, custom keymaps (delete-without-clipboard)
- **`.config/nvim/lua/plugins/colorscheme.lua`** — resolves active colorscheme: SSH → `ember`, else read from `~/.config/themes/current/neovim`, else `tokyonight`
- **`.config/nvim/colors/ember.vim`** — red/orange colorscheme for SSH sessions
- **`.gitconfig`** — delta as pager (side-by-side), nvim as editor, pull rebase, auto stash
- **`.config/ghostty/config`** — terminal: includes active theme palette, JetBrainsMono Nerd Font, bar cursor
- **`.config/tmux/tmux.conf`** — tmux base config; sources active theme colors
- **`.config/themes/`** — theme bundles (see Theme System above)
- **`bin/theme`** — switcher command
- **`bin/tclaude`** — tmux workspace launcher (Claude / nvim / shell panes)
- **`.config/ranger/scope.sh`** — preview script for ranger
- **`.config/ranger/rifle.conf`** — file opener config; uses `$EDITOR` for text/markdown
- **`link.sh`** — symlink integrity scanner/repairer with cyberpunk UI (run `./link.sh` to verify all links)
- **`tools.sh`** — dependency tracker that verifies all required CLI tools, fonts, and apps are installed (run `./tools.sh` to check; offers to install missing via Homebrew)

## Nvim Plugins (LazyVim, managed by lazy.nvim)

LazyVim bootstraps itself on first `nvim` run — clones `lazy.nvim` to `~/.local/share/nvim/lazy/` and installs the LazyVim plugin set. The lockfile lives at `~/.config/nvim/lazy-lock.json` (untracked; commit if you want reproducibility).

Custom additions on top of LazyVim defaults:
- `tokyonight.nvim` (default), `catppuccin/nvim`, `gruvbox.nvim` (lazy-loaded), plus the local `ember` colorscheme

## Setup on a Fresh Machine

```sh
git clone git@github.com:splaice/dotfiles.git ~/Code/dotfiles
cd ~/Code/dotfiles
./tools.sh         # checks & installs required tools
./link.sh          # creates all symlinks; sets default theme to tokyo-night
nvim               # first run: bootstraps lazy.nvim + installs LazyVim plugins
```

## Conventions

- Commit messages: short imperative subject, optional body explaining why
- Shell aliases go in the Aliases section of `.bashrc`
- MOTD updates should maintain the cyberpunk box-drawing style with truecolor palette
- Never commit secrets — `.env` is sourced but not tracked
