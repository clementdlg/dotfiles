"REMAPS
"------
" leader key
let mapleader = " "

" autocomplete symbols
inoremap '    ''<Left>
inoremap (    ()<Left>
inoremap {    {}<Left>

" misc remaps
nnoremap <silent> <Esc>         :nohlsearch<CR>
nnoremap <silent> <leader>rc    :source %<CR>
nnoremap <silent> <leader>rn    :set relativenumber!<CR>

"BUFFER AND WINDOW REMAPS
" buffer navigation
nnoremap <silent> <leader>bn     :bnext<CR>
nnoremap <silent> <leader>bp     :bprevious<CR>
nnoremap <silent> <leader>bd     :bdelete<CR>
nnoremap <silent> <leader>bl     :call OpenBuffList()<CR>

" window navigation
nnoremap <silent> <leader>h    :wincmd h<CR>
nnoremap <silent> <leader>j    :wincmd j<CR>
nnoremap <silent> <leader>k    :wincmd k<CR>
nnoremap <silent> <leader>l    :wincmd l<CR>

" new buffer
nnoremap <silent> <leader>n      :enew<CR>
" next buffer in a new split
nnoremap <silent> <leader>vs    :belowright vsplit \| bnext<CR>
nnoremap <silent> <leader>sp    :belowright split \| bnext<CR>
" netrw
nnoremap <silent> <leader>f    :Lexplore<CR>
" terminal mode
nnoremap <leader>t :belowright terminal ++rows=12<CR>

