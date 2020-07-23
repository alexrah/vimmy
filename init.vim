
call plug#begin(stdpath('data') . '/plugged')
Plug 'liuchengxu/eleline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liuchengxu/vista.vim'
Plug 'pechorin/any-jump.vim'
Plug 'https://github.com/easymotion/vim-easymotion'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'kaicataldo/material.vim'
Plug 'ryanoasis/vim-devicons'
call plug#end()

let mapleader = ","
set number
set ic
set scs
imap kk <Esc>
map ; :
" map 1 0
" map 0 $
set noshowmode

" OMNIFUNC CONFIG START
" remap Omnifunc in-context autocomplete to qo
inoremap qo <C-x><C-o>
" qp for keyword local autocomplete
inoremap qp <C-X><C-P>
" NEW qf shortcut for file path autocompletion
inoremap qf <C-x><C-f>
" OMNIFUNC CONFIG END

" VISTA CONFIG START
nnoremap <silent> tt :Vista!!<CR>

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" " How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'coc'

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" VISTA CONFIG END

" EASYMOTION START
" default usage: <Leader><Leader>s
" Easy motion colors remap gray for background chars
" hi link EasyMotionShade  Exception
" let g:EasyMotion_keys = '1234567890abcdefghijklmnopqrstuvwxyz'
" EasyMotion remappings
" let g:EasyMotion_mapping_t = '_t'
" let g:EasyMotion_mapping_b = '\e'
" let g:EasyMotion_mapping_e = '_e'
" EASYMOTION END
"
" ANYJUMP START
" Customize any-jump colors with extending default color scheme:
" Or override all default colors
let g:any_jump_colors = {
      \"plain_text":         "Comment",
      \"preview":            "Comment",
      \"preview_keyword":    "Operator",
      \"heading_text":       "Function",
      \"heading_keyword":    "Identifier",
      \"group_text":         "Comment",
      \"group_name":         "Function",
      \"more_button":        "Operator",
      \"more_explain":       "Comment",
      \"result_line_number": "Comment",
      \"result_text":        "Statement",
      \"result_path":        "String",
      \"help":               "Comment"
      \}
" ANYJUMP END

" NERDTREE START
 " remap NERDTree Open Close command to
nnoremap <silent> tr :NERDTreeToggle<CR>
" NERDTree options
let NERDTreeChristmasTree = 1
let NERDTreeShowHidden = 1
let NERDTreeWinSize = 25
let NERDTreeDirArrows = 1
let NERDTreeChDirMode = 2
" NERDTREE END

" CtrlP START
" add shortcut for CtrlP plugin, CommandT replacement
nnoremap <silent> <Leader>t :CtrlPMixed<CR>
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'ra'
" CtrlP END

" MATERIAL.VIM START
colorscheme material
if (has('termguicolors'))
  set termguicolors
endif
" let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker'
let g:material_theme_style = 'ocean' 
let g:material_terminal_italics = 1

