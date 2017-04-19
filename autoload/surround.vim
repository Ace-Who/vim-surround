" Change the 'cpoptions' option temporarily {{{
" Set to its Vim default value and restore it later.
" This is to enable line-continuation within this script.
" Refer to :help use-cpo-save.
let s:save_cpoptions = &cpoptions
set cpoptions&vim
" }}}

function! surround#add(mode, count) "{{{

  let l:surround = input('Input the surround (2 chars): ')
  if l:surround == '' | let l:surround = '()' | endif
  let l:open = strcharpart(l:surround, 0, 1)
  let l:close = strchars(l:surround) > 1
    \ ? strcharpart(l:surround, 1, 1)
    \ : l:open

  function! s:doit(lhsOp, rhsOp) closure "{{{
    call cursor(line("'>"), col("'>"))
    let l:endColOld = col('$')
    execute 'normal! `<' . a:count . a:lhsOp . l:open
    call cursor(line("'>"), col("'>"))
    let l:endColNew = col('$')
    let l:offset = l:endColNew - l:endColOld
    call cursor(line("'>"), col("'>") + l:offset)
    execute 'normal!' a:count . a:rhsOp . l:close
  endfunction "}}}

  if a:mode ==# 'n'
    execute "normal! viw\<Esc>"
  endif

  let l:offset = line("'<") == line("'>") && a:mode !=# 'V'
  \ ? strdisplaywidth(l:open) * a:count
  \ : 0

  if a:mode ==# 'v' || a:mode ==# 'n'
    call s:doit('i', 'a')
  elseif a:mode ==# 'V'
    call s:doit('O', 'o')
  elseif a:mode ==# "\<C-V>"
    execute 'normal! gv' . a:count . 'A' . l:close
    execute 'normal! gv' . a:count . 'I' . l:open
  endif

endfunction "}}}

function! surround#delete(mode, count) "{{{

  function! s:doit(lhsOp, rhsOp) closure "{{{
    call cursor(line("'>"), col("'>"))
    let l:endColOld = col('$')
    execute 'normal! `<' . a:count . a:lhsOp
    call cursor(line("'>"), col("'>"))
    let l:endColNew = col('$')
    let l:offset = l:endColNew - l:endColOld
    call cursor(line("'>"), col("'>") + l:offset)
    " When cursor is not at EOL.
    if match(getline('.'), '\%' . col('.') . 'c.$') == -1
      execute 'normal! l' . a:count . a:rhsOp
    endif
  endfunction "}}}

  if a:mode ==# 'n'
    execute "normal! viw\<Esc>"
  endif

  if a:mode ==# 'v' || a:mode ==# 'n'
    call s:doit('X', 'x')
  " elseif a:mode ==# 'V'
    " call s:doit(...)
  " elseif a:mode ==# "\<C-V>"
    " execute 'normal! gv' . ...
    " execute 'normal! gv' . ...
  endif

endfunction "}}}

" Restore 'cpoptions' setting {{{
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
" }}}
