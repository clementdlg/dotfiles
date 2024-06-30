"AUTOCOMMADS
"-----------
autocmd InsertEnter,InsertLeave * set cursorline!
autocmd FileType qf nnoremap <silent> <Enter> <Enter>:cclose \| set laststatus=2<CR>

