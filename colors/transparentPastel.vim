" Vim color file
" Maintainer:   Sir Raorn <raorn@altlinux.ru>
" Last Change:  Nov 10, 2002
" URL:		http://hell.binec.ru/

" This color scheme uses "transparent" background (dark dark blue in gvim)
" Looks really nice when vim (console) started in transparent aterm
" But gvim is good either
set background=dark

" First remove all existing highlighting.
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="transparent"

" default groups
hi Normal			ctermfg=LightBlue 	ctermbg=NONE				guifg=White	guibg=#1A1A1A

hi Cursor										guifg=Black	guibg=Green
"hi CursorIM			NONE							guifg=Black	guibg=Purple
hi Directory			ctermfg=White						guifg=White
hi DiffAdd			ctermfg=White	ctermbg=DarkCyan			guifg=White	guibg=DarkCyan
hi DiffChange			ctermfg=Gray	ctermbg=Gray				guifg=Gray 	guibg=DarkGray
hi DiffDelete			ctermfg=White	ctermbg=DarkRed				guifg=White	guibg=DarkRed
hi DiffText	cterm=bold	ctermfg=White	ctermbg=Gray		gui=bold	guifg=White	guibg=DarkGray
hi ErrorMsg			ctermfg=White	ctermbg=DarkRed				guifg=White	guibg=DarkRed
hi VertSplit	cterm=reverse						gui=reverse
hi Folded	cterm=bold	ctermfg=Cyan	ctermbg=NONE		gui=bold	guifg=Cyan	guibg=DarkCyan
hi FoldColumn			ctermfg=Green	ctermbg=NONE				guifg=Green	guibg=#00002A
hi IncSearch			ctermfg=White	ctermbg=Black				guifg=White	guibg=Black
hi LineNr			ctermfg=Gray 			ctermbg=DarkGray 			guifg=DarkCyan
hi ModeMsg	cterm=bold	ctermfg=White				gui=bold	guifg=White
hi MoreMsg	cterm=bold	ctermfg=White				gui=bold	guifg=White
hi NonText			ctermfg=NONE						guifg=NONE
hi Question			ctermfg=Green						guifg=Green
hi Search	cterm=reverse	ctermfg=fg	ctermbg=NONE		gui=reverse	guifg=fg	guibg=bg
hi SpecialKey			ctermfg=LightRed					guifg=Red
hi StatusLine	cterm=bold,reverse ctermfg=White ctermbg=Black		gui=bold,reverse guifg=White	guibg=Black
hi StatusLineNC	cterm=reverse	ctermfg=Gray	ctermbg=Black		gui=reverse	guifg=DarkGray	guibg=Black
hi Title			ctermfg=LightGreen			gui=bold	guifg=Green
hi Visual	cterm=inverse	ctermfg=Blue	ctermbg=Black	gui=inverse	guifg=DarkGray	guibg=Black
hi VisualNOS	cterm=bold,underline					gui=bold,underline
hi WarningMsg			ctermfg=White	ctermbg=DarkRed				guifg=White	guibg=DarkRed
hi WildMenu	cterm=bold	ctermfg=Black	ctermbg=Yellow		gui=bold	guifg=Black	guibg=Yellow
"hi Menu	
"hi Scrollbar	
"hi Tooltip	

" syntax highlighting groups
hi Comment			ctermfg=DarkCyan					guifg=DarkCyan

hi Constant			ctermfg=LightGreen					guifg=LightGreen
hi String			ctermfg=Yellow						guifg=Yellow
hi Character			ctermfg=Yellow						guifg=Yellow
"hi Number
"hi Boolean
"hi Float

hi Identifier			ctermfg=Cyan       guifg=Cyan
hi Function			ctermfg=White						guifg=White

hi Statement			ctermfg=Red						guifg=Red
"hi Conditional
"hi Repeat
hi Label			ctermfg=White						guifg=White
hi Operator			ctermfg=Green						guifg=Green
"hi Keyword
hi Exception			ctermfg=Gray	ctermbg=Black				guifg=Gray	guibg=Black

hi PreProc			ctermfg=DarkGreen					guifg=DarkGreen
"hi Include
"hi Define
"hi Macro
"hi PreCondit

hi Type				ctermfg=Green						guifg=Green
"hi StorageClass
"hi Structure
hi Typedef			ctermfg=Red						guifg=Red

hi Special			ctermfg=Magenta						guifg=Magenta
"hi SpecialChar
hi Tag				ctermfg=LightGreen					guifg=LightGreen
hi Delimiter			ctermfg=Green						guifg=Green
"hi SpecialComment
hi Debug			ctermfg=White	ctermbg=Black				guifg=White	guibg=Black

hi Underlined	cterm=underline						gui=underline

hi Ignore			ctermfg=DarkBlue					guifg=DarkBlue

hi Error			ctermfg=White	ctermbg=DarkRed				guifg=White	guibg=DarkRed

hi Todo				ctermfg=Black	ctermbg=Gray				guifg=Black	guibg=Gray

