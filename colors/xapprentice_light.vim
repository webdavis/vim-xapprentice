" Maintainer: Stephen A. Davis <stephen@webdavis.io>
" Repository: https://github.com/webdavis/vim-xapprentice.git
" Description: based on Apprentice, with a few tweaks.

if &g:compatible || v:version <? 700
    finish
endif

" Save the users compatible-options so that they may be restored later.
let s:save_cpoptions = &g:cpoptions
set cpoptions&vim

" Return highlight groups to default settings.
highlight clear
if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'xapprentice_light'

if $TERM =~? '256' || &t_Co >= 256 || has('gui_running')
    set background=light

    if (exists('$COLORTERM') && $COLORTERM =~? 'truecolor' && has('termguicolors') && &g:termguicolors)
        let s:darkyellow = '#e5c23c'
        let s:lightyellow = '#ffe37b'
        let s:lightblue = '#c7e3ff'
        " Leaving this because I go back and forth on changing it.
        let s:lightgray = '#e4e4e4'
        highlight Operator guibg=#ebefff guifg=#005faf | call format#FormatHighlightGroup('Operator')
    else
        let s:darkyellow = '#dfaf00'
        let s:lightyellow = '#ffdf5f'
        let s:lightblue = '#5fafff'
        let s:lightgray = '#e4e4e4'
        highlight Operator ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE    | call format#FormatHighlightGroup('Operator')
    endif

    highlight Normal           ctermbg=15   ctermfg=236  guibg=#ffffff guifg=#303030 | call format#FormatHighlightGroup('Normal')
    execute 'highlight LineNr     ctermbg=255  ctermfg=245  guibg=' . s:lightgray . ' guifg=#8a8a8a' | call format#FormatHighlightGroup('LineNr')
    execute 'highlight FoldColumn ctermbg=255  ctermfg=242  guibg=' . s:lightgray . ' guifg=#6c6c6c' | call format#FormatHighlightGroup('FoldColumn')
    execute 'highlight Folded     ctermbg=255  ctermfg=242  guibg=' . s:lightgray . ' guifg=#6c6c6c' | call format#FormatHighlightGroup('Folded')
    highlight MatchParen       ctermbg=NONE ctermfg=129  guibg=NONE    guifg=#af00ff | call format#FormatHighlightGroup('MatchParen')

    highlight Comment          ctermbg=NONE ctermfg=243  guibg=NONE    guifg=#767676 | call format#FormatHighlightGroup('Comment')
    highlight Conceal          ctermbg=NONE ctermfg=15   guibg=NONE    guifg=#ffffff | call format#FormatHighlightGroup('Conceal')
    highlight Constant         ctermbg=NONE ctermfg=67   guibg=NONE    guifg=#5f87af | call format#FormatHighlightGroup('Constant')
    highlight Number           ctermbg=NONE ctermfg=67   guibg=NONE    guifg=#5f87af | call format#FormatHighlightGroup('Constant')
    highlight Error            ctermbg=NONE ctermfg=88   guibg=NONE    guifg=#870000 | call format#FormatHighlightGroup('Error')
    highlight Identifier       ctermbg=NONE ctermfg=24   guibg=NONE    guifg=#005faf | call format#FormatHighlightGroup('Identifier')
    highlight Ignore           ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE    | call format#FormatHighlightGroup('Ignore')
    highlight String           ctermbg=NONE ctermfg=28   guibg=NONE    guifg=#008700 | call format#FormatHighlightGroup('String')

    highlight PreProc          ctermbg=NONE ctermfg=66   guibg=NONE    guifg=#5f8787 | call format#FormatHighlightGroup('PreProc')
    highlight Special          ctermbg=NONE ctermfg=66   guibg=NONE    guifg=#5f8787 | call format#FormatHighlightGroup('Special')
    highlight Delimiter        ctermbg=NONE ctermfg=66   guibg=NONE    guifg=#5f8787 | call format#FormatHighlightGroup('Delimiter')
    highlight Statement        ctermbg=NONE ctermfg=24   guibg=NONE    guifg=#005f87 | call format#FormatHighlightGroup('Statement')
    highlight Todo             ctermbg=NONE ctermfg=237  guibg=NONE    guifg=#3a3a3a | call format#FormatHighlightGroup('Todo')
    highlight Type             ctermbg=NONE ctermfg=96   guibg=NONE    guifg=#875f87 | call format#FormatHighlightGroup('Type')
    highlight Underlined       ctermbg=NONE ctermfg=129  guibg=NONE    guifg=#af00ff | call format#FormatHighlightGroup('Underlined', 'underline')

    highlight NonText          ctermbg=NONE ctermfg=248  guibg=NONE    guifg=#a8a8a8 | call format#FormatHighlightGroup('NonText')

    highlight Pmenu            ctermbg=253  ctermfg=237  guibg=#dadada guifg=#3a3a3a | call format#FormatHighlightGroup('Pmenu')
    highlight PmenuSbar        ctermbg=240  ctermfg=NONE guibg=#9e9e9e guifg=NONE    | call format#FormatHighlightGroup('PmenuSbar')
    highlight PmenuSel         ctermbg=67   ctermfg=15   guibg=#5f87af guifg=#ffffff | call format#FormatHighlightGroup('PmenuSel')
    highlight PmenuThumb       ctermbg=242  ctermfg=NONE guibg=#6c6c6c guifg=NONE    | call format#FormatHighlightGroup('PmenuThumb')

    " Requires neoclide/coc.nvim to be installed.
    if exists('g:did_coc_loaded')
        highlight CocHighlightText      ctermbg=189  ctermfg=NONE guibg=#dfdfff guifg=NONE    | call format#FormatHighlightGroup('CocHighlightText')
        highlight CocFloating           ctermbg=252  ctermfg=237  guibg=#d0d0d0 guifg=#3a3a3a | call format#FormatHighlightGroup('CocFloating')
        highlight CocCodeLens           ctermbg=NONE ctermfg=242  guibg=NONE    guifg=#6c6c6c | call format#FormatHighlightGroup('CocCodeLens')
        highlight CocInfoSign           ctermbg=NONE ctermfg=32   guibg=NONE    guifg=#0087d7 | call format#FormatHighlightGroup('CocInfoSign', 'bold')
        highlight CocInfoHighlight      ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE    | call format#FormatHighlightGroup('CocInfoHighlight')
        highlight CocHintSign           ctermbg=NONE ctermfg=65   guibg=NONE    guifg=#5f875f | call format#FormatHighlightGroup('CocHintSign')
        highlight CocHintHighlight      ctermbg=65   ctermfg=235  guibg=#5f875f guifg=#262626 | call format#FormatHighlightGroup('CocHintHighlight')
        highlight CocWarningSign        ctermbg=221  ctermfg=237  guibg=#ffdf5f guifg=#3a3a3a | call format#FormatHighlightGroup('CocWarningSign')
        highlight CocWarningHighlight   ctermbg=221  ctermfg=237  guibg=#ffdf5f guifg=#3a3a3a | call format#FormatHighlightGroup('CocWarningHighlight')
        highlight CocErrorSign          ctermbg=NONE ctermfg=131  guibg=NONE    guifg=#af5f5f | call format#FormatHighlightGroup('CocErrorSign')
        highlight CocErrorHighlight     ctermbg=181  ctermfg=234  guibg=#dfafaf guifg=#1c1c1c | call format#FormatHighlightGroup('CocErrorHighlight')

        " Provided by the extension coc-highlight.
        highlight HighlightedyankRegion ctermbg=152  ctermfg=237  guibg=#afd7d7 guifg=#3a3a3a | call format#FormatHighlightGroup('HighlightedyankRegion')
    endif

    " Requires unblevable/quick-scope to be installed.
    highlight QuickScopePrimary   guifg=#000000 ctermfg=0   | call format#FormatHighlightGroup('QuickScopePrimary', 'bold')
    highlight QuickScopeSecondary guifg=#af5f5f ctermfg=131 | call format#FormatHighlightGroup('QuickScopeSecondary', 'bold')

    highlight ErrorMsg         ctermbg=NONE ctermfg=197  guibg=NONE    guifg=#ff005f | call format#FormatHighlightGroup('ErrorMsg')
    highlight ModeMsg          ctermbg=67   ctermfg=15   guibg=#5f87af guifg=#ffffff | call format#FormatHighlightGroup('ModeMsg')
    highlight MoreMsg          ctermbg=NONE ctermfg=66   guibg=NONE    guifg=#5f8787 | call format#FormatHighlightGroup('MoreMsg')
    highlight Question         ctermbg=NONE ctermfg=66   guibg=NONE    guifg=#5f8787 | call format#FormatHighlightGroup('Question')
    highlight WarningMsg       ctermbg=NONE ctermfg=215  guibg=NONE    guifg=#ffaf5f | call format#FormatHighlightGroup('WarningMsg')

    highlight TabLine          ctermbg=248  ctermfg=236  guibg=#a8a8a8 guifg=#303030 | call format#FormatHighlightGroup('TabLine')
    highlight TabLineFill      ctermbg=249  ctermfg=236  guibg=#b2b2b2 guifg=#303030 | call format#FormatHighlightGroup('TabLineFill')
    highlight TabLineSel       ctermbg=110  ctermfg=236  guibg=#87afd7 guifg=#303030 | call format#FormatHighlightGroup('TabLineSel')

    highlight Cursor           ctermbg=67   ctermfg=NONE guibg=#5f87af guifg=NONE    | call format#FormatHighlightGroup('Cursor')
    highlight CursorColumn     ctermbg=255  ctermfg=NONE guibg=#eeeeee guifg=NONE    | call format#FormatHighlightGroup('CursorColumn')
    highlight CursorLineNr     ctermbg=255  ctermfg=33   guibg=#eeeeee guifg=#0087ff | call format#FormatHighlightGroup('CursorLineNr')
    highlight CursorLine       ctermbg=255  ctermfg=NONE guibg=#eeeeee guifg=NONE    | call format#FormatHighlightGroup('CursorLine')

    highlight helpLeadBlank    ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE    | call format#FormatHighlightGroup('helpLeadBlank')
    highlight helpNormal       ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE    | call format#FormatHighlightGroup('helpNormal')

    highlight StatusLine       ctermbg=252  ctermfg=252  guibg=#d0d0d0 guifg=#303030 | call format#FormatHighlightGroup('StatusLine')
    highlight StatusLineNC     ctermbg=247  ctermfg=240  guibg=#9e9e9e guifg=#585858 | call format#FormatHighlightGroup('StatusLineNC')

    highlight StatusLineTerm   ctermbg=252  ctermfg=236  guibg=#d0d0d0 guifg=#303030 | call format#FormatHighlightGroup('StatusLineTerm')
    highlight StatusLineTermNC ctermbg=247  ctermfg=240  guibg=#9e9e9e guifg=#585858 | call format#FormatHighlightGroup('StatusLineTermNC')

    highlight Visual           ctermbg=152  ctermfg=237  guibg=#afd7d7 guifg=#3a3a3a | call format#FormatHighlightGroup('Visual')
    highlight VisualNOS        ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE    | call format#FormatHighlightGroup('VisualNOS')

    highlight VertSplit        ctermbg=247  ctermfg=247  guibg=#9e9e9e guifg=#9e9e9e | call format#FormatHighlightGroup('VertSplit')
    highlight WildMenu         ctermbg=115  ctermfg=235  guibg=#87d7af guifg=#262626 | call format#FormatHighlightGroup('WildMenu')

    highlight Function         ctermbg=NONE ctermfg=88   guibg=NONE    guifg=#870000 | call format#FormatHighlightGroup('Function')
    highlight SpecialKey       ctermbg=NONE ctermfg=240  guibg=NONE    guifg=#585858 | call format#FormatHighlightGroup('SpecialKey')
    highlight Title            ctermbg=NONE ctermfg=33   guibg=NONE    guifg=#0087ff | call format#FormatHighlightGroup('Title')

    highlight DiffAdd          ctermbg=115  ctermfg=236  guibg=#87d7af guifg=#303030 | call format#FormatHighlightGroup('DiffAdd')
    highlight DiffChange       ctermbg=117  ctermfg=236  guibg=#87d7ff guifg=#303030 | call format#FormatHighlightGroup('DiffChange')
    highlight DiffDelete       ctermbg=210  ctermfg=236  guibg=#ff8787 guifg=#303030 | call format#FormatHighlightGroup('DiffDelete')
    highlight DiffText         ctermbg=215  ctermfg=236  guibg=#ffaf5f guifg=#303030 | call format#FormatHighlightGroup('DiffText')

    highlight IncSearch        ctermbg=211  ctermfg=236  guibg=#ff87af guifg=#303030 | call format#FormatHighlightGroup('IncSearch')
    execute 'highlight Search ctermbg=253 ctermfg=236  guibg=' . s:darkyellow . ' guifg=#303030' | call format#FormatHighlightGroup('Search')

    highlight Directory        ctermbg=NONE ctermfg=33   guibg=NONE    guifg=#0087ff | call format#FormatHighlightGroup('Directory')

    execute 'highlight SignColumn ctermbg=255 ctermfg=242 guibg=' . s:lightgray . ' guifg=#6c6c6c' | call format#FormatHighlightGroup('SignColumn')
    execute 'highlight ColorColumn ctermbg=NONE ctermfg=75 guibg=NONE guifg=' . s:lightblue | call format#FormatHighlightGroup('ColorColumn')

    highlight QuickFixLine     ctermbg=195  ctermfg=NONE guibg=#dfffff guifg=NONE    | call format#FormatHighlightGroup('QuickFixLine')
    highlight qfLineNr         ctermbg=NONE ctermfg=237  guibg=NONE    guifg=#3a3a3a | call format#FormatHighlightGroup('qfLineNr')
    highlight qfFileName       ctermbg=NONE ctermfg=24   guibg=NONE    guifg=#005f87 | call format#FormatHighlightGroup('rfFileName')
    highlight qfError          ctermbg=NONE ctermfg=210  guibg=NONE    guifg=#ff8787 | call format#FormatHighlightGroup('qfError')

    highlight ExtraWhitespace  ctermbg=210  ctermfg=NONE guibg=#ff8787 guifg=NONE    | call format#FormatHighlightGroup('ExtraWhitespace')

    highlight DebugPC          ctermbg=75   ctermfg=236  guibg=#5fafff guifg=#303030 | call format#FormatHighlightGroup('DebugPC')
    highlight DebugBreakpoint  ctermbg=33   ctermfg=236  guibg=#0087ff guifg=#303030 | call format#FormatHighlightGroup('DebugBreakpoint')

    " Markdown code.
    highlight mkdHeading       ctermbg=NONE ctermfg=26   guibg=NONE    guifg=#005fd7 | call format#FormatHighlightGroup('mkdHeading', 'bold')
    highlight htmlH1           ctermbg=NONE ctermfg=26   guibg=NONE    guifg=#005fd7 | call format#FormatHighlightGroup('htmlH1', 'bold')

    if has('gui_running')
        highlight SpellBad          ctermbg=230  ctermfg=236  guibg=NONE    guifg=#303030 guisp=#af87af | call format#FormatHighlightGroup('SpellBad', 'undercurl')
        highlight SpellCap          ctermbg=73   ctermfg=236  guibg=NONE    guifg=#303030 guisp=#5fafaf | call format#FormatHighlightGroup('SpellCap', 'undercurl')
        highlight SpellLocal        ctermbg=65   ctermfg=236  guibg=NONE    guifg=#303030 guisp=#87d7af | call format#FormatHighlightGroup('SpellLocal', 'undercurl')
        highlight SpellRare         ctermbg=172  ctermfg=236  guibg=NONE    guifg=#303030 guisp=#ffaf5f | call format#FormatHighlightGroup('SpellRare', 'undercurl')
    else
        highlight SpellBad          ctermbg=139  ctermfg=236  guibg=#af87af guifg=#303030 guisp=NONE    | call format#FormatHighlightGroup('SpellBad', 'undercurl')
        highlight SpellCap          ctermbg=73   ctermfg=236  guibg=#5fafaf guifg=#303030 guisp=NONE    | call format#FormatHighlightGroup('SpellCap', 'undercurl')
        highlight SpellLocal        ctermbg=115  ctermfg=236  guibg=#87d7af guifg=#303030 guisp=NONE    | call format#FormatHighlightGroup('SpellLocal', 'undercurl')
        highlight SpellRare         ctermbg=215  ctermfg=236  guibg=#ffaf5f guifg=#303030 guisp=NONE    | call format#FormatHighlightGroup('SpellRare', 'undercurl')
    endif

    if get(g:, 'xapprentice_ale', 1) ==? 1
        highlight ALEError          ctermbg=210  ctermfg=15   guibg=#ff8787 guifg=#303030  | call format#FormatHighlightGroup('ALEError')
        execute 'highlight ALEErrorSign ctermbg=255  ctermfg=210  guibg=' . s:lightgray . ' guifg=#ff8787'  | call format#FormatHighlightGroup('ALEErrorSign')
        highlight ALEErrorLine      ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE     | call format#FormatHighlightGroup('ALEErrorLine')

        highlight ALEWarning        ctermbg=215  ctermfg=236  guibg=#ffaf5f guifg=#303030  | call format#FormatHighlightGroup('ALEWarning')
        execute 'highlight ALEWarningSign ctermbg=255  ctermfg=208  guibg=' . s:lightgray . ' guifg=#ff8700'  | call format#FormatHighlightGroup('ALEWarningSign')
        highlight ALEWarningLine    ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE     | call format#FormatHighlightGroup('ALEWarningLine')

        highlight ALEInfo           ctermbg=215  ctermfg=236  guibg=#ffaf5f guifg=#303030  | call format#FormatHighlightGroup('ALEInfo')
        execute 'highlight ALEInfoSign ctermbg=255  ctermfg=208  guibg=' . s:lightgray . ' guifg=#ff8700'  | call format#FormatHighlightGroup('ALEInfoSign')
        highlight ALEInfoLine       ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE     | call format#FormatHighlightGroup('ALEInfoLine')
    else
        highlight ALEError          ctermbg=210  ctermfg=236  guibg=#ff8787 guifg=#303030  | call format#FormatHighlightGroup('ALEError')
        execute 'highlight ALEErrorSign ctermbg=255  ctermfg=210  guibg=' . s:lightgray . ' guifg=#ff8787'  | call format#FormatHighlightGroup('ALEErrorSign')
        highlight ALEErrorLine      ctermbg=210  ctermfg=15   guibg=#ff8787 guifg=#303030  | call format#FormatHighlightGroup('ALEErrorLine')

        highlight ALEWarning        ctermbg=215  ctermfg=236  guibg=#ffaf5f guifg=#303030  | call format#FormatHighlightGroup('ALEWarning')
        execute 'highlight ALEWarningSign ctermbg=255  ctermfg=208  guibg=' . s:lightgray . ' guifg=#ff8700'  | call format#FormatHighlightGroup('ALEWarningSign')
        highlight ALEWarningLine    ctermbg=215  ctermfg=236  guibg=#ffaf5f guifg=#303030  | call format#FormatHighlightGroup('ALEWarningLine')

        highlight ALEInfo           ctermbg=215  ctermfg=236  guibg=#ffaf5f guifg=#303030  | call format#FormatHighlightGroup('ALEInfo')
        execute 'highlight ALEInfoSign ctermbg=255  ctermfg=208  guibg=' . s:lightgray . ' guifg=#ff8700'  | call format#FormatHighlightGroup('ALEInfoSign')
        highlight ALEInfoLine       ctermbg=215  ctermfg=236  guibg=#ffaf5f guifg=#303030  | call format#FormatHighlightGroup('ALEInfoLine')
    endif

    if get(g:, 'xapprentice_signify', 1)
        execute 'highlight SignifySignAdd    ctermbg=255  ctermfg=29   guibg=' . s:lightgray . ' guifg=#00875f'  | call format#FormatHighlightGroup('SignifySignAdd')
        execute 'highlight SignifySignDelete ctermbg=255  ctermfg=210  guibg=' . s:lightgray . ' guifg=#ff8787'  | call format#FormatHighlightGroup('SignifySignDelete')
        execute 'highlight SignifySignChange ctermbg=255  ctermfg=33   guibg=' . s:lightgray . ' guifg=#0087ff'  | call format#FormatHighlightGroup('SignifySignChange')
        highlight link SignifySignDeleteFirstLine SignifySignDelete
        highlight link SignifySignChangeDelete SignifySignChange
    else
        highlight link SignifySignAdd DiffAdd
        highlight link SignifySignDelete DiffDelete
        highlight link SignifySignDeleteFirstLine SignifySignDelete
        highlight link SignifySignChange DiffChange
        highlight link SignifySignChangeDelete SignifySignChange
    endif

