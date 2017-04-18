" Change the 'cpoptions' option temporarily {{{
" Set to its Vim default value and restore it later.
" This is to enable line-continuation within this script.
" Refer to :help use-cpo-save.
let s:save_cpoptions = &cpoptions
set cpoptions&vim
" }}}

function! surround#doit(mode, count) "{{{

  let l:surround = input('Input the surround (2 chars): ')
  if l:surround == '' | let l:surround = '()' | endif
  let l:open = strcharpart(l:surround, 0, 1)
  let l:close = strchars(l:surround) > 1
    \ ? strcharpart(l:surround, 1, 1)
    \ : l:open

  function! s:doit(...) closure "{{{
    let l:move = get(a:000, 0, '')
    let l:insert = get(a:000, 2, 'i')
    let l:append = get(a:000, 2, 'a')
    " let l:gv = get(a:000, 3, '')
    execute 'normal! `<' . a:count . l:insert . l:open
    execute 'normal! `>' . l:move . a:count . l:append . l:close
  endfunction "}}}

  if a:mode ==# 'n'
    execute "normal! viw\<Esc>"
    call s:doit(a:count . 'l')
  elseif a:mode ==# 'v'
    if line("'<") == line("'>")
      call s:doit(a:count . 'l')
    else
      call s:doit()
    endif
  elseif a:mode ==# 'V'
    call s:doit('j', 'O', 'o')
  elseif a:mode ==# "\<C-V>"
    execute 'normal! gv' . a:count . 'A' . l:close
    execute 'normal! gv' . a:count . 'I' . l:open
  endif

endfunction "}}}

" Restore 'cpoptions' setting {{{
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
" }}}
