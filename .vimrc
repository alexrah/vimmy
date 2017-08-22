" Pathogen bundle plugin manager
call pathogen#runtime_append_all_bundles()
syntax on " Syntax Highlighting
set guioptions-=T " Keep MacVim Toolbar closed
colorscheme transparentHardcore " Set colorscheme from ~/.vim/color/
set number " Show line numbers
" set mouse=a  " Mouse pointer in CLI - Option to go back in standard mode
if has('mouse')
  set mouse=a
  if &term =~ "xterm" || &term =~ "screen"
    " as of March 2013, this works:
    set ttymouse=xterm2

    " previously, I found that ttymouse was getting reset, so had
    " to reapply it via an autocmd like this:
    autocmd VimEnter,FocusGained,BufEnter * set ttymouse=xterm2
  endif
endif
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
 
inoremap <tab> <c-r>=CompleteTab()<c-r>
" START auto indent
filetype indent on
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
function! HTMLSettings()
setlocal foldmethod=indent
setlocal foldnestmax=1
endfunction
au FileType HTML call HTMLSettings()
au FileType XHTML call HTMLSettings()
au FileType php.wordpress call HTMLSettings()
" HTML indent & folding
"let html_my_rendering=1
"au BufNewFile,BufRead *.xml,*.htm,*.html so ~/.vim/bundle/phpcs/plugin/XMLFolding
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
" let g:user_zen_expandabbr_key = ',,'
" zen coding add support to css.drupal filetype
" NOT WORKING! NEED A PATCH TO THE MODULE, FORKED
" let g:user_zen_settings = {
"       \  'css.drupal' : {
"       \    'extends' : 'css',
"       \  },
"       \}
" Emmet.io is the new zen coding, replace and add features, check emmet.io
let g:user_emmet_expandabbr_key = ',,'
" SUPER TAB CONFIG
" Tab key in-context auto completion -> :SuperTabHelp
" let g:SuperTabDefaultCompletionType = "context"
" remap Omnifunc in-context autocomplete to qq
inoremap qq <C-x><C-o>
" ]] for keyword local autocomplete
imap ]] <C-X><C-P>
" NEW qf shortcut for file path autocompletion
inoremap qf <C-x><C-f>
" tidy functions for css and html files PS: I need to add yuicompressor!
autocmd filetype css setlocal equalprg=~/.vim/command_line_tools/csstidy.php\ -\ -t\ default\ -l\ LF " press gg=G to get tidy CSS 
autocmd filetype html setlocal equalprg=tidy\ -mi\ % " press gg=G to get tidy HTML
autocmd filetype xml setlocal equalprg=tidy\ --input-xml\ 1\ % " press gg=G to get tidy HTML
autocmd filetype javascript setlocal equalprg=tidy\ --input-xml\ 1\ % " press gg=G to get tidy HTML
autocmd filetype php.wordpress setlocal equalprg=php_beautifier\ -s4\ -l\ 'ListClassFunction()'\ %\ - " press gg=G to get tidy PHP
" built-in autocomplete omnifunc in-context for below filetypes
" autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python set omnifunc=RopeOmni
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
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
  set csprg=/usr/bin/cscope
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
" map <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>          
" Find function called by this function
map <C-[> :cs find g <C-R>=expand("<cword>")<CR><CR>
" END CSCOPE configuration
" ManPageView backup shortcut in case of K shortcut fails
" map <C-k> :!pman <C-R>=expand("<cword>")<CR><CR>
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
let g:syntastic_php_checkers = ['phpmd', 'phpcs', 'php' ]
let g:syntastic_phpcs_conf=" --standard=WordPress --extensions=php,module,inc,install,test,profile,theme"
let g:syntastic_phpmd_conf="text codesize,design,unusedcode,naming"
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

" Add HTML support to Exuberant Ctags
let g:tagbar_type_html = {
  \ 'ctagstype' : 'HTML',
    \ 'kinds'   : [
      \ 'a:named anchors',
      \ 'f:Javascript functions',
      \ '1:h1 header',
      \ '2:h2 header',
      \ '3:h3 header',
      \ '4:h4 header',
      \ '5:h5 header',
      \ '6:h6 header',
      \ 'o:object',
      \ 'c:class'
    \ ]
  \ }
let g:tagbar_type_php = {
  \ 'ctagstype' : 'PHP',
    \ 'kinds'   : [
      \ 'i:interfaces',
      \ 'v:variables',
      \ 'j:javascript functions',
      \ 'a:named anchors',
      \ 'f:functions',
      \ '1:h1 header',
      \ '2:h2 header',
      \ '3:h3 header',
      \ '4:h4 header',
      \ '5:h5 header',
      \ '6:h6 header',
      \ 'o:object',
      \ 'c:class'
    \ ]
  \}
  "   \ 'kind2scope' : {
  "     \ 'a' : 'named anchors',
  "     \ 'f' : 'functions',
  "     \ '1' : 'h1 header',
  "     \ '2' : 'h2 header',
  "     \ '3' : 'h3 header',
  "     \ '4' : 'h4 header',
  "     \ '5' : 'h5 header',
  "     \ '6' : 'h6 header',
  "     \ 'o' : 'object',
  "     \ 'c' : 'class'
  "       \ },
  "   \ 'scope2kind' : {
  "     \ 'a' : 'named anchors',
  "     \ 'f' : 'functions',
  "     \ '1' : 'h1 header',
  "     \ '2' : 'h2 header',
  "     \ '3' : 'h3 header',
  "     \ '4' : 'h4 header',
  "     \ '5' : 'h5 header',
  "     \ '6' : 'h6 header',
  "     \ 'o' : 'object',
  "     \ 'c' : 'class'
  "   \ }
  " \ }
" Add CSS support to Exuberant Ctags
let g:tagbar_type_css = {
      \ 'ctagstype' : 'css',
  \ 'kinds'   : [
    \ 't:Table of Contents',
    \ 'i:Identities',
    \ 'c:Classes',
    \ 'm:Media',
    \ 's:Selectors',
  \ ]
  \ }

let g:tagbar_type_scss = {
      \ 'ctagstype' : 'scss',
  \ 'kinds'   : [
    \ 't:Table of Contents',
    \ 'x:Mixins',
    \ 'v:Variables',
    \ 'i:Identities',
    \ 'c:Classes',
    \ 'm:Media',
    \ 's:selectors',
  \ ]
  \ }


" Autoload closetag.vim plugin
let g:closetag_html_style=1
" au Filetype html,xml,xsl -> shortcut: <C-p>
source ~/.vim/bundle/closetags/closetag.vim

" Persistent Undo (vim 7.3 and later) I STILL HAVE ISSUES RESOLVING
" ENVIRONMENT VARIABLE $HOME AS I DID WITH ~  
" if empty(glob('$HOME/.vim_runtime/undodir'))
"       call mkdir('$HOME/.vim_runtime/undodir', "p")
"     endif
if exists('&undofile') && !&undofile
  set undodir=~/.vim_runtime/undodir
  set undofile
endif

" Persistent Undo (vim 7.3 and later) WITH WINDOWS ENVIRONMENT VARIABLE
" %HOMEPATH%  -> BUT STILL NOT WORKING
" if empty(glob('%HOMEPATH%/.vim_runtime/undodir'))
"       call mkdir('%HOMEPATH%/.vim_runtime/undodir', "p")
"      endif
" if exists('&undofile') && !&undofile
"     set undodir=~/.vim_runtime/undodir
"     set undofile
"   endif

" add shortcut for CtrlP plugin, CommandT replacement
nnoremap <silent> <Leader>t :CtrlPMixed<CR>
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'ra'
" add support for XDUBUG within Vim
source ~/.vim/bundle/debugger/debugger.vim
" DocHub.io CSS HTML JS PHP Python MANUALS
" let g:dochub_mapping='<C-k>'
" ENABLE COLORING HEX COLOR CODES
let g:colorizer_auto_filetype='css,html,scss'
" MAP handlebars template files to html syntax
autocmd BufNewFile,BufRead *.hbs set syntax=html
" ULTISNIPS snippets engine expand keyword
let g:UltiSnipsExpandTrigger=".."
" WORDPRESS plugin: codex search
:nnoremap <leader>co :Wcodexsearch<CR>

" NeoComplete autocompletion engine configuration
" let g:neocomplete#enable_at_startup =1
" let g:neocomplete#enable_ignore_case =1
" let g:neocomplete#enable_fuzzy_completion =1
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"
" Vim CSS colors configuration
let g:cssColorVimDoNotMessMyUpdatetime = 1
set t_Co=256

let g:phpcomplete_search_tags_for_variables = 1
let g:phpcomplete_parse_docblock_comments = 1
let g:phpcomplete_enhance_jump_to_definition = 5
" let g:phpcomplete_mappings = {
"    \ 'jump_to_def': '<C-]>',
"    \ 'jump_to_def_split': '<leader>]>',
"    \ 'jump_to_def_vsplit': '<C-W><C-\>',
"    \}
nnoremap <leader>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"GNU Global configuration
source ~/.vim/bundle/gtags-cscope.vim
let GtagsCscope_Auto_Load = 1
let GtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1
set cscopetag
