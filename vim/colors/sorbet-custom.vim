" Name:         sorbet-custom
" Description:  A shallow grave, a monument to the ruined age.
" Author:       Maxence Weynans <neutaaaaan@gmail.com>
" Maintainer:   Maxence Weynans <neutaaaaan@gmail.com>
" Website:      https://github.com/vim/colorschemes
" License:      Vim License (see `:help license`)`
" Last Updated: Wed 15 Mar 2023 05:40:19 PM CET

" Generated by Colortemplate v2.2.0

set background=dark

hi clear
let g:colors_name = 'sorbet-custom'

let s:t_Co = exists('&t_Co') && !has('gui_running') ? (&t_Co ?? 0) : -1

hi! link Terminal Normal
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link MessageWindow Pmenu
hi! link PopupNotification Todo
hi! link Boolean Constant
hi! link Character Constant
hi! link Conditional Statement
hi! link Define PreProc
hi! link Debug Special
hi! link Delimiter Special
hi! link ErrorMsg Error
hi! link Exception Statement
hi! link Float Constant
hi! link Function Identifier
hi! link Include PreProc
hi! link Keyword Statement
hi! link Label Statement
hi! link Macro PreProc
hi! link Number Constant
hi! link Operator Statement
hi! link PreCondit PreProc
hi! link Repeat Statement
hi! link SpecialChar Special
hi! link SpecialComment Special
hi! link StorageClass Type
hi! link Structure Type
hi! link Tag Special
hi! link Typedef Type
hi! link lCursor Cursor
hi! link debugPC CursorLine

if (has('termguicolors') && &termguicolors) || has('gui_running')
  let g:terminal_ansi_colors = ['#000000', '#FE9F64', '#72DACB', '#9ECE6A', '#9D7CD8', '#af87d7', '#2AC3DE', '#C1CAF4', '#707070', '#ff5f5f', '#87ff5f', '#ffd75f', '#87d7ff', '#d787ff', '#5fd7d7', '#ffffff']
