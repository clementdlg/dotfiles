"ENVIRONMENT
"-----------

" check how many colors can support the terminal

function! MainEnv() 
    " no Vi-mode
    set nocompatible

    if $COLORTERM == 'truecolor'
        call TruecolorMode()

    elseif &t_Co == 256
        call TerminalMode()

    elseif &t_Co == 8
        call ConsoleMode()
    endif
endfunction

function! TruecolorMode()
    set termguicolors   " enable 24bit color support
    set mouse=a         " enable mouse support
    set relativenumber  " relative line numbers

    if ThemeExists("sorbet-night")
        colorscheme sorbet-night
    elseif ThemeExists("sorbet")
        colorscheme sorbet
    else
        colorscheme slate
    endif

endfunction

function! TerminalMode()
    set notermguicolors " disable 24bit color support
    set mouse=a         " enable mouse support
    set relativenumber  " relative line numbers

    if ThemeExists("sorbet-night")
        colorscheme sorbet-night
    else
        colorscheme slate
    endif

endfunction

function! ConsoleMode()
    set notermguicolors " disable 24bit color support
    set mouse=          " disable mouse support
    set norelativenumber " no relative line numbers
    colorscheme elflord
endfunction

function! ThemeExists(theme)
  let theme_path = globpath(&runtimepath, 'colors/' . a:theme . '.vim')

  if theme_path == ''
    return v:false
  endif
  return v:true
endfunction

call MainEnv()
