"STATUS LINE
"-----------
" static status colors
set laststatus=2                                " Always display the status line
highlight Path   guifg=#c0caf5   guibg=#39415D ctermbg=60 ctermfg=15
highlight Git    guifg=#a6aed3   guibg=#292d45 ctermbg=242 ctermfg=15
highlight File   guifg=#a7aed3   guibg=#292d45 ctermbg=242 ctermfg=15

let g:mode_colors = {'n': '#7aa2f7', 'i': '#9ece6a', 'R': '#f7768e', 'V': '#bb9af7', 'v': '#bb9af7', "\<C-v>": '#bb9af7', 'c': '#e0ac60', 't': '#1abc9c'}

let g:mode_colors_cterm = {'n': '111', 'i': '156', 'R': '167', 'V': '141', 'v': '141', "\<C-v>": '141', 'c': '215', 't': '72'}

let g:mode_labels = {'n': 'Normal', 'i': 'Insert', 'R': 'Replace', 'V': 'V-Line', 'v': 'Visual', "\<C-v>": 'V-Block', 'c': 'Command', 't': 'Terminal'}

function! ColorModes()
    let currentMode = mode()

    let gui_color   = get(g:mode_colors, currentMode, '#ffffff')
    let cterm_color = get(g:mode_colors_cterm, currentMode, '255')

    let hlMode   = 'highlight Mode    gui=bold guifg=black guibg=' . gui_color . ' cterm=bold ctermfg=16 ctermbg=' . cterm_color
    let hlCursor = 'highlight Cursor1 gui=bold guifg=black guibg=' . gui_color . ' cterm=bold ctermfg=16 ctermbg=' . cterm_color

    execute hlMode
    execute hlCursor
endfunction

" display verbose mode
" called in FullStatusline()
function! SetMode()
	call ColorModes()
    return get(g:mode_labels, mode(), 'Unknown')
endfunction

set statusline=%#Mode#\ %{SetMode()}\       " Mode names
set statusline+=%#Path#\ %F\                    " Full file path
set statusline+=%=%#Git#%{Git()}                  " git integration
set statusline+=%#File#\ [%{&filetype}]\      " Filetype
set statusline+=%#Cursor1#\ %l:%c\            " Line and column numbers

" Git branch display
" .git/HEAD is read to retrieve the branch name
function! Git()
    let head = '.git/HEAD'
    " check if in a git repo
    if !filereadable(head)
        return ''
    endif
    " HEAD min characters 
    if getfsize(head) < 16 
        return ''
    endif
    " reading HEAD
    let head = readfile(head)
    " parsing HEAD 
    if len(head) > 1 || stridx(head[0], 'ref: refs/heads/') == -1
        return ''
    else
        return ' git:' . strpart(head[0], 16)
    endif 
endfunction
