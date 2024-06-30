" OPTIONS
"--------
"basics
set nocompatible			        " vi compatibility
set ignorecase                      " ignore case search
set incsearch                       " Incremental search
set cursorline				        " highlight current line
set scrolloff=10			        " keep cursor centered
set clipboard=unnamedplus   		" use system clipboard
set hidden				            " switch between buffers
set mouse=a				            " mouse support
set backspace=indent,eol,start 		" Make backspace more powerful
set noshowmode                      " do not show mode
set path+=**

" display
set number				            " line numbers
set relativenumber			        " relative line number
set wildmenu				        " list completion for commands
set showcmd				            " display command keystrokes
set wrap                            " wrap lines that are too long
set linebreak                       " wrap lines without cutting words
set signcolumn=yes                  " add a column before line number

" graphics
syntax on                           " syntax highlighting
set termguicolors			        " 24bit color support
set background=dark                 " black background
set lazyredraw				        " do not redraw screen everytime
                                    " setting up theme with fallback
try
    colorscheme tokyonight
catch
   colorscheme sorbet
endtry

highlight CursorLineNr guifg=#ff9e64 " color of the current line number

" file specific
set autoread				        " read file changes (outside of vim)
set noswapfile                      " disable swap file
filetype on                         " detect filetype
filetype indent on                  " base indentation filetype
filetype plugin on                  " filetype specific operation
set encoding=utf-8                  " global encoding
set fileencoding=utf-8              " local encoding
set formatoptions+=ro               " add comment header auto

" indent settings
set expandtab               		" Convert tabs to spaces
set tabstop=4               		" Number of spaces tabs count for
set shiftwidth=4            		" Number of spaces to use for autoindent
set softtabstop=4           		" Number of spaces for tab key
set autoindent              		" Copy indent from current line when starting a new line
set smartindent             		" Smart autoindenting for C-like programs

" persistant undo
set undofile                        " Enable persistent undo
set undodir=~/.vim/undo.d           " Set undo directory
" netrw
let g:netrw_banner = 0          "Remove banner
let g:netrw_liststyle = 3       "File view
let g:netrw_browse_split = 4    "Open file in previous window
let g:netrw_winsize = 25        "Width of netrw
let g:netrw_preview = 1         "Split vertically

