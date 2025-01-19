"REMAPS
"------
" leader key
let mapleader = " "

" exit of search
nnoremap <silent> <Esc>         :nohlsearch<CR>
" source config file
nnoremap <silent> <leader>rc    :source %<CR>
" toggle relative number
"nnoremap <silent> <leader>rn    :set relativenumber!<CR>
" toggle Netrw
nnoremap <silent> <leader>e     :Lexplore<CR>
" terminal mode
"nnoremap <silent> <leader>t     :belowright terminal ++rows=15<CR>
" search projectwide

" buffer navigation
nnoremap <silent> <leader>n    :bnext<CR>
nnoremap <silent> <leader>p    :bprevious<CR>
nnoremap <silent> <leader>bd    :bdelete<CR>
nnoremap <silent> <leader>bl     :call BufferList()<CR>
nnoremap <Leader>l             :buffer 


" new buffer
"nnoremap <silent> <leader>n     :enew<CR>
" next buffer in a new split
"nnoremap <silent> <leader>vs    :belowright vsplit \| bnext<CR>
"nnoremap <silent> <leader>sp    :belowright split \| bnext<CR>

" window navigation
" nnoremap <silent> <leader>h     :wincmd h<CR>
" nnoremap <silent> <leader>j     :wincmd j<CR>
" nnoremap <silent> <leader>k     :wincmd k<CR>
" nnoremap <silent> <leader>l     :wincmd l<CR>

" quickfix panel navigation
nnoremap <silent> J             :cnext<CR>
nnoremap <silent> K             :cprev<CR>
nnoremap <silent> <leader>co    :copen<CR>
nnoremap <silent> <leader>cc    :cclose<CR>

" resize window
" nnoremap <silent> <leader>=     :vertical resize +5<CR>
" nnoremap <silent> <leader>-     :vertical resize -5<CR>

" center screen on half page up/down
nnoremap <C-u>                  <C-u>zz
nnoremap <C-d>                  <C-d>zz

" yank to system clipboard
nnoremap <leader>y              "+y
nnoremap <leader>Y              "+Y      
vnoremap <leader>y              "+y

" scripting
nnoremap <leader>x              :!chmod +x %