endif
hi Normal guifg=#C1CAF4 guibg=#222436 gui=NONE cterm=NONE
hi ColorColumn guifg=NONE guibg=#262831 gui=NONE cterm=NONE
hi Conceal guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi CurSearch guifg=#ff5fff guibg=#000000 gui=reverse cterm=reverse
hi Cursor guifg=NONE guibg=NONE gui=reverse ctermfg=NONE ctermbg=NONE cterm=reverse
hi CursorColumn guifg=NONE guibg=#363841 gui=NONE cterm=NONE
hi CursorLine guifg=NONE guibg=#363841 gui=NONE cterm=NONE
hi CursorLineNr guifg=#ff9e64 cterm=bold ctermfg=15
hi DiffAdd guifg=#00af5f guibg=#000000 gui=reverse cterm=reverse
hi DiffChange guifg=#87afff guibg=#000000 gui=reverse cterm=reverse
hi DiffDelete guifg=#d7005f guibg=#000000 gui=reverse cterm=reverse
hi DiffText guifg=#ff87ff guibg=#000000 gui=reverse cterm=reverse
hi Directory guifg=#C1CAF4 guibg=NONE gui=NONE cterm=NONE
hi EndOfBuffer guifg=#5f5f87 guibg=NONE gui=NONE cterm=NONE
hi FoldColumn guifg=#8787af guibg=NONE gui=NONE cterm=NONE
hi Folded guifg=#5f5f87 guibg=#161821 gui=NONE cterm=NONE
hi IncSearch guifg=#ffaf00 guibg=#000000 gui=reverse cterm=reverse
hi LineNr guifg=#5f5f87 guibg=NONE gui=NONE cterm=NONE
hi MatchParen guifg=#ff00af guibg=NONE gui=bold cterm=bold
hi ModeMsg guifg=#C1CAF4 guibg=NONE gui=bold cterm=bold
hi MoreMsg guifg=#C1CAF4 guibg=NONE gui=NONE cterm=NONE
hi NonText guifg=#707070 guibg=NONE gui=NONE cterm=NONE
hi Pmenu guifg=#000000 guibg=#a6a8b1 gui=NONE cterm=NONE
hi PmenuExtra guifg=#000000 guibg=#a6a8b1 gui=NONE cterm=NONE
hi PmenuKind guifg=#000000 guibg=#a6a8b1 gui=bold cterm=bold
hi PmenuSbar guifg=#707070 guibg=#5f5f87 gui=NONE cterm=NONE
hi PmenuSel guifg=#000000 guibg=#d7d7ff gui=NONE cterm=NONE
hi PmenuExtraSel guifg=#000000 guibg=#d7d7ff gui=NONE cterm=NONE
hi PmenuKindSel guifg=#000000 guibg=#d7d7ff gui=bold cterm=bold
hi PmenuThumb guifg=#C1CAF4 guibg=#d7d7ff gui=NONE cterm=NONE
hi Question guifg=#C1CAF4 guibg=NONE gui=NONE cterm=NONE
hi QuickFixLine guifg=#ff5fff guibg=#000000 gui=reverse cterm=reverse
hi Search guifg=#00afff guibg=#000000 gui=reverse cterm=reverse
hi SignColumn guifg=#C1CAF4 guibg=NONE gui=NONE cterm=NONE
hi SpecialKey guifg=#5f5f87 guibg=NONE gui=bold cterm=bold
hi SpellBad guifg=#FE9F64 guibg=NONE guisp=#FE9F64 gui=undercurl cterm=underline
hi SpellCap guifg=#9D7CD8 guibg=NONE guisp=#9D7CD8 gui=undercurl cterm=underline
hi SpellLocal guifg=#af87d7 guibg=NONE guisp=#af87d7 gui=undercurl cterm=underline
hi SpellRare guifg=#2AC3DE guibg=NONE guisp=#2AC3DE gui=undercurl cterm=underline
hi StatusLine guifg=#000000 guibg=#d7d7ff gui=bold cterm=bold
hi StatusLineNC guifg=#8787af guibg=#000000 gui=reverse cterm=reverse
hi TabLine guifg=#8787af guibg=#000000 gui=reverse cterm=reverse
hi TabLineFill guifg=#C1CAF4 guibg=NONE gui=NONE cterm=NONE
hi TabLineSel guifg=#000000 guibg=#d7d7ff gui=bold cterm=bold
hi Title guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi VertSplit guifg=#5f5f87 guibg=NONE gui=NONE cterm=NONE
hi Visual guifg=#ffaf00 guibg=#000000 gui=reverse cterm=reverse
hi VisualNOS guifg=NONE guibg=#363841 gui=NONE cterm=NONE
hi WarningMsg guifg=#C1CAF4 guibg=NONE gui=NONE cterm=NONE
hi WildMenu guifg=#d7d7ff guibg=#161821 gui=bold cterm=bold
hi Comment guifg=#5F5F87 guibg=NONE gui=NONE cterm=NONE
hi Constant guifg=#FE9F64 guibg=NONE gui=NONE cterm=NONE
hi Error guifg=#ff5f5f guibg=#000000 gui=bold,reverse cterm=bold,reverse
hi Identifier guifg=#72DACB guibg=NONE gui=NONE cterm=NONE
hi Ignore guifg=#C1CAF4 guibg=NONE gui=NONE cterm=NONE
hi PreProc guifg=#9D7CD8 guibg=NONE gui=NONE cterm=NONE
hi Special guifg=#2AC3DE guibg=NONE gui=NONE cterm=NONE
hi Statement guifg=#9D7CD8 guibg=NONE gui=NONE cterm=NONE
hi String guifg=#9ECE6A guibg=NONE gui=NONE cterm=NONE
hi Todo guifg=#5fd7af guibg=NONE gui=bold,reverse cterm=bold,reverse
hi Type guifg=#9D7CD8 guibg=NONE gui=NONE cterm=NONE
hi Underlined guifg=#C1CAF4 guibg=NONE gui=underline cterm=underline
hi CursorIM guifg=#000000 guibg=#afff00 gui=NONE cterm=NONE
hi ToolbarLine guifg=NONE guibg=#000000 gui=NONE cterm=NONE
hi ToolbarButton guifg=#C1CAF4 guibg=#000000 gui=bold cterm=bold
hi DiffRemoved guifg=#FE9F64 guibg=NONE gui=NONE cterm=NONE
hi debugBreakpoint guifg=#8787af guibg=#000000 gui=bold,reverse cterm=bold,reverse

