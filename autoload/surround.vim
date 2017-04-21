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

  if a:mode ==# 'n'
    execute "normal! viw\<Esc>"
  endif

  if a:mode ==# 'v' || a:mode ==# 'n'
    call s:doit('i' . l:open, 'a' . l:close, a:count)
  elseif a:mode ==# 'V'
    call s:doit('O' . l:open, 'o' . l:close, a:count)
  elseif a:mode ==# "\<C-V>"
    execute 'normal! gv' . a:count . 'A' . l:close
    execute 'normal! gv' . a:count . 'I' . l:open
  endif

endfunction "}}}

function! surround#delete(mode, count) "{{{

  if a:mode ==# 'n'
    execute "normal! viw\<Esc>"
  endif

  if a:mode ==# 'v' || a:mode ==# 'n'
    call s:doit('X', 'x', a:count, 1)
  elseif a:mode ==# 'V'
    execute "'<-" . a:count . ",'<-1d _"
    execute "'>+1d _" a:count
  endif

endfunction "}}}

function! s:doit(lhsOp, rhsOp, count, ...) "{{{
  let l:endLenOld = len(getline("'>"))
  execute 'normal! `<' . a:count . a:lhsOp
  let l:endLenNew = len(getline("'>"))
  let l:offset = l:endLenNew - l:endLenOld
  call cursor(line("'>"), col("'>") + l:offset)

  let l:del = get(a:000, 0, 0)
  if l:del
    " When cursor is not at EOL. Two methods to test this.
    " if match(getline('.'), '\%' . col('.') . 'c.$') == -1
    if strchars(getline('.')[col('.') - 1:]) > 1
      execute 'normal! l' . a:count . a:rhsOp
    endif
  else
    execute 'normal!' a:count . a:rhsOp
  endif
endfunction "}}}

" Restore 'cpoptions' setting {{{
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
" }}}
