"""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""
set nocompatible		" Don't act like SysV vi
set shell=/usr/local/bin/bash		" Use this shell to execute commands
filetype plugin indent on
set autoread
set clipboard=unnamed
set mat=4		" How many tenths of a second the cursor should blink for
				" matching parens
set ttyfast		" Tell vim to optimize for a fast terminal; will be on by
				" default if your $TERM is xterm or screen, but could be
				" turned off if you use a weird terminal (e.g. 'screen-bce').
				" Set 'nottyfast' for slow SSH connections.
set history=50
set pastetoggle=<F12>   " pasttoggle sane indentation when pasting
set modeline 	" Respect other people's options (when a modeline is present)
set encoding=utf-8	" Use UTF-8 (8-bit variable width Unicode)

" indenting options
set autoindent	" Keep the indent level when hitting Return
set tabstop=4	" Make tabs appear four spaces wide (default is 8 spaces)
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
" set cindent		" Don't indent Python really poorly
"set fo=tcoqan	" Options for formatting text (i.e. for use with gq)

set spell

" temporary files
set backup
set undofile  
set backupdir=$HOME/.vimbackup//
set directory=$HOME/.vimswap//
set viewdir=$HOME/.vimviews//
set undodir=$HOME/.vimundo//

" Creating directories if they don't exist
silent execute '!mkdir -p $HOME/.vimbackup'
silent execute '!mkdir -p $HOME/.vimswap'
silent execute '!mkdir -p $HOME/.vimviews'
silent execute '!mkdir -p $HOME/.vimundo'

" UI stuff
syntax enable	" Who wouldn't want syntax highlighting?
set showmatch	" Show matching parens as they come up
set ruler		" Show the column number in the status bar
set number      " Display line numbers
set incsearch	" Find as you type
set wildmenu	" Get a cool menu for tab completing file names
set wildmode=list:longest,full
set lz			" Don't redraw the screen in the middle of executing macros
set wrap		" Display files with word wrap, but don't actually insert newlines
set lbr			" Wrap only at word boundaries (default is at any character)
set showmode    " display the current mode
set cursorline  " highling current line
hi cursorline guibg=#000000
set showcmd     " 
set backspace=indent,eol,start " simple backspace
set smartcase   " case insensitve when uc present
set scrolloff=10

" This next one makes vim totally silent (no console or visual bell)
set visualbell t_vb=


"""""""""""""""""""""""""""
" For 256 color terminals:
"""""""""""""""""""""""""""

" Hopefully if you are using scren with 256 colors compiled in, your $TERM
" environment variable is set to 'screen-bce'. If it is just 'screen' and
" you can do 256 colors, add that option below, but know that 256 colors will
" be switched on for regular screens which will make the colors in vim look
" worse if the terminal can't handle it.
 if &term == 'xterm' || &term == 'screen-bce' || &term == 'xterm-color' || &term == 'rxvt'
	colorscheme desert
 endif
"""""""""""""""""""""""""""


""""""""""""""""""""""""""
" Key Bindings
""""""""""""""""""""""""""

map <f4> :w<CR>:!python %<CR>
:nmap \sh :source ~/.vim/vimsh/vimsh.vim
:noremap <Space> <C-d>
map <C-H> <C-PageUp>
map <C-L> <C-PageDown>
imap <C-H> <C-PageUp>
imap <C-L> <C-PageDown>
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>
" display NERDTree with Ctrl-N
nmap <silent> <c-n> :NERDTreeToggle<CR>

:set pastetoggle=<C-p>	" Toggle 'paste' mode with Ctrl-p. You _must_ be in
						" paste mode in order to paste from X11 without having
						" the text formatted in bizarre ways. Being in paste
						" mode disables a lot of vim features, so try not to
						" spend too much time in it.

""""""""""""""""""""""""""
" GUI Stuff
""""""""""""""""""""""""""

if has("gui_running")
	set guioptions-=r	" no scrollbar on the right
	set guioptions-=l	" no scrollbar on the left
	set guioptions-=b	" no scrollbar on the bottom
	set guioptions-=T	" no toolbar
	set guioptions-=m	" no menu
	set t_Co=256
	colorscheme railscasts2
	set guifont=Mensch:h14
	set showtabline=2
	set lines=100
	set columns=100
endif

" Python
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *py,*pyw set tabstop=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\s\+$/
au BufRead,BufNewFile *.py,*.pyw set textwidth=79
au BufNewFile *.py,*.pyw set fileformat=unix
autocmd BufRead *py,*pyw set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufWritePre *.py,*.pyw normal m`:%s/\s\+$//e``
autocmd FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(

" C
au BufRead *.c,*.h set shiftwidth=8
au BufNewFile *.c,*.h set shiftwidth=4
au BufRead,BufNewFile *.c,*.h set tabstop=4
au BufRead,BufNewFile *.c,*.h set noexpandtab
au BufRead,BufNewFile *.c,*.h match BadWhitespace /\s\+$/
au BufRead,BufNewFile *.c,*.h set textwidth=79
" Turn off settings in 'formatoptions' relating to comment formatting.
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - r : do not insert the comment leader when hitting <Enter> in insert mode
au BufRead,BufNewFile *.c,*.h set formatoptions-=c formatoptions-=o formatoptions-=r
au BufNewFile *.c,*.h set fileformat=unix

" Make
au BufRead,BufNewFile Makefile* set noexpandtab

" All
highlight BadWhitespace ctermbg=red guibg=red
