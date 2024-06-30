" add the buffers to the quickfix list
function! BufferList()
    call setqflist([])
    let qf_list = []
    let sum = 0

    for buf in getbufinfo({'buflisted' : 1})
        "removing Netrw and the Vim manual
        if stridx(buf['name'], 'NetrwTreeListing') == -1 
        \&& stridx(buf['name'], '/usr/share/vim') == -1 
        "\&& buf['name'] !=  '' 
            call add(qf_list, {'bufnr' : buf['bufnr'], 'lnum' : buf['lnum']})
            let sum+=1
        endif
    endfor
    call setqflist(qf_list)
    return sum
endfunction

"display the quickfix list loaded with buffers
function OpenBuffList()
    let sum = BufferList()
    execute 'copen ' . sum 
    set norelativenumber
endfunction

autocmd FileType qf nnoremap <silent> <Enter> <Enter>:cclose<CR>