elseif &t_Co == 8 || $TERM !~# '^linux' || &t_Co == 16
    set t_Co=16
    set background=dark

    highlight Normal           ctermbg=NONE        ctermfg=white       | call format#FormatHighlightGroup('Normal')

    highlight Comment          ctermbg=NONE        ctermfg=gray        | call format#FormatHighlightGroup('Comment')
    highlight Conceal          ctermbg=NONE        ctermfg=white       | call format#FormatHighlightGroup('Conceal')
    highlight Constant         ctermbg=NONE        ctermfg=red         | call format#FormatHighlightGroup('Constant')
    highlight Function         ctermbg=NONE        ctermfg=yellow      | call format#FormatHighlightGroup('Function')
    highlight Identifier       ctermbg=NONE        ctermfg=darkblue    | call format#FormatHighlightGroup('Identifier')
    highlight PreProc          ctermbg=NONE        ctermfg=darkcyan    | call format#FormatHighlightGroup('PreProc')
    highlight Special          ctermbg=NONE        ctermfg=darkgreen   | call format#FormatHighlightGroup('Special')
    highlight Statement        ctermbg=NONE        ctermfg=blue        | call format#FormatHighlightGroup('Statement')
    highlight String           ctermbg=NONE        ctermfg=green       | call format#FormatHighlightGroup('String')
    highlight Todo             ctermbg=NONE        ctermfg=NONE        | call format#FormatHighlightGroup('Todo')
    highlight Type             ctermbg=NONE        ctermfg=magenta     | call format#FormatHighlightGroup('Type')

    highlight Error            ctermbg=NONE        ctermfg=darkred     | call format#FormatHighlightGroup('Error')
    highlight Ignore           ctermbg=NONE        ctermfg=NONE        | call format#FormatHighlightGroup('Ignore')
    highlight Underlined       ctermbg=NONE        ctermfg=NONE        | call format#FormatHighlightGroup('Underlined')

    highlight LineNr           ctermbg=black       ctermfg=gray        | call format#FormatHighlightGroup('LineNr')
    highlight NonText          ctermbg=NONE        ctermfg=darkgray    | call format#FormatHighlightGroup('NonText')

    highlight Pmenu            ctermbg=darkgray    ctermfg=white       | call format#FormatHighlightGroup('Pmenu')
    highlight PmenuSbar        ctermbg=gray        ctermfg=NONE        | call format#FormatHighlightGroup('PmenuSbar')
    highlight PmenuSel         ctermbg=darkcyan    ctermfg=black       | call format#FormatHighlightGroup('PmenuSel')
    highlight PmenuThumb       ctermbg=darkcyan    ctermfg=NONE        | call format#FormatHighlightGroup('PmenuThumb')

    highlight ErrorMsg         ctermbg=darkred     ctermfg=black       | call format#FormatHighlightGroup('ErrorMsg')
    highlight ModeMsg          ctermbg=darkgreen   ctermfg=black       | call format#FormatHighlightGroup('ModeMsg')
    highlight MoreMsg          ctermbg=NONE        ctermfg=darkcyan    | call format#FormatHighlightGroup('MoreMsg')
    highlight Question         ctermbg=NONE        ctermfg=green       | call format#FormatHighlightGroup('Question')
    highlight WarningMsg       ctermbg=NONE        ctermfg=darkred     | call format#FormatHighlightGroup('WarningMsg')

    highlight TabLine          ctermbg=darkgray    ctermfg=darkyellow  | call format#FormatHighlightGroup('TabLine')
    highlight TabLineFill      ctermbg=darkgray    ctermfg=black       | call format#FormatHighlightGroup('TabLineFill')
    highlight TabLineSel       ctermbg=darkyellow  ctermfg=black       | call format#FormatHighlightGroup('TabLineSel')

    highlight Cursor           ctermbg=NONE        ctermfg=NONE        | call format#FormatHighlightGroup('Cursor')
    highlight CursorColumn     ctermbg=darkgray    ctermfg=NONE        | call format#FormatHighlightGroup('CursorColumn')
    highlight CursorLineNr     ctermbg=black       ctermfg=cyan        | call format#FormatHighlightGroup('CursorLineNr')
    highlight CursorLine       ctermbg=darkgray    ctermfg=NONE        | call format#FormatHighlightGroup('CursorLine')

    highlight helpLeadBlank    ctermbg=NONE        ctermfg=NONE        | call format#FormatHighlightGroup('helpLeadBlank')
    highlight helpNormal       ctermbg=NONE        ctermfg=NONE        | call format#FormatHighlightGroup('helpNormal')

    highlight StatusLine       ctermbg=yellow      ctermfg=black       | call format#FormatHighlightGroup('StatusLine')
    highlight StatusLineNC     ctermbg=darkgray    ctermfg=darkyellow  | call format#FormatHighlightGroup('StatusLineNC')

    highlight StatusLineterm   ctermbg=darkyellow  ctermfg=white       | call format#FormatHighlightGroup('StatusLineterm')
    highlight StatusLinetermNC ctermbg=darkgray    ctermfg=darkyellow  | call format#FormatHighlightGroup('StatusLinetermNC')

    highlight Visual           ctermbg=black       ctermfg=blue        | call format#FormatHighlightGroup('Visual')
    highlight VisualNOS        ctermbg=black       ctermfg=white       | call format#FormatHighlightGroup('VisualNOS')

    highlight FoldColumn       ctermbg=black       ctermfg=darkgray    | call format#FormatHighlightGroup('FoldColumn')
    highlight Folded           ctermbg=black       ctermfg=darkgray    | call format#FormatHighlightGroup('Folded')

    highlight VertSplit        ctermbg=darkgray    ctermfg=darkgray    | call format#FormatHighlightGroup('VertSplit')
    highlight WildMenu         ctermbg=blue        ctermfg=black       | call format#FormatHighlightGroup('WildMenu')

    highlight SpecialKey       ctermbg=NONE        ctermfg=darkgray    | call format#FormatHighlightGroup('SpecialKey')
    highlight Title            ctermbg=NONE        ctermfg=white       | call format#FormatHighlightGroup('Title')

    highlight DiffAdd          ctermbg=black       ctermfg=green       | call format#FormatHighlightGroup('DiffAdd')
    highlight DiffChange       ctermbg=black       ctermfg=magenta     | call format#FormatHighlightGroup('DiffChange')
    highlight DiffDelete       ctermbg=black       ctermfg=darkred     | call format#FormatHighlightGroup('DiffDelete')
    highlight DiffText         ctermbg=black       ctermfg=red         | call format#FormatHighlightGroup('DiffText')

    highlight IncSearch        ctermbg=darkred     ctermfg=black       | call format#FormatHighlightGroup('IncSearch')
    highlight Search           ctermbg=yellow      ctermfg=black       | call format#FormatHighlightGroup('Search')

    highlight Directory        ctermbg=NONE        ctermfg=cyan        | call format#FormatHighlightGroup('Directory')
    highlight MatchParen       ctermbg=black       ctermfg=yellow      | call format#FormatHighlightGroup('MatchParen')

    highlight SpellBad         ctermbg=NONE        ctermfg=darkred     | call format#FormatHighlightGroup('SpellBad')
    highlight SpellCap         ctermbg=NONE        ctermfg=darkyellow  | call format#FormatHighlightGroup('SpellCap')
    highlight SpellLocal       ctermbg=NONE        ctermfg=darkgreen   | call format#FormatHighlightGroup('SpellLocal')
    highlight SpellRare        ctermbg=NONE        ctermfg=darkmagenta | call format#FormatHighlightGroup('SpellRare')

    highlight ColorColumn      ctermbg=black       ctermfg=NONE        | call format#FormatHighlightGroup('ColorColumn')
    highlight SignColumn       ctermbg=black       ctermfg=darkgray    | call format#FormatHighlightGroup('SignColumn')

    highlight QuickFixLine     ctermbg=black       ctermfg=NONE        | call format#FormatHighlightGroup('QuickFixLine')
    highlight qfLineNr         ctermbg=NONE        ctermfg=darkyellow  | call format#FormatHighlightGroup('qfLineNr')
    highlight qfFileName       ctermbg=NONE        ctermfg=darkcyan    | call format#FormatHighlightGroup('rfFileName')
    highlight qfError          ctermbg=NONE        ctermfg=red         | call format#FormatHighlightGroup('qfError')

    highlight ExtraWhitespace  ctermbg=red         ctermfg=NONE        | call format#FormatHighlightGroup('ExtraWhitespace')

    highlight DebugPC          ctermbg=blue        ctermfg=NONE        | call format#FormatHighlightGroup('DebugPC')
    highlight DebugBreakpoint  ctermbg=red         ctermfg=NONE        | call format#FormatHighlightGroup('DebugBreakpoint')

    " Markdown code.
    highlight mkdHeading       ctermbg=NONE        ctermfg=blue        | call format#FormatHighlightGroup('mkdHeading', 'bold')
    highlight htmlH1           ctermbg=NONE        ctermfg=blue        | call format#FormatHighlightGroup('htmlH1', 'bold')

    if get(g:, 'xapprentice_ale', 1) ==? 1
        highlight ALEError          ctermbg=lightred    ctermfg=black     | call format#FormatHighlightGroup('ALEError')
        highlight ALEErrorSign      ctermbg=black      ctermfg=lightred   | call format#FormatHighlightGroup('ALEErrorSign')
        highlight ALEErrorLine      ctermbg=NONE       ctermfg=NONE       | call format#FormatHighlightGroup('ALEErrorLine')

        highlight ALEWarning        ctermbg=darkyellow ctermfg=black      | call format#FormatHighlightGroup('ALEWarning')
        highlight ALEWarningSign    ctermbg=black      ctermfg=darkyellow | call format#FormatHighlightGroup('ALEWarningSign')
        highlight ALEWarningLine    ctermbg=NONE       ctermfg=NONE       | call format#FormatHighlightGroup('ALEWarningLine')

        highlight ALEInfo           ctermbg=darkyellow ctermfg=black      | call format#FormatHighlightGroup('ALEInfo')
        highlight ALEInfoSign       ctermbg=black      ctermfg=darkyellow | call format#FormatHighlightGroup('ALEInfoSign')
        highlight ALEInfoLine       ctermbg=NONE       ctermfg=NONE       | call format#FormatHighlightGroup('ALEInfoLine')
    else
        highlight ALEError          ctermbg=lightred    ctermfg=lightred  | call format#FormatHighlightGroup('ALEError')
        highlight ALEErrorSign      ctermbg=black      ctermfg=lightred   | call format#FormatHighlightGroup('ALEErrorSign')
        highlight ALEErrorLine      ctermbg=lightred    ctermfg=black     | call format#FormatHighlightGroup('ALEErrorLine')

        highlight ALEWarning        ctermbg=darkyellow ctermfg=black      | call format#FormatHighlightGroup('ALEWarning')
        highlight ALEWarningSign    ctermbg=black      ctermfg=darkyellow | call format#FormatHighlightGroup('ALEWarningSign')
        highlight ALEWarningLine    ctermbg=darkyellow ctermfg=black      | call format#FormatHighlightGroup('ALEWarningLine')

        highlight ALEInfo           ctermbg=darkyellow ctermfg=black      | call format#FormatHighlightGroup('ALEInfo')
        highlight ALEInfoSign       ctermbg=black      ctermfg=darkyellow | call format#FormatHighlightGroup('ALEInfoSign')
        highlight ALEInfoLine       ctermbg=darkyellow ctermfg=black      | call format#FormatHighlightGroup('ALEInfoLine')
    endif

    if get(g:, 'xapprentice_signify', 1)
        highlight SignifySignAdd    ctermbg=black ctermfg=green     | call format#FormatHighlightGroup('SignifySignAdd')
        highlight SignifySignDelete ctermbg=black ctermfg=darkred   | call format#FormatHighlightGroup('SignifySignDelete')
        highlight SignifySignChange ctermbg=black ctermfg=blue      | call format#FormatHighlightGroup('SignifySignChange')
        highlight link SignifySignDeleteFirstLine SignifySignDelete
        highlight link SignifySignChangeDelete    SignifySignChange
    else
        highlight link SignifySignAdd             DiffAdd
        highlight link SignifySignDelete          DiffDelete
        highlight link SignifySignDeleteFirstLine SignifySignDelete
        highlight link SignifySignChange          DiffChange
        highlight link SignifySignChangeDelete    SignifySignChange
    endif
