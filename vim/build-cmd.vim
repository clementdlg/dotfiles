" Build Command
" The Build Command is a command that the developper has to type everytime they want to test their code(eg: make run, ./script ...). 
" The build_cmd variable is global and holds this command. This variable can be set via a prompt using the SetBuildCmd(). 
" The RunBuildCmd() function executes the build command inside a vim interactive terminal. The build command is peristant though runs of vim because the command is stored into a register and loaded at startup using LoadBuildCmd().

function! SetBuildCmd()
    let g:build_cmd = input('Set build cmd: ')
	let @b = g:build_cmd
endfunction

function! RunBuildCmd()
	if !exists('g:build_cmd') || empty(g:build_cmd)
		echo "No build cmd set. Use :SetBuildCmd"
		return
	endif
	belowright terminal
	call feedkeys(g:build_cmd . "\<CR>", 't')
endfunction

" load at startup
function! LoadBuildCmd()
	if !empty(@b)
		let g:build_cmd = @b
	endif
endfunction

autocmd VimEnter * call LoadBuildCmd()
