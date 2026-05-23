" techno-viking.vim — dark slate + electric magenta colorscheme
" Source palette: ~/Haraldr/techno-viking-ui/theme.css

highlight clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'techno-viking'
set background=dark

" ── Palette ────────────────────────────────────────────
" bg:        #0B1012    bg_deep:    #07090A
" surface:   #141A1D    surface_2:  #1C2326
" border:    #2A3438    border_sft: #1F272A
" text:      #E8E7E5    text_muted: #8B9499
" text_dim:  #5A6469
" accent:    #F12EAF    accent_hi:  #FF5BC5    accent_lo:  #B81E84
" success:   #5CE0A8    warning:    #F2C94C    danger:     #FF5C5C
" cursorln:  #141A1D

" ── Core ───────────────────────────────────────────────
hi Normal          guifg=#E8E7E5  guibg=#0B1012
hi NormalFloat     guifg=#E8E7E5  guibg=#07090A
hi NormalNC        guifg=#8B9499  guibg=#0B1012
hi Cursor          guifg=#0B1012  guibg=#F12EAF
hi CursorLine                     guibg=#141A1D  cterm=NONE
hi CursorColumn                   guibg=#141A1D
hi ColorColumn                    guibg=#141A1D
hi LineNr          guifg=#2A3438
hi CursorLineNr    guifg=#F12EAF                 gui=bold
hi SignColumn      guifg=#2A3438  guibg=#0B1012
hi VertSplit       guifg=#1F272A  guibg=NONE
hi EndOfBuffer     guifg=#141A1D

" ── Syntax ─────────────────────────────────────────────
hi Comment         guifg=#5A6469                 gui=italic
hi Constant        guifg=#F2C94C
hi String          guifg=#5CE0A8
hi Character       guifg=#5CE0A8
hi Number          guifg=#F2C94C
hi Boolean         guifg=#F2C94C
hi Float           guifg=#F2C94C
hi Identifier      guifg=#E8E7E5
hi Function        guifg=#F12EAF                 gui=bold
hi Statement       guifg=#FF5BC5                 gui=NONE
hi Conditional     guifg=#FF5BC5
hi Repeat          guifg=#FF5BC5
hi Label           guifg=#FF5BC5
hi Operator        guifg=#8B9499
hi Keyword         guifg=#FF5BC5
hi Exception       guifg=#FF5C5C
hi PreProc         guifg=#F2C94C
hi Include         guifg=#FF5BC5
hi Define          guifg=#F2C94C
hi Macro           guifg=#F2C94C
hi PreCondit       guifg=#F2C94C
hi Type            guifg=#B81E84                 gui=NONE
hi StorageClass    guifg=#B81E84
hi Structure       guifg=#B81E84
hi Typedef         guifg=#B81E84
hi Special         guifg=#F2C94C
hi SpecialChar     guifg=#F2C94C
hi Delimiter       guifg=#8B9499
hi SpecialComment  guifg=#5A6469                 gui=italic
hi Tag             guifg=#F12EAF
hi Debug           guifg=#FF5C5C
hi Underlined      guifg=#F12EAF                 gui=underline
hi Error           guifg=#FF5C5C  guibg=#1C1010  gui=bold
hi Todo            guifg=#F2C94C  guibg=NONE     gui=bold

" ── UI ─────────────────────────────────────────────────
hi Visual                         guibg=#1C2326
hi VisualNOS                      guibg=#1C2326
hi Search          guifg=#0B1012  guibg=#F2C94C
hi IncSearch       guifg=#0B1012  guibg=#F12EAF
hi CurSearch       guifg=#0B1012  guibg=#F12EAF
hi MatchParen      guifg=#F12EAF  guibg=#2A3438  gui=bold
hi Folded          guifg=#5A6469  guibg=#141A1D
hi FoldColumn      guifg=#2A3438  guibg=#0B1012
hi NonText         guifg=#1F272A
hi SpecialKey      guifg=#1F272A
hi Whitespace      guifg=#1F272A
hi WildMenu        guifg=#0B1012  guibg=#F12EAF

" ── Popup Menu ─────────────────────────────────────────
hi Pmenu           guifg=#E8E7E5  guibg=#141A1D
hi PmenuSel        guifg=#0B1012  guibg=#F12EAF
hi PmenuSbar                      guibg=#1C2326
hi PmenuThumb                     guibg=#2A3438

" ── Status / Tab Line ──────────────────────────────────
hi StatusLine      guifg=#E8E7E5  guibg=#141A1D  gui=bold
hi StatusLineNC    guifg=#5A6469  guibg=#141A1D  gui=NONE
hi TabLine         guifg=#5A6469  guibg=#141A1D
hi TabLineFill                    guibg=#141A1D
hi TabLineSel      guifg=#F12EAF  guibg=#0B1012  gui=bold

" ── Messages ───────────────────────────────────────────
hi ModeMsg         guifg=#E8E7E5                 gui=bold
hi MoreMsg         guifg=#5CE0A8
hi WarningMsg      guifg=#F2C94C
hi ErrorMsg        guifg=#FF5C5C  guibg=#0B1012

" ── Diff ───────────────────────────────────────────────
hi DiffAdd         guifg=#5CE0A8  guibg=#0F2418
hi DiffChange      guifg=#F2C94C  guibg=#241F0F
hi DiffDelete      guifg=#FF5C5C  guibg=#241010
hi DiffText        guifg=#F12EAF  guibg=#2A1422  gui=bold

" ── Spell ──────────────────────────────────────────────
hi SpellBad        guisp=#FF5C5C                 gui=undercurl
hi SpellCap        guisp=#F2C94C                 gui=undercurl
hi SpellRare       guisp=#FF5BC5                 gui=undercurl
hi SpellLocal      guisp=#5CE0A8                 gui=undercurl

" ── Git Gutter / Signs ─────────────────────────────────
hi GitGutterAdd    guifg=#5CE0A8  guibg=#0B1012
hi GitGutterChange guifg=#F2C94C  guibg=#0B1012
hi GitGutterDelete guifg=#FF5C5C  guibg=#0B1012

" ── Directory / netrw ──────────────────────────────────
hi Directory       guifg=#F12EAF

" ── Terminal cursor ────────────────────────────────────
hi TermCursor                     guibg=#F12EAF
hi TermCursorNC                   guibg=#2A3438
