function! RunPhpcs()
    let l:filename=@%
    let l:phpcs_output=system('phpcs --report=emacs --standard=Zend '.l:filename)
"    echo l:phpcs_output
    let l:phpcs_list=split(l:phpcs_output, "\n")
    unlet l:phpcs_list[0]
    cexpr l:phpcs_list
    copen
endfunction

" set errorformat+=\"%f\"\\,%l\\,%c\\,%t%*[a-zA-Z]\\,\"%m\"
" command! Phpcs execute RunPhpcs()
" 

" function! RunPhpcs()
" let l:filename=@%
" let l:phpcs_output=system('phpcs --report=csv --standard=Pear '.l:filename)
" let l:phpcs_list=split(l:phpcs_output, "\n")
" unlet l:phpcs_list[0]
" cexpr l:phpcs_list
" cwindow
" endfunction

" set errorformat=%E\"%f\"\\,%l\\,%c\\,error\\,\"%m\"\\,%*[a-zA-Z.],%W\"%f\"\\,%l\\,%c\\,warning\\,\"%m\"\\,%*[a-zA-Z.],%-GFile\\,Line\\,Column\\,Severity\\,Message\\,Source
" set errorformat+=\"%f\"\\,%l\\,%c\\,%t%*[a-zA-Z]\\,\"%m\"
set errorformat=%f:%l:%c:%m
command! Phpcs execute RunPhpcs()

