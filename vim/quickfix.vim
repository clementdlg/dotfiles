" add the buffers from :ls to the quickfix list
function! BufferList()
    call setqflist([])
    let qf_list = [] " list of the buffers
    let sum = 0      " nbr of buffers

    for buf in getbufinfo({'buflisted' : 1})
        "removing Netrw and the Vim manual
        if stridx(buf['name'], 'NetrwTreeListing') == -1 
        \&& stridx(buf['name'], '/usr/share/vim') == -1 
            " adding the buffer to the list       
            call add(qf_list, {'bufnr' : buf['bufnr'], 'lnum' : buf['lnum']})
            let sum+=1
        endif
    endfor
    " set the QF list to the listed buffers
    call setqflist(qf_list)
    return sum
endfunction

"display the quickfix list loaded with buffers
function OpenBuffList()
    let sum = BufferList()
    execute 'copen ' . sum 
    set norelativenumber
endfunction

" find a pattern through all the codebase
function FindAll(pattern)
    execute "vimgrep /" . a:pattern . "/ **/*." . &filetype
    copen
endfunction

