syntax on " Syntax Highlighting
set guioptions-=T " Keep MacVim Toolbar closed
colorscheme transparentHardcore " Set colorscheme from ~/.vim/color/
set number " Show line numbers
set mouse=a  " Mouse pointer in CLI - Option to go back in standard mode
" set term=ansi " add numeric pad support
set diffopt=vertical " Diff mode horizontal spit
set diffopt+=filler
set title " Add file name & location to titlebar

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
let OmniCpp_GlobalScopeSearch = 0 " disable the global scope search
" -- ctags --
" map <ctrl>+F12 to generate ctags for current folder:
map <C-x><C-t> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
" map <C-x><C-t> :!ctags -f - --format=2 --excmd=pattern --fields=nks .<CR><CR>
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
imap kk <Esc> 
map ; :
map § $
" zen coding expand abbreviation with ,,
let g:user_zen_expandabbr_key = ',,'
" Tab key in-context auto completion -> :SuperTabHelp
" let g:SuperTabDefaultCompletionType = "context"
" remap Omnifunc in-context autocomplete to qq
" ]] for keyword local autocomplete
inoremap qq <C-x><C-o>
imap ]] <C-X><C-P>
autocmd filetype css setlocal equalprg=~/.vim/csstidy.php\ -\ -t\ default\ -l\ LF " press gg=G to get tidy CSS 
autocmd filetype html setlocal equalprg=tidy\ -mi\ % " press gg=G to get tidy HTML
" built-in autocomplete omnifunc in-context for below filetypes
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete 
" autocmd BufEnter * let &titlestring = hostname() . "[vim(" . expand("%:t") . ")]"
