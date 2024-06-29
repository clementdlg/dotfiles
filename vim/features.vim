" add the buffers to the quickfix list
function! BufferList()
    call setqflist([])
    let buffer_list = getbufinfo()
    let qf_list = []
    let sum = 0

    for buf in buffer_list
        "removing Netrw and the Vim manual
        if stridx(buf['name'], 'NetrwTreeListing') == -1 
        \&& stridx(buf['name'], '/usr/share/vim') == -1 
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
    set laststatus=0
endfunction

autocmd FileType qf nnoremap <Enter> <Enter>:cclose<CR>
