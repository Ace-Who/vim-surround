nnoremap <silent> <leader>[] :<C-U>call surround#add(mode(), v:count1)<CR>
xnoremap <silent> <leader>[] :<C-U>call surround#add(visualmode(), v:count1)<CR>
nnoremap <silent> <leader>d[] :<C-U>call surround#delete(mode(), v:count1)<CR>
xnoremap <silent> <leader>d[] :<C-U>call surround#delete(visualmode(), v:count1)<CR>