if s:t_Co >= 256
  hi Normal ctermfg=253 ctermbg=234 cterm=NONE
  hi ColorColumn ctermfg=NONE ctermbg=235 cterm=NONE
  hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi CurSearch ctermfg=207 ctermbg=16 cterm=reverse
  hi Cursor ctermfg=NONE ctermbg=NONE cterm=reverse
  hi CursorColumn ctermfg=NONE ctermbg=237 cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=237 cterm=NONE
  hi CursorLineNr ctermfg=189 ctermbg=237 cterm=NONE
  hi DiffAdd ctermfg=35 ctermbg=16 cterm=reverse
  hi DiffChange ctermfg=111 ctermbg=16 cterm=reverse
  hi DiffDelete ctermfg=161 ctermbg=16 cterm=reverse
  hi DiffText ctermfg=213 ctermbg=16 cterm=reverse
  hi Directory ctermfg=253 ctermbg=NONE cterm=NONE
  hi EndOfBuffer ctermfg=60 ctermbg=NONE cterm=NONE
  hi FoldColumn ctermfg=103 ctermbg=NONE cterm=NONE
  hi Folded ctermfg=60 ctermbg=233 cterm=NONE
  hi IncSearch ctermfg=214 ctermbg=16 cterm=reverse
  hi LineNr ctermfg=60 ctermbg=NONE cterm=NONE
  hi MatchParen ctermfg=199 ctermbg=NONE cterm=bold
  hi ModeMsg ctermfg=253 ctermbg=NONE cterm=bold
  hi MoreMsg ctermfg=253 ctermbg=NONE cterm=NONE
  hi NonText ctermfg=242 ctermbg=NONE cterm=NONE
  hi Pmenu ctermfg=16 ctermbg=248 cterm=NONE
  hi PmenuExtra ctermfg=16 ctermbg=248 cterm=NONE
  hi PmenuKind ctermfg=16 ctermbg=248 cterm=bold
  hi PmenuSbar ctermfg=242 ctermbg=60 cterm=NONE
  hi PmenuSel ctermfg=16 ctermbg=189 cterm=NONE
  hi PmenuExtraSel ctermfg=16 ctermbg=189 cterm=NONE
  hi PmenuKindSel ctermfg=16 ctermbg=189 cterm=bold
  hi PmenuThumb ctermfg=253 ctermbg=189 cterm=NONE
  hi Question ctermfg=253 ctermbg=NONE cterm=NONE
  hi QuickFixLine ctermfg=207 ctermbg=16 cterm=reverse
  hi Search ctermfg=39 ctermbg=16 cterm=reverse
  hi SignColumn ctermfg=253 ctermbg=NONE cterm=NONE
  hi SpecialKey ctermfg=60 ctermbg=NONE cterm=bold
  hi SpellBad ctermfg=167 ctermbg=NONE cterm=underline
  hi SpellCap ctermfg=110 ctermbg=NONE cterm=underline
  hi SpellLocal ctermfg=140 ctermbg=NONE cterm=underline
  hi SpellRare ctermfg=73 ctermbg=NONE cterm=underline
  hi StatusLine ctermfg=16 ctermbg=189 cterm=bold
  hi StatusLineNC ctermfg=103 ctermbg=16 cterm=reverse
  hi TabLine ctermfg=103 ctermbg=16 cterm=reverse
  hi TabLineFill ctermfg=253 ctermbg=NONE cterm=NONE
  hi TabLineSel ctermfg=16 ctermbg=189 cterm=bold
  hi Title ctermfg=NONE ctermbg=NONE cterm=NONE
  hi VertSplit ctermfg=60 ctermbg=NONE cterm=NONE
  hi Visual ctermfg=214 ctermbg=16 cterm=reverse
  hi VisualNOS ctermfg=NONE ctermbg=237 cterm=NONE
  hi WarningMsg ctermfg=253 ctermbg=NONE cterm=NONE
  hi WildMenu ctermfg=189 ctermbg=233 cterm=bold
  hi Comment ctermfg=60 ctermbg=NONE cterm=NONE
  hi Constant ctermfg=167 ctermbg=NONE cterm=NONE
  hi Error ctermfg=203 ctermbg=16 cterm=bold,reverse
  hi Identifier ctermfg=113 ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=253 ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=110 ctermbg=NONE cterm=NONE
  hi Special ctermfg=73 ctermbg=NONE cterm=NONE
  hi Statement ctermfg=110 ctermbg=NONE cterm=NONE
  hi String ctermfg=179 ctermbg=NONE cterm=NONE
  hi Todo ctermfg=79 ctermbg=NONE cterm=bold,reverse
  hi Type ctermfg=110 ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=253 ctermbg=NONE cterm=underline
  hi CursorIM ctermfg=16 ctermbg=154 cterm=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=16 cterm=NONE
  hi ToolbarButton ctermfg=253 ctermbg=16 cterm=bold
  hi DiffRemoved ctermfg=167 ctermbg=NONE cterm=NONE
  hi debugBreakpoint ctermfg=103 ctermbg=16 cterm=bold,reverse
  unlet s:t_Co
  finish
