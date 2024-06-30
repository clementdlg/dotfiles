"REMAPS
"------
" leader key
let mapleader = " "

" exit of search
nnoremap <silent> <Esc>         :nohlsearch<CR>
" source config file
nnoremap <silent> <leader>rc    :source %<CR>
" toggle relative number
nnoremap <silent> <leader>rn    :set relativenumber!<CR>
" toggle Netrw
nnoremap <silent> <leader>f     :Lexplore<CR>
" terminal mode
nnoremap <silent> <leader>t     :belowright terminal ++rows=15<CR>
" search projectwide
nnoremap <silent> <leader>vg    :echo ":call FindAll('')"<CR>:call FindAll('')<left><left>

" buffer navigation
nnoremap <silent> <leader>bn    :bnext<CR>
nnoremap <silent> <leader>bp    :bprevious<CR>
nnoremap <silent> <leader>bd    :bdelete<CR>
nnoremap <silent> <leader>bl    :call OpenBuffList()<CR>
" new buffer
nnoremap <silent> <leader>n     :enew<CR>
" next buffer in a new split
nnoremap <silent> <leader>vs    :belowright vsplit \| bnext<CR>
nnoremap <silent> <leader>sp    :belowright split \| bnext<CR>

" window navigation
nnoremap <silent> <leader>h     :wincmd h<CR>
nnoremap <silent> <leader>j     :wincmd j<CR>
nnoremap <silent> <leader>k     :wincmd k<CR>
nnoremap <silent> <leader>l     :wincmd l<CR>

" quickfix panel navigation
nnoremap <silent> <C-j>         :cnext<CR>
nnoremap <silent> <C-k>         :cprev<CR>
nnoremap <silent> <leader>co    :copen<CR>
nnoremap <silent> <leader>cc    :cclose<CR>

