"AUTOCOMMADS
"-----------
" toggle cursorline when entering/leaving insert mode
autocmd InsertEnter,InsertLeave * set cursorline!
" exit of quickfix on enter
autocmd FileType qf nnoremap <silent> <Enter> <Enter>:cclose<CR>
" dynamically resize the status line
autocmd WinResized * call StatuslineSize()

