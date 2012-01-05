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
"let html_my_rendering=1
"au BufNewFile,BufRead *.xml,*.htm,*.html so ~/.vim/bundle/phpcs/plugin/XMLFolding
" Pathogen bundle plugin manager
call pathogen#runtime_append_all_bundles()
" Default NO Folding when opening a document
set nofoldenable
" Easy motion colors remap gray for background chars
hi link EasyMotionShade  Exception
let g:EasyMotion_keys = '1234567890abcdefghijklmnopqrstuvwxyz'
" ignorecase and smartcase, search with an uppercase character becomes a case sensitive search
set ic
set scs
imap kk <Esc> 
map ; :
" remap $ to move cursor to start line
map § $
" zen coding expand abbreviation with ,,
let g:user_zen_expandabbr_key = ',,'
" SUPER TAB CONFIG
" Tab key in-context auto completion -> :SuperTabHelp
" let g:SuperTabDefaultCompletionType = "context"
" remap Omnifunc in-context autocomplete to qq
inoremap qq <C-x><C-o>
" ]] for keyword local autocomplete
imap ]] <C-X><C-P>
" tidy functions for css and html files PS: I need to add yuicompressor!
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
" automatically reload foldings
au BufWinLeave * mkview
au BufWinEnter * silent loadview
" machit tag configuration
let b:match_words = '<:>,<tag>:</tag>'
" EasyMotion leader 
let g:EasyMotion_mapping_t = '_t'
" CSCOPE configuration
if has("cscope")
  set csprg=/usr/local/bin/cscope
  set csto=0
  set cst
  set nocsverb
 " add any database in current directory
if filereadable("cscope.out")
  cs add cscope.out
" else add database pointed to by environment
elseif $CSCOPE_DB != ""
  cs add $CSCOPE_DB
endif
  set csverb
endif  
" Find function calling this function
map <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>          
" Find function called by this function
map <C-[> :cs find d <C-R>=expand("<cword>")<CR><CR>
" END CSCOPE configuration
" set the names of flags
let Tlist_php_settings = 'php;c:class;f:function;d:constant'
" close all folds except for current file
let Tlist_File_Fold_Auto_Close = 1
" make tlist pane active when opened
let Tlist_GainFocus_On_ToggleOpen = 1
" width of window
let Tlist_WinWidth = 35
" close tlist when a selection is made
let Tlist_Close_On_Select = 0
" remap Tlist Open Close command to 
nnoremap <silent> tt :TlistToggle<CR> 
" ManPageView backup shortcut in case of K shortcut fails
map <C-k> :Man <C-R>=expand("<cword>")<CR><CR>
" remap NERDTree Open Close command to
nnoremap <silent> tr :NERDTreeToggle<CR> 
" NERDTree options
let NERDTreeChristmasTree = 1
let NERDTreeShowHidden = 1
let NERDTreeWinSize = 25
let NERDTreeDirArrows = 1
let NERDTreeChDirMode = 2
" Compress and Obfuscate CSS and JS files
map <C-l> :!java -jar ~/.vim/yuicompressor-2.4.8pre.jar -o % %<CR>