endif

if s:t_Co >= 16
  hi CurSearch ctermfg=magenta ctermbg=black cterm=reverse
  hi EndOfBuffer ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi Folded ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi IncSearch ctermfg=yellow ctermbg=black cterm=reverse
  hi LineNr ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi NonText ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi PmenuSbar ctermfg=darkgrey ctermbg=NONE cterm=reverse
  hi Search ctermfg=cyan ctermbg=black cterm=reverse
  hi SpecialKey ctermfg=darkgrey ctermbg=NONE cterm=bold
  hi StatusLineNC ctermfg=darkgrey ctermbg=NONE cterm=reverse
  hi TabLine ctermfg=darkgrey ctermbg=NONE cterm=reverse
  hi VertSplit ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi Normal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ColorColumn ctermfg=NONE ctermbg=NONE cterm=reverse
  hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Cursor ctermfg=NONE ctermbg=NONE cterm=reverse
  hi CursorColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi CursorLineNr ctermfg=NONE ctermbg=NONE cterm=bold
  hi DiffAdd ctermfg=darkgreen ctermbg=black cterm=reverse
  hi DiffChange ctermfg=darkblue ctermbg=black cterm=reverse
  hi DiffDelete ctermfg=darkred ctermbg=black cterm=reverse
  hi DiffText ctermfg=darkmagenta ctermbg=black cterm=reverse
  hi Directory ctermfg=NONE ctermbg=NONE cterm=NONE
  hi FoldColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi MatchParen ctermfg=NONE ctermbg=NONE cterm=bold,underline
  hi ModeMsg ctermfg=NONE ctermbg=NONE cterm=bold
  hi MoreMsg ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Pmenu ctermfg=NONE ctermbg=NONE cterm=reverse
  hi PmenuExtra ctermfg=NONE ctermbg=NONE cterm=reverse
  hi PmenuKind ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  hi PmenuSel ctermfg=NONE ctermbg=NONE cterm=bold
  hi PmenuExtraSel ctermfg=NONE ctermbg=NONE cterm=bold
  hi PmenuKindSel ctermfg=NONE ctermbg=NONE cterm=bold
  hi PmenuThumb ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Question ctermfg=NONE ctermbg=NONE cterm=standout
  hi QuickFixLine ctermfg=darkmagenta ctermbg=black cterm=reverse
  hi SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi SpellBad ctermfg=darkred ctermbg=NONE cterm=underline
  hi SpellCap ctermfg=darkblue ctermbg=NONE cterm=underline
  hi SpellLocal ctermfg=darkmagenta ctermbg=NONE cterm=underline
  hi SpellRare ctermfg=darkcyan ctermbg=NONE cterm=underline
  hi StatusLine ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  hi TabLineFill ctermfg=NONE ctermbg=NONE cterm=NONE
  hi TabLineSel ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  hi Title ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Visual ctermfg=darkyellow ctermbg=black cterm=reverse
  hi VisualNOS ctermfg=NONE ctermbg=NONE cterm=NONE
  hi WarningMsg ctermfg=NONE ctermbg=NONE cterm=standout
  hi WildMenu ctermfg=NONE ctermbg=NONE cterm=bold
  hi Comment ctermfg=darkmagenta ctermbg=NONE cterm=NONE
  hi Constant ctermfg=darkred ctermbg=NONE cterm=NONE
  hi Error ctermfg=darkred ctermbg=black cterm=bold,reverse
  hi Identifier ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=darkblue ctermbg=NONE cterm=NONE
  hi Special ctermfg=darkcyan ctermbg=NONE cterm=NONE
  hi Statement ctermfg=darkblue ctermbg=NONE cterm=NONE
  hi String ctermfg=darkyellow ctermbg=NONE cterm=NONE
  hi Todo ctermfg=darkgreen ctermbg=black cterm=bold,reverse
  hi Type ctermfg=darkblue ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline
  hi CursorIM ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=reverse
  hi ToolbarButton ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  hi DiffRemoved ctermfg=darkred ctermbg=NONE cterm=NONE
  hi debugBreakpoint ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  unlet s:t_Co
  finish
