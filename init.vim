call plug#begin(stdpath('data') . '/plugged')
" Plug 'liuchengxu/eleline.vim'
Plug 'vim-airline/vim-airline'
Plug 'pacha/vem-tabline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liuchengxu/vista.vim'
Plug 'pechorin/any-jump.vim'
Plug 'https://github.com/easymotion/vim-easymotion'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kaicataldo/material.vim'
Plug 'mattn/emmet-vim'
Plug 'SirVer/ultisnips'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'tpope/vim-commentary'
Plug 'ryanoasis/vim-devicons'
Plug 'https://github.com/zenbro/mirror.vim'
Plug 'tpope/vim-fugitive'
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
" switch buffers without having to save their changes before.
set hidden

set nocompatible    " disable backward compatibility with Vi
set foldmethod=indent 

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
" change default usage to <Leader>s
map <Leader> <Plug>(easymotion-prefix)
" Easy motion colors remap gray for background chars
" hi link EasyMotionShade  Exception
let g:EasyMotion_keys = '1234567890abcdefghijklmnopqrstuvwxyz'
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

" FZF START
" add shortcut for CtrlP plugin, CommandT replacement
nnoremap <silent> <Leader>f :Files<CR>
let $FZF_DEFAULT_COMMAND = 'rg --hidden --files'
" FZF END

" MATERIAL.VIM START
colorscheme material
if (has('termguicolors'))
  set termguicolors
endif
" let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker'
let g:material_theme_style = 'ocean' 
let g:material_terminal_italics = 1

" COC CONFIG START
let g:coc_global_extensions = [
  \ 'coc-phpls', 
  \ 'coc-python',
  \ 'coc-sh',
  \ 'coc-tsserver',
  \ 'coc-html',
  \ 'coc-git',
  \ 'coc-emmet',
  \ 'coc-css',
  \ 'coc-snippets',
  \ 'coc-json',
  \ 'coc-sql',
  \ 'coc-db'
  \ ]

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> <C-q> :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" COC CONFIG END

" EMMET CONFIG START
" Emmet.io is the new zen coding, replace and add features, check emmet.io
let g:user_emmet_expandabbr_key = ',,'
" EMMET CONFIG END

" ULTISNIPS CONFIG START
" ULTISNIPS snippets engine expand keyword
let g:UltiSnipsExpandTrigger=".."
" ULTISNIPS CONFIG END
"
" shift+arrow selection
nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
imap <S-Up> <Esc>v<Up>
imap <S-Down> <Esc>v<Down>
imap <S-Left> <Esc>v<Left>
imap <S-Right> <Esc>v<Right>

vmap <C-c> "+y<Esc>i
vmap <C-x> "+d<Esc>i
map <C-v> pi
imap <C-v> <Esc>pi
imap <C-z> <Esc>ui

" AIRLINE CONFIG START
let g:airline#extensions#tabline#enabled = 0
" AIRLINE CONFIG END

" TABLINE CONFIG START
let g:vem_tabline_show = 1
" TABLINE CONFIG END

" Persistent Undo (vim 7.3 and later) I STILL HAVE ISSUES RESOLVING
" ENVIRONMENT VARIABLE $HOME AS I DID WITH ~  
" if empty(glob('$HOME/.vim_runtime/undodir'))
"       call mkdir('$HOME/.vim_runtime/undodir', "p")
"     endif
if exists('&undofile') && !&undofile
  set undodir=~/.vim_runtime/undodir
  set undofile
endif

" MIRROR CONFIG START

function! MirrorPathFunction() abort
  return get(b:, 'pwd', '') + '/.mirrors'
endfunction

" let g:mirror#config_path = MirrorPathFunction()

nnoremap <silent> do :diffoff<CR>
nnoremap <silent> md :MirrorDiff<CR>
nnoremap <silent> mp :MirrorPush<CR>
" MIRROR CONFIG END
