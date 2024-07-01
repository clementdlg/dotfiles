"STATUS LINE
"-----------
set laststatus=2                                " Always display the status line
set statusline=%#Mode#\ %{CustomModes()}\       " Mode names
set statusline+=%#Git#%{Git()}                  " git integration
set statusline+=%#Path#\ %F\                    " Full file path
set statusline+=%=%#File#\ %{&filetype}\      " Filetype
set statusline+=%#Cursor1#\ %l:%c\            " Line and column numbers

" static status colors
highlight Git   guifg=#a6aed3   guibg=#1c223a
highlight Path  guifg=#dee2f5   guibg=#3b4261
highlight File  guifg=#a6aed3   guibg=#1c223a

" mode names and dynamic color
function! CustomModes()
    let currentMode = mode()
    let hlMode   = "highlight Mode    gui=bold cterm=bold guifg=black guibg="
    let hlCursor = "highlight Cursor1 gui=bold cterm=bold guifg=black guibg="
    " possible modes
    let modes = ['n', 'i', 'R', 'V', 'v', "\<C-v>", 'c', 't']
    " colors to apply
    let colors = ['#7aa2f7', '#9ece6a', '#f7768e', '#bb9af7', '#bb9af7',  '#bb9af7', '#e0ac60', '#1abc9c']
    " name of the mode
    let returnVal = ['Normal', 'Insert', 'Replace', 'V-Line', 'Visual',  'V-BLock', 'Command', 'Terminal']
    
    for i in range(0, 7)
        if currentMode ==# modes[i]
            execute hlMode . colors[i]
            execute hlCursor . colors[i]
            return returnVal[i]
        endif
    endfor
endfunction

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
        return ' git:' . strpart(head[0], 16) . ' '
    endif 
endfunction

