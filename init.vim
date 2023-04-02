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
" THEMES START
" Plug 'kaicataldo/material.vim'
" Plug 'https://github.com/joshdick/onedark.vim'
" THEMES END
Plug 'https://github.com/rakr/vim-one'
Plug 'https://github.com/StanAngeloff/php.vim'
Plug 'mattn/emmet-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'norcalli/nvim-colorizer.lua'
Plug 'https://github.com/tomtom/tcomment_vim'
Plug 'ryanoasis/vim-devicons'
Plug 'https://github.com/zenbro/mirror.vim'
Plug 'tpope/vim-fugitive'
Plug 'terryma/vim-expand-region'
Plug 'https://github.com/jelera/vim-javascript-syntax'
Plug 'https://github.com/othree/javascript-libraries-syntax.vim'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/907th/vim-auto-save'
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
" If you have nodejs and yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
call plug#end()

let mapleader = ","
set number
set mouse=a
set ic
set scs
imap kk <Esc>
map ; :
" map 1 0
" map 0 $
set noshowmode
" switch buffers without having to save their changes before.
set hidden

" TAB as 2 spaces
filetype plugin indent on
" On pressing tab, insert 2 spaces
" show existing tab with 2 spaces width
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab

" close buffer by pressing mm in normal mode
nnoremap <silent> mm :bd<CR>
" go to previous tab by pressing mn in normal mode
nnoremap <silent> mn :bprevious<CR>
" go to previous tab by pressing m, in normal mode
nnoremap <silent> m, :bnext<CR>

" Tabs shortcuts
" map <C-t><up> :tabr<cr>
" map <C-t><down> :tabc<cr>
nnoremap <silent> <C-Left> :tabprevious<cr>
map <C-Left> :tabprevious<cr>
inoremap <C-Left> :tabprevious<cr>
noremap <C-Right> :tabnext<cr>
inoremap <C-Right> :tabnext<cr>
map <C-Right> :tabnext<cr>


set nocompatible    " disable backward compatibility with Vi

set wrap linebreak nolist
command! -nargs=* Wrap set wrap linebreak nolist

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
nnoremap <silent> tf :NERDTreeFind<CR>
" NERDTree options
let NERDTreeChristmasTree = 1
let NERDTreeShowHidden = 1
let NERDTreeWinSize = 25
let NERDTreeDirArrows = 1
let NERDTreeChDirMode = 2
" NERDTREE END

" FZF START
let $FZF_DEFAULT_COMMAND = "rg --hidden --files -g '!.git/'"
nnoremap <silent> <Leader>f :Files<CR>

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
nnoremap <silent> <Leader>r :RG<CR>
nnoremap <silent> <Leader>h :History<CR>
" FZF END

" MATERIAL.VIM START
" let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker'
let g:material_theme_style = 'default' 
" let g:material_terminal_italics = 1
" let g:onedark_terminal_italics = 1
let g:one_allow_italics = 1
syntax on
" colorscheme material
" colorscheme onedark
colorscheme one
set background=dark
if (has('termguicolors'))
  set termguicolors
endif
" MATERIAL.VIM END

" NVIM-COLORIZER.LUA CONFIG START
lua require 'colorizer'.setup()
" NVIM-COLORIZER.LUA CONFIG END

" COC CONFIG START
let g:coc_node_path = trim(system('which node'))
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
  \ 'coc-db',
  \ 'coc-webpack',
  \ 'coc-highlight',
  \ 'coc-yaml',
  \ 'coc-prisma'
  \ ]

" GoTo code navigation.
nmap <silent> <C-b> <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <C-q> as in PHPStorm to show documentation in preview window.
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

" Use <tab> and <S-tab> to navigate completion list:
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Use <c-space> to trigger completion:
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <CR> to confirm completion, use:
inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

" add shortcut command to list all errors in current buffer
:command Errors CocList diagnostics

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
  	" set undodir=~/.vim_runtime/undodir
	set undodir=~/.local/share/nvim/undodir"
  	set undofile
endif

" MIRROR CONFIG START

function! MirrorPathFunction() abort
  return get(b:, 'pwd', '') + '/.mirrors'
endfunction

" let g:mirror#config_path = MirrorPathFunction()

nnoremap <silent> dt :windo diffthis<CR>
nnoremap <silent> do :diffoff<CR>
nnoremap <silent> md :MirrorDiff<CR>
nnoremap <silent> mp :MirrorPush<CR>
" MIRROR CONFIG END

" FUGITIVE CONFIG START
nnoremap <silent> gd :Gvdiffsplit<CR>
" FUGITIVE CONFIG END

" PYTHON VIRTUALENV SUPPORT START
" let g:python_host_prog = '~/.virtualenvs/neovim-python2/py2/bin/python'
" let g:python3_host_prog = '~/.virtualenvs/neovim-python3/py3/bin/python3'
" PYTHON VIRTUALENV SUPPORT END
"
" VIM-AUTO-SAVE START
let g:auto_save = 1  " enable AutoSave on Vim startup
" VIM-AUTO-SAVE END
"
" FOLDING

autocmd BufRead * normal zR

function! VimFolds(lnum)
    " get content of current line and the line below
    let l:cur_line = getline(a:lnum)
    let l:next_line = getline(a:lnum+1)

    if l:cur_line =~# '{'
        return '>' . (matchend(l:cur_line, '{*') - 1)
    else
        if l:cur_line ==# '' && (matchend(l:next_line, '{*') - 1) == 1
            return 0
        else
            return '='
        endif
    endif
endfunction

set foldmethod=indent 
" set foldmethod=syntax 
" set foldmethod=expr
" set foldexpr=VimFolds(v:lnum)

