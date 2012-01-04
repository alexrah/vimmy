" colorscheme evening " Set colorscheme from MacVim
set guifont=Andale\ Mono:h13
colorscheme transparentHardcore
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