endif

if s:t_Co >= 8
  hi CurSearch ctermfg=darkmagenta ctermbg=black cterm=reverse
  hi EndOfBuffer ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Folded ctermfg=NONE ctermbg=NONE cterm=NONE
  hi IncSearch ctermfg=darkyellow ctermbg=black cterm=reverse
  hi LineNr ctermfg=NONE ctermbg=NONE cterm=NONE
  hi NonText ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PmenuSbar ctermfg=NONE ctermbg=NONE cterm=reverse
  hi Search ctermfg=darkcyan ctermbg=black cterm=reverse
  hi SpecialKey ctermfg=NONE ctermbg=NONE cterm=bold
  hi StatusLineNC ctermfg=NONE ctermbg=NONE cterm=bold,underline
  hi TabLine ctermfg=NONE ctermbg=NONE cterm=bold,underline
  hi VertSplit ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Normal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ColorColumn ctermfg=NONE ctermbg=NONE cterm=reverse
  hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Cursor ctermfg=NONE ctermbg=NONE cterm=reverse
  hi CursorColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi CursorLineNr ctermfg=NONE ctermbg=NONE cterm=bold
  hi DiffAdd ctermfg=darkgreen ctermbg=black cterm=reverse
  hi DiffChange ctermfg=darkblue ctermbg=black cterm=reverse
  hi DiffDelete ctermfg=darkred ctermbg=black cterm=reverse
  hi DiffText ctermfg=darkmagenta ctermbg=black cterm=reverse
  hi Directory ctermfg=NONE ctermbg=NONE cterm=NONE
  hi FoldColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi MatchParen ctermfg=NONE ctermbg=NONE cterm=bold,underline
  hi ModeMsg ctermfg=NONE ctermbg=NONE cterm=bold
  hi MoreMsg ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Pmenu ctermfg=NONE ctermbg=NONE cterm=reverse
  hi PmenuExtra ctermfg=NONE ctermbg=NONE cterm=reverse
  hi PmenuKind ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  hi PmenuSel ctermfg=NONE ctermbg=NONE cterm=bold
  hi PmenuExtraSel ctermfg=NONE ctermbg=NONE cterm=bold
  hi PmenuKindSel ctermfg=NONE ctermbg=NONE cterm=bold
  hi PmenuThumb ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Question ctermfg=NONE ctermbg=NONE cterm=standout
  hi QuickFixLine ctermfg=darkmagenta ctermbg=black cterm=reverse
  hi SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi SpellBad ctermfg=darkred ctermbg=NONE cterm=underline
  hi SpellCap ctermfg=darkblue ctermbg=NONE cterm=underline
  hi SpellLocal ctermfg=darkmagenta ctermbg=NONE cterm=underline
  hi SpellRare ctermfg=darkcyan ctermbg=NONE cterm=underline
  hi StatusLine ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  hi TabLineFill ctermfg=NONE ctermbg=NONE cterm=NONE
  hi TabLineSel ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  hi Title ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Visual ctermfg=darkyellow ctermbg=black cterm=reverse
  hi VisualNOS ctermfg=NONE ctermbg=NONE cterm=NONE
  hi WarningMsg ctermfg=NONE ctermbg=NONE cterm=standout
  hi WildMenu ctermfg=NONE ctermbg=NONE cterm=bold
  hi Comment ctermfg=darkmagenta ctermbg=NONE cterm=NONE
  hi Constant ctermfg=darkred ctermbg=NONE cterm=NONE
  hi Error ctermfg=darkred ctermbg=black cterm=bold,reverse
  hi Identifier ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=darkblue ctermbg=NONE cterm=NONE
  hi Special ctermfg=darkcyan ctermbg=NONE cterm=NONE
  hi Statement ctermfg=darkblue ctermbg=NONE cterm=NONE
  hi String ctermfg=darkyellow ctermbg=NONE cterm=NONE
  hi Todo ctermfg=darkgreen ctermbg=black cterm=bold,reverse
  hi Type ctermfg=darkblue ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline
  hi CursorIM ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=reverse
  hi ToolbarButton ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  hi DiffRemoved ctermfg=darkred ctermbg=NONE cterm=NONE
  hi debugBreakpoint ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  unlet s:t_Co
  finish
endif

