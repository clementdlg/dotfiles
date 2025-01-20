"REMAPS
"------
" leader key
let mapleader = " "

" source config file
nnoremap <silent> <leader>rc    :source %<CR>
" toggle Netrw
nnoremap <silent> <leader>e     :Lexplore<CR>
" buffer navigation
nnoremap <silent> <leader>n    :bnext<CR>
nnoremap <silent> <leader>p    :bprevious<CR>
nnoremap <silent> <leader>bd    :bdelete<CR>
nnoremap <Leader>l             :buffer 

" center screen on half page up/down
nnoremap <C-u>                  <C-u>zz
nnoremap <C-d>                  <C-d>zz

" scripting
nnoremap <leader>x              :!chmod +x %
