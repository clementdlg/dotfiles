"REMAPS
"------
" leader key
let mapleader = " "

" toggle Netrw
nnoremap <silent> <leader>e     :Lexplore<CR>
" buffer navigation
nnoremap <silent> <leader>n    :bnext<CR>
nnoremap <silent> <leader>p    :bprevious<CR>
nnoremap <silent> <leader>bd    :bdelete<CR>
nnoremap <Leader>b             :buffer 
nnoremap <Leader>f             :find 

" center screen on half page up/down
nnoremap <C-u>                  <C-u>zz
nnoremap <C-d>                  <C-d>zz
nnoremap n						nzz
nnoremap N						Nzz
nnoremap {						{zz
nnoremap }						}zz

" scripting
nnoremap <silent><leader>rc    		:source %<CR>
nnoremap <silent><leader>x			:!chmod +x %
nnoremap <silent><Leader>br			:call RunBuildCmd()<CR>
nnoremap <silent><Leader>bs			:call SetBuildCmd()<CR>

" toggle cursorline when entering/leaving insert mode
autocmd InsertEnter,InsertLeave * set cursorline!

