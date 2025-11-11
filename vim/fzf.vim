" FZF Wrapper
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