if s:t_Co >= 0
  hi Normal term=NONE
  hi ColorColumn term=reverse
  hi Conceal term=NONE
  hi Cursor term=reverse
  hi CursorColumn term=NONE
  hi CursorLine term=underline
  hi CursorLineNr term=bold
  hi DiffAdd term=reverse
  hi DiffChange term=NONE
  hi DiffDelete term=reverse
  hi DiffText term=reverse
  hi Directory term=NONE
  hi EndOfBuffer term=NONE
  hi ErrorMsg term=bold,reverse
  hi FoldColumn term=NONE
  hi Folded term=NONE
  hi IncSearch term=bold,reverse,underline
  hi LineNr term=NONE
  hi MatchParen term=bold,underline
  hi ModeMsg term=bold
  hi MoreMsg term=NONE
  hi NonText term=NONE
  hi Pmenu term=reverse
  hi PmenuSbar term=reverse
  hi PmenuSel term=bold
  hi PmenuThumb term=NONE
  hi Question term=standout
  hi Search term=reverse
  hi SignColumn term=reverse
  hi SpecialKey term=bold
  hi SpellBad term=underline
  hi SpellCap term=underline
  hi SpellLocal term=underline
  hi SpellRare term=underline
  hi StatusLine term=bold,reverse
  hi StatusLineNC term=bold,underline
  hi TabLine term=bold,underline
  hi TabLineFill term=NONE
  hi Terminal term=NONE
  hi TabLineSel term=bold,reverse
  hi Title term=NONE
  hi VertSplit term=NONE
  hi Visual term=reverse
  hi VisualNOS term=NONE
  hi WarningMsg term=standout
  hi WildMenu term=bold
  hi CursorIM term=NONE
  hi ToolbarLine term=reverse
  hi ToolbarButton term=bold,reverse
  hi CurSearch term=reverse
  hi CursorLineFold term=underline
  hi CursorLineSign term=underline
  hi Comment term=bold
  hi Constant term=NONE
  hi Error term=bold,reverse
  hi Identifier term=NONE
  hi Ignore term=NONE
  hi PreProc term=NONE
  hi Special term=NONE
  hi Statement term=NONE
  hi Todo term=bold,reverse
  hi Type term=NONE
  hi Underlined term=underline
  unlet s:t_Co
  finish
endif

" Background: dark
" Color: guibg         #161821           233               black
" Color: statusline    #d7d7ff           189               white
" Color: statuslineNC  #8787af           103               grey
" Color: darkuipurple  #5f5f87           60                grey
" Color: dark0         #000000           16                black
" Color: dark1         #FE9F64           167               darkred
" Color: dark2         #72DACB           113               darkgreen
" Color: dark3         #9ECE6A           179               darkyellow
" Color: dark4         #9D7CD8           110               darkblue
" Color: dark5         #af87d7           140               darkmagenta
" Color: dark6         #2AC3DE           73                darkcyan
" Color: dark7         #C1CAF4           253               grey
" Color: dark8         #707070           242               darkgrey
" Color: dark9         #ff5f5f           203               red
" Color: dark10        #87ff5f           119               green
" Color: dark11        #ffd75f           221               yellow
" Color: dark12        #87d7ff           117               blue
" Color: dark13        #d787ff           177               magenta
" Color: dark14        #5fd7d7           80                cyan
" Color: dark15        #ffffff           231               white
" Color: diffred       #d7005f           161               darkred
" Color: diffgreen     #00af5f           35                darkgreen
" Color: diffblue      #87afff           111               darkblue
" Color: diffpink      #ff87ff           213               darkmagenta
" Color: uipink        #ff00af           199               magenta
" Color: uilime        #afff00           154               green
" Color: uiteal        #5fd7af           79                green
" Color: uiblue        #00afff           39                blue
" Color: uipurple      #af00ff           129               darkmagenta
" Color: uiamber       #ffaf00           214               darkyellow
" Color: uiblack       #363841           237               darkgrey
" Color: yasogrey      #262831           235               black
" Color: linenrblack   #585858           240               darkgrey
" Color: uicursearch   #ff5fff           207               magenta
" Color: invisigrey    #a6a8b1           248               darkgrey
" Color: errorred      #ff5f5f           203               red
" Term colors: dark0 dark1 dark2 dark3 dark4 dark5 dark6 dark7
" Term colors: dark8 dark9 dark10 dark11 dark12 dark13 dark14 dark15
" vim: et ts=2 sw=2
