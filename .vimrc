syntax on " Syntax Highlighting
set guioptions-=T " Keep MacVim Toolbar closed
colorscheme transparentPastel " Set colorscheme from ~/.vim/color/
set number " Show line numbers
set mouse=a " Mouse pointer in CLI - Option to go back in standard mode

" set bg=light " Background color now handled by colorscheme
" highlight Comment ctermfg=red " Disabled Red coloring for Comments
" highlight Type ctermfg=grey ctermbg=darkblue " Disabled Grey coloring for
" Text all this setting now are in the colorscheme. 

" omnicppcomplete options
map <C-x><C-x><C-T> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f ~/.vim/commontags /usr/include /usr/local/include <CR><CR>
set tags+=~/.vim/commontags
set tags+=~/.vim/commontags/cpp
set tags+=~/.vim/commontags/tags
 
" --- OmniCppComplete ---
" -- required --
set nocp " non vi compatible mode
filetype plugin on " enable plugins
 
" -- optional --
" auto close options when exiting insert mode or moving away
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
set completeopt=menu,menuone
 
" -- configs --
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window
let OmniCpp_LocalSearchDecl = 1 " don't require special style of function opening braces
" -- ctags --
" map <ctrl>+F12 to generate ctags for current folder:
" map <C-x><C-t> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
map <C-x><C-t> :!ctags -f - --format=2 --excmd=pattern --fields=nks .<CR><CR>
" add current directory's generated tags file to available tags
set tags+=./tags
 
" Setup the tab key to do autocompletion
function! CompleteTab()
  let prec = strpart( getline('.'), 0, col('.')-1 )
  if prec =~ '^\s*$' || prec =~ '\s$'
    return "\<tab>"
  else
    return "\<c-x>\<c-o>"
  endif
endfunction
 
inoremap <tab> <c-r>=CompleteTab()<cr>

" START auto indent
filetype indent on
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
" HTML indent & folding
" let html_my_rendering=1
" au BufNewFile,BufRead *.xml,*.htm,*.html so ~/.vim/plugin/XMLFolding.vim
" Pathogen bundle plugin manager
call pathogen#runtime_append_all_bundles()
" Default NO Folding when opening a document
set nofoldenable
" Easy motion colors remap gray for background chars
hi link EasyMotionShade  Exception
" ignorecase and smartcase, search with an uppercase character becomes a case sensitive search
set ic
set scs