endif

let g:terminal_ansi_colors = [
        \ '#eeeeee',
        \ '#ff8787',
        \ '#5f875f',
        \ '#878787',
        \ '#5f87af',
        \ '#5f5f87',
        \ '#5f8787',
        \ '#6c6c6c',
        \ '#444444',
        \ '#ff8700',
        \ '#87af87',
        \ '#ffdfaf',
        \ '#00afd7',
        \ '#8787af',
        \ '#5fafaf',
        \ '#ffffdf'
        \ ]

let s:links = [
        \ ['Boolean', 'Constant'],
        \ ['Character', 'Constant'],
        \ ['Number', 'Constant'],
        \ ['Float', 'Number'],
        \ ['Conditional', 'Statement'],
        \ ['Debug', 'Special'],
        \ ['Define', 'PreProc'],
        \ ['Exception', 'Statement'],
        \ ['HelpCommand', 'Statement'],
        \ ['HelpExample', 'Statement'],
        \ ['Include', 'PreProc'],
        \ ['Keyword', 'Statement'],
        \ ['Label', 'Statement'],
        \ ['Macro', 'PreProc'],
        \ ['PreCondit', 'PreProc'],
        \ ['Repeat', 'Statement'],
        \ ['SpecialChar', 'Special'],
        \ ['SpecialComment', 'Special'],
        \ ['StorageClass', 'Type'],
        \ ['Structure', 'Type'],
        \ ['Tag', 'Special'],
        \ ['Terminal', 'Normal'],
        \ ['Typedef', 'Type'],
        \ ['htmlEndTag', 'htmlTagName'],
        \ ['htmlLink', 'Statement'],
        \ ['htmlSpecialTagName', 'htmlTagName'],
        \ ['htmlTag', 'htmlTagName'],
        \ ['htmlBold', 'Normal'],
        \ ['htmlItalic', 'Error'],
        \ ['markdownHeadingDelimiter', 'htmlH1'],
        \ ['markdownCode', 'SpecialKey'],
        \ ['markdownCodeBlock', 'markdownCode'],
        \ ['markdownItalic', 'Error'],
        \ ['markdownUrl', 'Statement'],
        \ ['markdownListMarker', 'Constant'],
        \ ['mkdURL', 'markdownUrl'],
        \ ['mkdID', 'mkdURL'],
        \ ['mkdDelimiter', 'mkdURL'],
        \ ['mkdInlineURL', 'mkdURL'],
        \ ['mkdHeading', 'htmlH1'],
        \ ['mkdListItem', 'Identifier'],
        \ ['xmlTag', 'Statement'],
        \ ['xmlTagName', 'Statement'],
        \ ['xmlEndTag', 'Statement'],
        \ ['asciidocQuotedEmphasized', 'Preproc'],
        \ ['diffBDiffer', 'WarningMsg'],
        \ ['diffCommon', 'WarningMsg'],
        \ ['diffDiffer', 'WarningMsg'],
        \ ['diffIdentical', 'WarningMsg'],
        \ ['diffIsA', 'WarningMsg'],
        \ ['diffNoEOL', 'WarningMsg'],
        \ ['diffOnly', 'WarningMsg'],
        \ ['diffRemoved', 'WarningMsg'],
        \ ['diffAdded', 'String'],
        \ ['vimIsCommand', 'Statement'],
        \ ['vimFunction', 'FunctionStatement'],
        \ ]

augroup Apprentice
    autocmd!
    autocmd ColorScheme * if expand('<amatch>') =~# 'xapprentice_light'
                            \ | for link in s:links | execute 'hi link' link[0] link[1] | endfor
                            \ | else | for link in s:links | execute 'hi link' link[0] 'NONE' | endfor
                            \ | endif
augroup END

" Restore the previously saved compatible options.
let &g:cpoptions = s:save_cpoptions
unlet! s:save_cpoptions
