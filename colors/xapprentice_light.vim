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
        let s:lightyellow = '#ffe37b'
        let s:lightblue = '#c7e3ff'
        " Leaving this because I go back and forth on changing it.
        let s:lightgray = '#e4e4e4'
        highlight Operator guibg=#ebefff guifg=#005faf | call format#FormatHighlightGroup('Operator')
    else
        let s:lightyellow = '#ffdf5f'
        let s:lightblue = '#5fafff'
        let s:lightgray = '#e4e4e4'
        highlight Operator ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE    | call format#FormatHighlightGroup('Operator')
    endif

    highlight Normal           ctermbg=15   ctermfg=236  guibg=#ffffff guifg=#303030 | call format#FormatHighlightGroup('Normal')
    execute 'highlight LineNr     ctermbg=255  ctermfg=245  guibg=' . s:lightgray . ' guifg=#8a8a8a' | call format#FormatHighlightGroup('LineNr')
    execute 'highlight FoldColumn ctermbg=255  ctermfg=242  guibg=' . s:lightgray . ' guifg=#6c6c6c' | call format#FormatHighlightGroup('FoldColumn')
    execute 'highlight Folded     ctermbg=255  ctermfg=242  guibg=' . s:lightgray . ' guifg=#6c6c6c' | call format#FormatHighlightGroup('Folded')
    highlight MatchParen       ctermbg=92   ctermfg=147  guibg=#8700d7 guifg=#afafff | call format#FormatHighlightGroup('MatchParen')

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

    highlight ErrorMsg         ctermbg=NONE ctermfg=197  guibg=NONE    guifg=#ff005f | call format#FormatHighlightGroup('ErrorMsg')
    highlight ModeMsg          ctermbg=67   ctermfg=15   guibg=#5f87af guifg=#ffffff | call format#FormatHighlightGroup('ModeMsg')
    highlight MoreMsg          ctermbg=NONE ctermfg=66   guibg=NONE    guifg=#5f8787 | call format#FormatHighlightGroup('MoreMsg')
    highlight Question         ctermbg=NONE ctermfg=66   guibg=NONE    guifg=#5f8787 | call format#FormatHighlightGroup('Question')
    highlight WarningMsg       ctermbg=222  ctermfg=236  guibg=#ffdf87 guifg=#303030 | call format#FormatHighlightGroup('WarningMsg')

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
    highlight Search           ctermbg=222  ctermfg=236  guibg=#ffdf87 guifg=#303030 | call format#FormatHighlightGroup('Search')

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

    " Markdown.
    highlight mkdHeading       ctermbg=NONE ctermfg=26   guibg=NONE    guifg=#005fd7 | call format#FormatHighlightGroup('mkdHeading', 'bold')
    highlight htmlH1           ctermbg=NONE ctermfg=26   guibg=NONE    guifg=#005fd7 | call format#FormatHighlightGroup('htmlH1', 'bold')
    highlight htmlBold         ctermbg=NONE ctermfg=56   guibg=NONE    guifg=#5f00d7 | call format#FormatHighlightGroup('htmlBold', 'bold')

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

    " Requires neoclide/coc.nvim to be loaded.
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

        " Requires the extension coc-highlight.
        highlight HighlightedyankRegion ctermbg=152  ctermfg=237  guibg=#afd7d7 guifg=#3a3a3a | call format#FormatHighlightGroup('HighlightedyankRegion')

        " Requires the extension coc-git.
        execute 'highlight CocAddedSign          ctermbg=255  ctermfg=29   guibg=' . s:lightgray . ' guifg=#00875f'  | call format#FormatHighlightGroup('CocAddedSign')
        execute 'highlight CocRemovedSign        ctermbg=255  ctermfg=88   guibg=' . s:lightgray . ' guifg=#870000'  | call format#FormatHighlightGroup('CocRemovedSign')
        execute 'highlight CocChangedSign        ctermbg=255  ctermfg=33   guibg=' . s:lightgray . ' guifg=#0087ff'  | call format#FormatHighlightGroup('CocChangedSign')
                 highlight link CocTopRemovedSign    CocRemovedSign
                 highlight link CocChangeRemovedSign CocChangedSign
    endif

    " Requires unblevable/quick-scope to be loaded.
    if exists('g:loaded_quick_scope')
      highlight QuickScopePrimary   guifg=#000000 ctermfg=0   | call format#FormatHighlightGroup('QuickScopePrimary', 'bold')
      highlight QuickScopeSecondary guifg=#af5f5f ctermfg=131 | call format#FormatHighlightGroup('QuickScopeSecondary', 'bold')
    endif

    " Requires mhinz/vim-signify to be loaded.
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

    " Requires ntpeters/vim-better-whitespace to be loaded.
    if exists("g:loaded_better_whitespace_plugin")
      let g:better_whitespace_ctermcolor = '95'
      let g:better_whitespace_guicolor = '#875f5f'
    endif

    " Requires Yggdroot/LeaderF to be loaded.
    if exists('g:leaderf_loaded')
      " Lf_hl_popup_inputText is the wincolor of input window
      highlight def Lf_hl_popup_inputText guifg=#525252 guibg=#f4f3d7 gui=NONE ctermfg=239 ctermbg=230 cterm=NONE

      " Lf_hl_popup_window is the wincolor of content window
      highlight def Lf_hl_popup_window guifg=#4d4d4d guibg=#fafbff gui=NONE ctermfg=239 ctermbg=231 cterm=NONE

      " Lf_hl_popup_blank is the wincolor of statusline window
      highlight def Lf_hl_popup_blank guifg=NONE guibg=#eeecc1 gui=NONE ctermbg=230 cterm=NONE

      highlight def link Lf_hl_popup_cursor Cursor
      highlight def Lf_hl_popup_prompt guifg=#c77400 guibg=NONE gui=NONE ctermfg=172 cterm=NONE
      highlight def Lf_hl_popup_spin guifg=#f12d2d guibg=NONE gui=NONE ctermfg=196 cterm=NONE
      highlight def Lf_hl_popup_normalMode guifg=#808000 guibg=#ccc88e gui=bold ctermfg=100 ctermbg=186 cterm=bold
      highlight def Lf_hl_popup_inputMode guifg=#808000 guibg=#f0e68c gui=bold ctermfg=100 ctermbg=186 cterm=bold
      highlight def Lf_hl_popup_category guifg=#4d4d4d guibg=#c7dac3 gui=NONE ctermfg=239 ctermbg=151 cterm=NONE
      highlight def Lf_hl_popup_nameOnlyMode guifg=#4d4d4d guibg=#c9d473 gui=NONE ctermfg=239 ctermbg=186 cterm=NONE
      highlight def Lf_hl_popup_fullPathMode guifg=#4d4d4d guibg=#dbe8cf gui=NONE ctermfg=239 ctermbg=187 cterm=NONE
      highlight def Lf_hl_popup_fuzzyMode guifg=#4d4d4d guibg=#dbe8cf gui=NONE ctermfg=239 ctermbg=187 cterm=NONE
      highlight def Lf_hl_popup_regexMode guifg=#4d4d4d guibg=#acbf97 gui=NONE ctermfg=239 ctermbg=144 cterm=NONE
      highlight def Lf_hl_popup_cwd guifg=#595959 guibg=#e9f7e9 gui=NONE ctermfg=240 ctermbg=195 cterm=NONE
      highlight def Lf_hl_popup_lineInfo guifg=#595959 guibg=#e9f7e9 gui=NONE ctermfg=240 ctermbg=195 cterm=NONE
      highlight def Lf_hl_popup_total guifg=#4d4d4d guibg=#c7dac3 gui=NONE ctermfg=239 ctermbg=151 cterm=NONE


      " the color of the cursorline
      highlight def Lf_hl_cursorline guifg=#6927ff guibg=NONE gui=NONE ctermfg=57 cterm=NONE

      " the color of matching character
      highlight def Lf_hl_match guifg=#cd4545 guibg=NONE gui=bold ctermfg=167 cterm=bold

      " the color of matching character in `And mode`
      highlight def Lf_hl_match0 guifg=#cd4545 guibg=NONE gui=bold ctermfg=167 cterm=bold
      highlight def Lf_hl_match1 guifg=#033fff guibg=NONE gui=bold ctermfg=21 cterm=bold
      highlight def Lf_hl_match2 guifg=#b52bb0 guibg=NONE gui=bold ctermfg=127 cterm=bold
      highlight def Lf_hl_match3 guifg=#ff7100 guibg=NONE gui=bold ctermfg=202 cterm=bold
      highlight def Lf_hl_match4 guifg=#248888 guibg=NONE gui=bold ctermfg=30 cterm=bold

      " the color of matching character in nameOnly mode when ';' is typed
      highlight def Lf_hl_matchRefine guifg=Magenta guibg=NONE gui=bold ctermfg=201 cterm=bold

      " the color of help in normal mode when <F1> is pressed
      highlight def link Lf_hl_help               Comment
      highlight def link Lf_hl_helpCmd            Identifier

      " the color when select multiple lines
      highlight def Lf_hl_selection guifg=#4d4d4d guibg=#a5eb84 gui=NONE ctermfg=239 ctermbg=156 cterm=NONE

      " the color of `Leaderf buffer`
      highlight def link Lf_hl_bufNumber          Constant
      highlight def link Lf_hl_bufIndicators      Statement
      highlight def link Lf_hl_bufModified        String
      highlight def link Lf_hl_bufNomodifiable    Comment
      highlight def link Lf_hl_bufDirname         Directory

      " the color of `Leaderf tag`
      highlight def link Lf_hl_tagFile            Directory
      highlight def link Lf_hl_tagType            Type
      highlight def link Lf_hl_tagKeyword         Keyword

      " the color of `Leaderf bufTag`
      highlight def link Lf_hl_buftagKind         Title
      highlight def link Lf_hl_buftagScopeType    Keyword
      highlight def link Lf_hl_buftagScope        Type
      highlight def link Lf_hl_buftagDirname      Directory
      highlight def link Lf_hl_buftagLineNum      Constant
      highlight def link Lf_hl_buftagCode         Comment

      " the color of `Leaderf function`
      highlight def link Lf_hl_funcKind           Title
      highlight def link Lf_hl_funcReturnType     Type
      highlight def link Lf_hl_funcScope          Keyword
      highlight def link Lf_hl_funcName           Function
      highlight def link Lf_hl_funcDirname        Directory
      highlight def link Lf_hl_funcLineNum        Constant

      " the color of `Leaderf line`
      highlight def link Lf_hl_lineLocation       Comment

      " the color of `Leaderf self`
      highlight def link Lf_hl_selfIndex          Constant
      highlight def link Lf_hl_selfDescription    Comment

      " the color of `Leaderf help`
      highlight def link Lf_hl_helpTagfile        Comment

      " the color of `Leaderf rg`
      highlight def link Lf_hl_rgFileName         Directory
      highlight def link Lf_hl_rgLineNumber       Constant
      " the color of line number if '-A' or '-B' or '-C' is in the options list
      " of `Leaderf rg`
      highlight def link Lf_hl_rgLineNumber2      Folded
      " the color of column number if '--column' in g:Lf_RgConfig
      highlight def link Lf_hl_rgColumnNumber     Constant
      highlight def Lf_hl_rgHighlight guifg=#4d4d4d guibg=#cccc66 gui=NONE ctermfg=239 ctermbg=185 cterm=NONE

      " the color of `Leaderf gtags`
      highlight def link Lf_hl_gtagsFileName      Directory
      highlight def link Lf_hl_gtagsLineNumber    Constant
      highlight def Lf_hl_gtagsHighlight guifg=#4d4d4d guibg=#cccc66 gui=NONE ctermfg=239 ctermbg=185 cterm=NONE

      highlight def link Lf_hl_previewTitle       Statusline
    endif

    if exists(':AsyncTask') != 0
      highlight AsyncRunSuccess ctermbg=157 ctermfg=238 guibg=#afffaf guifg=#444444 | call format#FormatHighlightGroup('AsyncRunSuccess')
      highlight AsyncRunFailure ctermbg=222 ctermfg=238 guibg=#ffdf87 guifg=#444444 | call format#FormatHighlightGroup('AsyncRunFailure')
    endif

    if has('gui_running')
      highlight SpellBad          ctermbg=230  ctermfg=236  guibg=NONE    guifg=#303030 guisp=#ff87af | call format#FormatHighlightGroup('SpellBad', 'undercurl')
      highlight SpellCap          ctermbg=73   ctermfg=236  guibg=NONE    guifg=#303030 guisp=#5fd7af | call format#FormatHighlightGroup('SpellCap', 'undercurl')
      highlight SpellLocal        ctermbg=65   ctermfg=236  guibg=NONE    guifg=#303030 guisp=#87d7af | call format#FormatHighlightGroup('SpellLocal', 'undercurl')
      highlight SpellRare         ctermbg=172  ctermfg=236  guibg=NONE    guifg=#303030 guisp=#ffaf5f | call format#FormatHighlightGroup('SpellRare', 'undercurl')
    else
      highlight SpellBad          ctermbg=211  ctermfg=236  guibg=#ff87af guifg=#303030 guisp=NONE    | call format#FormatHighlightGroup('SpellBad', 'undercurl')
      highlight SpellCap          ctermbg=79   ctermfg=236  guibg=#5fd7af guifg=#303030 guisp=NONE    | call format#FormatHighlightGroup('SpellCap', 'undercurl')
      highlight SpellLocal        ctermbg=115  ctermfg=236  guibg=#87d7af guifg=#303030 guisp=NONE    | call format#FormatHighlightGroup('SpellLocal', 'undercurl')
      highlight SpellRare         ctermbg=215  ctermfg=236  guibg=#ffaf5f guifg=#303030 guisp=NONE    | call format#FormatHighlightGroup('SpellRare', 'undercurl')
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
        \ '#5fd7af',
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
        \ ['Operator', 'Statement'],
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
        \ ['diffRemoved', 'Error'],
        \ ['diffAdded', 'String'],
        \ ['vimIsCommand', 'Statement'],
        \ ['vimFunction', 'FunctionStatement'],
        \ ]

augroup Xapprentice
    autocmd!
    autocmd ColorScheme * if expand('<amatch>') =~# 'xapprentice_light'
                            \ | for link in s:links | execute 'highlight link' link[0] link[1] | endfor
                            \ | else | for link in s:links | execute 'highlight link' link[0] 'NONE' | endfor
                            \ | endif
augroup END

" Restore the previously saved compatible options.
let &g:cpoptions = s:save_cpoptions
unlet! s:save_cpoptions
