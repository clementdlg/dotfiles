" Terminal Wrapper
" Terminal Wrapper provides integration of CLI based tools like FZF and Delta.
" This approach wants prevents from using external vimscript repositories (Vim plugins) because they are slow
" and old and bloated. Moreover, it prevents from having to deal with a third party plugin manager.

" let job = job_start('echo Hello, World!', {'out_cb': 'Hstdout' })
" 
" function! Hstdout(channel, msg)
" 	echo "their is output" 
" endfunction

function! HandleExit(channel, msg)
	call feedkeys('gf', 'n') " go to file
endfunction

function! BuffCleaner()
	let bufnum = bufnr('\!fzf')
	if bufnum != -1
		execute 'bdelete ' . bufnum
	endif
endfunction

function! FzfWrapper()
	call BuffCleaner()
	let job = term_start('fzf', {'curwin': v:true, 'exit_cb': 'HandleExit'})
endfunction

nnoremap <silent><Leader>o			:call FzfWrapper()<CR>
