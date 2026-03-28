" ember.vim — warm red/orange colorscheme for SSH remote sessions
" Companion to Tokyo Night; same structure, shifted to ember palette

highlight clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'ember'
set background=dark

" ── Palette ────────────────────────────────────────────
" bg:        #1c1210    fg:        #d8c4b0
" black:     #1a1410    bright_bk: #4a3830
" red:       #ff6b6b    bright_r:  #ff8888
" gold:      #b8a84a    bright_g:  #d0bc5c
" amber:     #e89048    bright_a:  #f0a460
" terra:     #d47850    bright_t:  #e09068
" rose:      #c86878    bright_ro: #d87888
" orange:    #e09860    bright_o:  #f0b070
" grey:      #b8a898    cream:     #e8d4c0
" gutter:    #6a5848    select:    #3a2420
" cursorln:  #261a16    comment:   #7a6858

" ── Core ───────────────────────────────────────────────
hi Normal          guifg=#d8c4b0  guibg=#1c1210
hi NormalFloat     guifg=#d8c4b0  guibg=#1a1410
hi NormalNC        guifg=#b8a898  guibg=#1c1210
hi Cursor          guifg=#1c1210  guibg=#ff8c42
hi CursorLine                     guibg=#261a16  cterm=NONE
hi CursorColumn                   guibg=#261a16
hi ColorColumn                    guibg=#261a16
hi LineNr          guifg=#4a3830
hi CursorLineNr   guifg=#e89048               gui=bold
hi SignColumn      guifg=#4a3830  guibg=#1c1210
hi VertSplit       guifg=#3a2420  guibg=NONE
hi EndOfBuffer     guifg=#2a1e1a

" ── Syntax ─────────────────────────────────────────────
hi Comment         guifg=#7a6858               gui=italic
hi Constant        guifg=#e89048
hi String          guifg=#b8a84a
hi Character       guifg=#b8a84a
hi Number          guifg=#f0a460
hi Boolean         guifg=#e89048
hi Float           guifg=#f0a460
hi Identifier      guifg=#d8c4b0
hi Function        guifg=#d47850
hi Statement       guifg=#ff6b6b               gui=NONE
hi Conditional     guifg=#ff6b6b
hi Repeat          guifg=#ff6b6b
hi Label           guifg=#ff6b6b
hi Operator        guifg=#e09860
hi Keyword         guifg=#ff6b6b
hi Exception       guifg=#ff6b6b
hi PreProc         guifg=#f0a460
hi Include         guifg=#ff8888
hi Define          guifg=#f0a460
hi Macro           guifg=#f0a460
hi PreCondit       guifg=#f0a460
hi Type            guifg=#c86878               gui=NONE
hi StorageClass    guifg=#c86878
hi Structure       guifg=#c86878
hi Typedef         guifg=#c86878
hi Special         guifg=#e09860
hi SpecialChar     guifg=#e09860
hi Delimiter       guifg=#b8a898
hi SpecialComment  guifg=#7a6858               gui=italic
hi Tag             guifg=#d47850
hi Debug           guifg=#ff6b6b
hi Underlined      guifg=#d47850               gui=underline
hi Error           guifg=#ff6b6b  guibg=#3a1a1a gui=bold
hi Todo            guifg=#e89048  guibg=NONE    gui=bold

" ── UI ─────────────────────────────────────────────────
hi Visual                         guibg=#3a2420
hi VisualNOS                      guibg=#3a2420
hi Search          guifg=#1c1210  guibg=#e89048
hi IncSearch       guifg=#1c1210  guibg=#ff8c42
hi CurSearch       guifg=#1c1210  guibg=#ff8c42
hi MatchParen      guifg=#ff8c42  guibg=#4a3830  gui=bold
hi Folded          guifg=#7a6858  guibg=#261a16
hi FoldColumn      guifg=#4a3830  guibg=#1c1210
hi NonText         guifg=#3a2420
hi SpecialKey      guifg=#3a2420
hi Whitespace      guifg=#3a2420
hi WildMenu        guifg=#1c1210  guibg=#d47850

" ── Popup Menu ─────────────────────────────────────────
hi Pmenu           guifg=#d8c4b0  guibg=#1a1410
hi PmenuSel        guifg=#1c1210  guibg=#d47850
hi PmenuSbar                      guibg=#261a16
hi PmenuThumb                     guibg=#4a3830

" ── Status / Tab Line ──────────────────────────────────
hi StatusLine      guifg=#d8c4b0  guibg=#1a1410  gui=bold
hi StatusLineNC    guifg=#6a5848  guibg=#1a1410  gui=NONE
hi TabLine         guifg=#6a5848  guibg=#1a1410
hi TabLineFill                    guibg=#1a1410
hi TabLineSel      guifg=#d8c4b0  guibg=#1c1210  gui=bold

" ── Messages ───────────────────────────────────────────
hi ModeMsg         guifg=#d8c4b0               gui=bold
hi MoreMsg         guifg=#b8a84a
hi WarningMsg      guifg=#e89048
hi ErrorMsg        guifg=#ff6b6b  guibg=#1c1210

" ── Diff ───────────────────────────────────────────────
hi DiffAdd         guifg=#b8a84a  guibg=#2a2410
hi DiffChange      guifg=#e89048  guibg=#2a1e10
hi DiffDelete      guifg=#ff6b6b  guibg=#2a1414
hi DiffText        guifg=#e89048  guibg=#3a2a14  gui=bold

" ── Spell ──────────────────────────────────────────────
hi SpellBad        guisp=#ff6b6b               gui=undercurl
hi SpellCap        guisp=#e89048               gui=undercurl
hi SpellRare       guisp=#c86878               gui=undercurl
hi SpellLocal      guisp=#e09860               gui=undercurl

" ── Git Gutter ─────────────────────────────────────────
hi GitGutterAdd    guifg=#b8a84a  guibg=#1c1210
hi GitGutterChange guifg=#e89048  guibg=#1c1210
hi GitGutterDelete guifg=#ff6b6b  guibg=#1c1210

" ── Directory / netrw ──────────────────────────────────
hi Directory       guifg=#d47850

" ── Terminal cursor ────────────────────────────────────
hi TermCursor                     guibg=#ff8c42
hi TermCursorNC                   guibg=#4a3830
