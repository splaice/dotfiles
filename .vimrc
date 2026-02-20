" ── Modern Vim Config ─────────────────────────────────────
" Clean setup for Vim 9.1 — default keybindings preserved

" ── Plugins (vim-plug) ───────────────────────────────────
call plug#begin('~/.vim/plugged')

" Theme
Plug 'ghifarit53/tokyonight-vim'

" Status line
Plug 'itchyny/lightline.vim'

" Tpope essentials
Plug 'tpope/vim-commentary'         " gc to comment
Plug 'tpope/vim-surround'           " cs/ds/ys for surroundings
Plug 'tpope/vim-sleuth'             " auto-detect indent settings
Plug 'tpope/vim-fugitive'           " :Git commands
Plug 'tpope/vim-repeat'             " . repeats plugin actions

" Git gutter signs
Plug 'airblade/vim-gitgutter'

" Fuzzy finder (uses installed fzf)
Plug '/opt/homebrew/opt/fzf'
Plug 'junegunn/fzf.vim'

" EditorConfig support
Plug 'editorconfig/editorconfig-vim'

call plug#end()

" ── General ──────────────────────────────────────────────
set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set hidden                           " allow unsaved buffers in background
set autoread                         " reload files changed outside vim
set backspace=indent,eol,start
set mouse=a                          " mouse in all modes
set clipboard=unnamed                " use system clipboard
set updatetime=250                   " faster gitgutter + CursorHold
set ttimeoutlen=10                   " snappy mode switching
set signcolumn=yes                   " always show sign column

" ── Display ──────────────────────────────────────────────
set number                           " line numbers
set relativenumber                   " relative numbers (hybrid with number)
set cursorline                       " highlight current line
set scrolloff=8                      " keep 8 lines above/below cursor
set sidescrolloff=8
set showmatch                        " flash matching brackets
set showcmd                          " show partial command in status
set laststatus=2                     " always show status line
set noshowmode                       " lightline handles this
set linebreak                        " wrap at word boundaries
set list                             " show invisible characters
set listchars=tab:▸\ ,trail:·,extends:›,precedes:‹

" ── Search ───────────────────────────────────────────────
set incsearch                        " incremental search
set hlsearch                         " highlight matches
set ignorecase                       " case insensitive...
set smartcase                        " ...unless capitals used

" ── Indentation (vim-sleuth auto-detects per file) ──────
set expandtab                        " spaces by default
set shiftwidth=2                     " indent width
set tabstop=2                        " tab display width
set softtabstop=2
set shiftround                       " round indent to shiftwidth
set autoindent
set smartindent

" ── Splits ───────────────────────────────────────────────
set splitbelow                       " new horizontal splits below
set splitright                       " new vertical splits right

" ── Completion ───────────────────────────────────────────
set wildmenu                         " enhanced command-line completion
set wildmode=longest:full,full
set completeopt=menuone,noselect

" ── Undo & Swap ──────────────────────────────────────────
set undofile                         " persistent undo
set undodir=~/.vim/undo
set noswapfile                       " no .swp clutter
set nobackup
set nowritebackup

" Create undo directory if it doesn't exist
if !isdirectory(expand('~/.vim/undo'))
  call mkdir(expand('~/.vim/undo'), 'p')
endif

" ── Theme ────────────────────────────────────────────────
set termguicolors
let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1
silent! colorscheme tokyonight

" ── Lightline ────────────────────────────────────────────
let g:lightline = {
      \ 'colorscheme': 'tokyonight',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['gitbranch', 'readonly', 'filename', 'modified'] ],
      \   'right': [ ['lineinfo'],
      \              ['percent'],
      \              ['filetype'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" ── GitGutter ────────────────────────────────────────────
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▁'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▎'

" ── fzf ──────────────────────────────────────────────────
" Layout matches shell fzf config
let g:fzf_layout = { 'down': '40%' }

" Use fd for file listing (respects .gitignore)
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'

" ── Netrw (built-in file browser) ────────────────────────
let g:netrw_banner = 0               " hide banner
let g:netrw_liststyle = 3            " tree view
let g:netrw_winsize = 25             " 25% width

" ── Filetype ─────────────────────────────────────────────
filetype plugin indent on
syntax enable
