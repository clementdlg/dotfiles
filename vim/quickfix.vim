" add the buffers from :ls to the quickfix list
function! BufferList()
    let i = 1
    let n = bufnr("%") " current buffer
    for buf in getbufinfo({'buflisted' : 1})

        "removing Netrw and the Vim manual
        if stridx(buf['name'], 'NetrwTreeListing') == 0 
        \|| stridx(buf['name'], '/usr/share/vim') == 0 
            continue
        endif

        if n == buf['bufnr']
            let box = "x"
        else
            let box = " "
        endif

        " printing the buffer i
        echo printf("[%s] %d - %s", box, i, fnamemodify(buf['name'], ':t'))
        let i = i + 1

    endfor
endfunction

