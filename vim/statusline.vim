"STATUS LINE
"-----------
" static status colors
set laststatus=2                                " Always display the status line
highlight Git    guifg=#a6aed3   guibg=#292d45
highlight Path   guifg=#c0caf5   guibg=#3f4766
highlight File   guifg=#a6aed3   guibg=#292d45

" define the color for the current mode
function! ColorModes()
    let currentMode = mode()
    let hlMode   = "highlight Mode    gui=bold cterm=bold guifg=black guibg="
    let hlCursor = "highlight Cursor1 gui=bold cterm=bold guifg=black guibg="
    " possible modes
    let modes = ['n', 'i', 'R', 'V', 'v', "\<C-v>", 'c', 't']
    " colors to apply
    let colors = ['#7aa2f7', '#9ece6a', '#f7768e', '#bb9af7', '#bb9af7',  '#bb9af7', '#e0ac60', '#1abc9c']
    
    for i in range(0, 7)
        if currentMode ==# modes[i]
            execute hlMode . colors[i]
            execute hlCursor . colors[i]
            return i
        endif
    endfor
endfunction

" display verbose mode
" called in FullStatusline()
function! VerboseMode()
    let returnVal = ['Normal', 'Insert', 'Replace', 'V-Line', 'Visual',  'V-Block', 'Command', 'Terminal']
    return returnVal[ColorModes()]
endfunction

" display concise mode
" called in SmallStatusline()
function! ConciseMode()
    call ColorModes()
    return toupper(mode())
endfunction

function! FullStatusline()
    set statusline=%#Mode#\ %{VerboseMode()}\       " Mode names
    set statusline+=%#Path#\ %F\                    " Full file path
    set statusline+=%=%#Git#%{Git()}                  " git integration
    set statusline+=%#File#\ [%{&filetype}]\      " Filetype
    set statusline+=%#Cursor1#\ %l:%c\            " Line and column numbers
endfunction

function! SmallStatusline()
    set statusline=%#Mode#\ %{ConciseMode()}\       " Mode names
    set statusline+=%#Path#\ %F\                    " Full file path
    set statusline+=%=%#Cursor1#\ %l:%c\            " Line and column numbers
endfunction

call FullStatusline()

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

function! StatuslineSize()
    let wins = getwininfo()
    let min_width = 9999

    for win in wins
        if win.width < min_width
            let min_width = win.width
        endif
    endfor

    if min_width <= 75
        call SmallStatusline()
    else
        call FullStatusline()
    endif
endfunction

