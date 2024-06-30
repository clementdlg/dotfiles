" OPTIONS
"--------
"basics
set nocompatible			        " Vi compatibility
set ignorecase                      " Ignore case search
set incsearch                       " Incremental search
set cursorline				        " Highlight current line
set scrolloff=10			        " Keep cursor centered
set clipboard=unnamedplus   		" Use system clipboard
set hidden				            " Switch between buffers
set mouse=a				            " Mouse support
set backspace=indent,eol,start 		" Make backspace more powerful
set noshowmode                      " Do not show mode
set path+=**

" display
set number				            " Line numbers
set relativenumber			        " Relative line number
set wildmenu				        " List completion for commands
set showcmd				            " Display command keystrokes
set wrap                            " Wrap lines that are too long
set linebreak                       " Wrap lines without cutting words
set signcolumn=yes                  " Add a column before line number

" graphics
syntax on                           " Syntax highlighting
set termguicolors			        " 24bit color support
set background=dark                 " Black background
set lazyredraw				        " Do not redraw screen everytime
                                    " Setting up theme with fallback
try                                 " Try to apply foreign theme
    colorscheme tokyonight
catch
   colorscheme sorbet               " Fallback on builtin theme
endtry

highlight CursorLineNr guifg=#ff9e64 " color of the current line number

" file specific
set autoread				        " Read file changes (outside of vim)
set noswapfile                      " Disable swap file
filetype on                         " Detect filetype
filetype indent on                  " Base indentation filetype
filetype plugin on                  " Filetype specific operation
set encoding=utf-8                  " Global encoding
set fileencoding=utf-8              " Local encoding
set formatoptions+=ro               " Add comment header auto

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
let g:netrw_banner = 0              " Remove banner
let g:netrw_liststyle = 3           " File view
let g:netrw_browse_split = 4        " Open file in previous window
let g:netrw_winsize = 25            " Width of netrw
let g:netrw_preview = 1             " Split vertically

