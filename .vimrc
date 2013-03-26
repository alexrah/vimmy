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
function! HTMLSettings()
setlocal foldmethod=indent
endfunction
au FileType HTML call HTMLSettings()
au FileType XHTML call HTMLSettings()
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
" EasyMotion remappings 
let g:EasyMotion_mapping_t = '_t'
let g:EasyMotion_mapping_b = '\e' 
let g:EasyMotion_mapping_e = '_e'
" Command-t remapping
let g:CommandTAcceptSelectionSplitMap ='<C-X>'
" ignorecase and smartcase, search with an uppercase character becomes a case sensitive search
set ic
set scs
imap kk <Esc> 
map ; :
" remap $ to move cursor to start line
map § $
" zen coding expand abbreviation with ,,
let g:user_zen_expandabbr_key = ',,'
" zen coding add support to css.drupal filetype
" NOT WORKING! NEED A PATCH TO THE MODULE, FORKED
" let g:user_zen_settings = {
"       \  'css.drupal' : {
"       \    'extends' : 'css',
"       \  },
"       \}
" SUPER TAB CONFIG
" Tab key in-context auto completion -> :SuperTabHelp
" let g:SuperTabDefaultCompletionType = "context"
" remap Omnifunc in-context autocomplete to qq
inoremap qq <C-x><C-o>
" ]] for keyword local autocomplete
imap ]] <C-X><C-P>
" tidy functions for css and html files PS: I need to add yuicompressor!
autocmd filetype css setlocal equalprg=~/.vim/command_line_tools/csstidy.php\ -\ -t\ default\ -l\ LF " press gg=G to get tidy CSS 
autocmd filetype html setlocal equalprg=tidy\ -mi\ % " press gg=G to get tidy HTML
" built-in autocomplete omnifunc in-context for below filetypes
" autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python set omnifunc=RopeOmni
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete 
" " automatically reload foldings
" au BufWinLeave ?* mkview 1
" REMOVED THE LINE BELOW TO SOLVE XDEBUG ISSUE WITH PHP.DRUPAL
" au BufWinEnter ?* silent loadview 1

" machit tag configuration
let b:match_words = '<:>,<tag>:</tag>'
" START CSCOPE configuration
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
map <C-l> :!java -jar ~/.vim/command_line_tools/yuicompressor-2.4.8pre.jar -o % %<CR>
" Compress HTML Files
map <C-h> :!java -jar ~/.vim/command_line_tools/htmlcompressor-1.5.2.jar -o % %<CR>
" Syntastic PHP drupal coding standard
let g:syntastic_phpcs_conf=" --standard=DrupalCodingStandard --extensions=php,module,inc,install,test,profile,theme"
if has('statusline')
      set laststatus=2
      " Broken down into easily includeable segments
      set statusline=%<%f\    " Filename
      set statusline+=%w%h%m%r " Options
      set statusline+=%{fugitive#statusline()} "  Git Hotness
      set statusline+=\ [%{&ff}/%Y]            " filetype
      set statusline+=\ [%{getcwd()}]          " current dir
      set statusline+=%#warningmsg#
      set statusline+=%{SyntasticStatuslineFlag()}
      set statusline+=%*
      let g:syntastic_enable_signs=1
      set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif
" END Syntastic configuration
" START TAGBAR config
let g:tagbar_left = 1
let g:tagbar_width = 35
let g:tagbar_expand = 1
nnoremap <silent> tt :TagbarToggle<CR>
" END TAGBAR config
nnoremap <C-W>O :call MaximizeToggle ()<CR>
nnoremap <C-W>o :call MaximizeToggle ()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle ()<CR>
"START Maximize - Minimize in multi-panel view
function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction
"END Maximize - Minimize in multi-panel view
 
