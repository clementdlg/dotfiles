"STATUS LINE
"-----------
set laststatus=2                                    " Always display the status line
set statusline=%#Mode#\ %{CustomModes()}\       " Mode (unabbreviated)
"set statusline+=%#Git#%{Git()}
set statusline+=%#Path#\ %F\                        " Full file path
set statusline+=%=%#File#\ [%{&filetype}\]\         " Filetype
set statusline+=%#Cursor1#\ \ %l:%c\ \              " Line and column numbers

" status colors
highlight Mode gui=bold cterm=bold guifg=black guibg=#7aa2f7
highlight Git guifg=#d0d0d0 guibg=#1c223a
highlight Path guifg=white guibg=#3b4261
highlight File guifg=#d0d0d0 guibg=#1c223a
highlight Cursor1 gui=bold cterm=bold guifg=black guibg=#7aa2f7

" display modes unabreviated and change color
function! CustomModes()
    let l:mode = mode()

    if l:mode == 'n'
        highlight Mode gui=bold cterm=bold guifg=black guibg=#7aa2f7
        highlight Cursor1 gui=bold cterm=bold guifg=black guibg=#7aa2f7
        return 'Normal'

    elseif l:mode == 'i' 
        highlight Mode gui=bold cterm=bold guifg=black guibg=#9ece6a
        highlight Cursor1 gui=bold cterm=bold guifg=black guibg=#9ece6a
        return 'Insert'

    elseif l:mode == 'R' 
        highlight Mode gui=bold cterm=bold guifg=black guibg=#f7768e
        highlight Cursor1 gui=bold cterm=bold guifg=black guibg=#f7768e
        return 'Replace'

    elseif l:mode ==# 'V' 
        highlight Mode gui=bold cterm=bold guifg=black guibg=#bb9af7
        highlight Cursor1 gui=bold cterm=bold guifg=black guibg=#bb9af7
        return 'V-Line'

    elseif l:mode ==# 'v' 
        highlight Mode gui=bold cterm=bold guifg=black guibg=#bb9af7
        highlight Cursor1 gui=bold cterm=bold guifg=black guibg=#bb9af7
        return 'Visual'

    elseif l:mode == "\<C-v>" 
        highlight Mode gui=bold cterm=bold guifg=black guibg=#bb9af7
        highlight Cursor1 gui=bold cterm=bold guifg=black guibg=#bb9af7
        return 'V-Block'

    elseif l:mode == 'c' 
        highlight Mode gui=bold cterm=bold guifg=black guibg=#e0ac60
        highlight Cursor1 gui=bold cterm=bold guifg=black guibg=#e0ac60
        return 'Command'

    elseif l:mode == 't' 
        highlight Mode gui=bold cterm=bold guifg=black guibg=#1abc9c
        highlight Cursor1 gui=bold cterm=bold guifg=black guibg=#1abc9c
        return 'Terminal'

    else
        highlight Mode gui=bold cterm=bold guifg=black guibg=#7aa2f7
        highlight Cursor1 gui=bold cterm=bold guifg=black guibg=#7aa2f7
        return toupper(mode())
    endif
endfunction

"function! Git()
"    let $PATH = \"/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
"
"    if !executable('git')
"        return ''
"    endif
"
"    let command = \"git branch --show-current 2>/dev/null"
"    let branch = system(command)
"
"    if v:shell_error != 0 || empty(branch)
"        return ''
"    else
"        let branch = trim(branch)
"        let branch = substitute(branch, '[^a-zA-Z0-9]', '', 'g')
"        return ' git:' . branch . ' '
"    endif
"endfunction
