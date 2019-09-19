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

" Attributes.
let s:vim_attributes = ['bold', 'italic', 'underline', 'reverse', 'inverse', 'standout', 'undercurl']

" Allows the User to dynamically add an attribute to a highlight group.
function! s:Group()
    let l:group = {}
    let l:group.cterm = []
    let l:group.gui = []
    let l:group.term = []

    function! l:group.AttachAttr(group, attributes)
        call insert(self.cterm, 'cterm=NONE')
        call insert(self.gui, 'gui=NONE')
        call insert(self.term, 'term=NONE')

        if !empty(a:attributes)
            for l:a in a:attributes
                call add(self.term, l:a)
                call add(self.gui, l:a)
                call add(self.cterm, l:a)
            endfor
            unlet l:a
        endif

        for l:a in s:vim_attributes
            if index(get(g:, eval(string('xapprentice_' . l:a . '_group')), []), a:group, 0, 1) >=? 0
                    \ && get(g:, eval(string('xapprentice_' . l:a)), 1)
                call add(self.cterm, l:a)
                call add(self.gui, l:a)
                call add(self.term, l:a)
            endif
            unlet l:a
        endfor

        let self.cterm = filter(filter(copy(self.cterm), 'index(self.cterm, v:val, v:key + 1) == -1'), 'v:val !=? ""')
        let self.cterm = join(self.cterm, ',')
        let self.gui = filter(filter(copy(self.gui), 'index(self.gui, v:val, v:key + 1) == -1'), 'v:val !=? ""')
        let self.gui = join(self.gui, ',')
        let self.term = filter(filter(copy(self.term), 'index(self.term, v:val, v:key + 1) == -1'), 'v:val !=? ""')
        let self.term = join(self.term, ',')
        execute 'highlight ' . a:group . ' ' . self.cterm . ' ' . self.gui . ' ' . self.term
    endfunction

    return l:group
endfunction

function! s:FormatGroup(group, ...)
    let l:group = s:Group()
    return l:group.AttachAttr(a:group, a:000)
endfunction

if $TERM =~? '256' || &t_Co >= 256 || has('gui_running')
    set background=dark

    if (exists('$COLORTERM') && $COLORTERM =~? 'truecolor' && has('termguicolors') && &g:termguicolors)
        let s:lightyellow = '#ffe88f'
        let s:lightblue = '#c7e3ff'
        let s:lightgray = '#f9f9f9'
        highlight String   guibg=#efffef guifg=#5f8787 | call s:FormatGroup('String')
        highlight Operator guibg=#ebefff guifg=#005faf | call s:FormatGroup('Operator')
    else
        let s:lightyellow = '#ffdf5f'
        let s:lightblue = '#5fafff'
        let s:lightgray = '#eeeeee'
        highlight String   ctermbg=NONE ctermfg=64   guibg=NONE guifg=#5f8700 | call s:FormatGroup('String')
        highlight Operator ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE    | call s:FormatGroup('Operator')
    endif

    highlight Normal           ctermbg=15   ctermfg=237  guibg=#ffffff guifg=#3a3a3a | call s:FormatGroup('Normal')
    execute 'highlight LineNr     ctermbg=255  ctermfg=245  guibg=' . s:lightgray . ' guifg=#8a8a8a' | call s:FormatGroup('LineNr')
    execute 'highlight FoldColumn ctermbg=255  ctermfg=242  guibg=' . s:lightgray . ' guifg=#6c6c6c' | call s:FormatGroup('FoldColumn')
    execute 'highlight Folded     ctermbg=255  ctermfg=242  guibg=' . s:lightgray . ' guifg=#6c6c6c' | call s:FormatGroup('Folded')
    highlight MatchParen       ctermbg=NONE ctermfg=129  guibg=NONE    guifg=#af00ff | call s:FormatGroup('MatchParen')

    highlight Comment          ctermbg=NONE ctermfg=96   guibg=NONE    guifg=#875f87 | call s:FormatGroup('Comment')
    highlight Conceal          ctermbg=NONE ctermfg=15   guibg=NONE    guifg=#ffffff | call s:FormatGroup('Conceal')
    highlight Constant         ctermbg=NONE ctermfg=67   guibg=NONE    guifg=#5f87af | call s:FormatGroup('Constant')
    highlight Number           ctermbg=NONE ctermfg=67   guibg=NONE    guifg=#5f87af | call s:FormatGroup('Constant')
    highlight Error            ctermbg=236  ctermfg=210  guibg=#303030 guifg=#ff8787 | call s:FormatGroup('Error')
    highlight Identifier       ctermbg=NONE ctermfg=24   guibg=NONE    guifg=#005faf | call s:FormatGroup('Identifier')
    highlight Ignore           ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE    | call s:FormatGroup('Ignore')

    highlight PreProc          ctermbg=NONE ctermfg=66   guibg=NONE    guifg=#5f8787 | call s:FormatGroup('PreProc')
    highlight Special          ctermbg=NONE ctermfg=66   guibg=NONE    guifg=#5f8787 | call s:FormatGroup('Special')
    highlight Delimiter        ctermbg=NONE ctermfg=66   guibg=NONE    guifg=#5f8787 | call s:FormatGroup('Delimiter')
    highlight Statement        ctermbg=NONE ctermfg=24   guibg=NONE    guifg=#005f87 | call s:FormatGroup('Statement')
    highlight Todo             ctermbg=115  ctermfg=237  guibg=#87d7af guifg=#3a3a3a | call s:FormatGroup('Todo')
    highlight Type             ctermbg=NONE ctermfg=234  guibg=NONE    guifg=#1c1c1c | call s:FormatGroup('Type')
    highlight Underlined       ctermbg=NONE ctermfg=129  guibg=NONE    guifg=#af00ff | call s:FormatGroup('Underlined', 'underline')

    highlight NonText          ctermbg=NONE ctermfg=248  guibg=NONE    guifg=#a8a8a8 | call s:FormatGroup('NonText')

    highlight Pmenu            ctermbg=253  ctermfg=237  guibg=#dadada guifg=#3a3a3a | call s:FormatGroup('Pmenu')
    highlight PmenuSbar        ctermbg=240  ctermfg=NONE guibg=#9e9e9e guifg=NONE    | call s:FormatGroup('PmenuSbar')
    highlight PmenuSel         ctermbg=67   ctermfg=15   guibg=#5f87af guifg=#ffffff | call s:FormatGroup('PmenuSel')
    highlight PmenuThumb       ctermbg=242  ctermfg=NONE guibg=#6c6c6c guifg=NONE    | call s:FormatGroup('PmenuThumb')

    " Requires neoclide/coc.nvim to be installed.
    if exists('g:did_coc_loaded')
        highlight CocFloating  ctermbg=252  ctermfg=237  guibg=#d0d0d0 guifg=#3a3a3a | call s:FormatGroup('CocFloating')
    endif

    " Requires unblevable/quick-scope to be installed.
    highlight QuickScopePrimary   guifg=#000000 gui=bold ctermfg=0   cterm=bold
    highlight QuickScopeSecondary guifg=#af5f5f gui=bold ctermfg=131 cterm=bold

    highlight ErrorMsg         ctermbg=NONE ctermfg=197  guibg=NONE    guifg=#ff005f | call s:FormatGroup('ErrorMsg')
    highlight ModeMsg          ctermbg=67   ctermfg=15   guibg=#5f87af guifg=#ffffff | call s:FormatGroup('ModeMsg')
    highlight MoreMsg          ctermbg=NONE ctermfg=66   guibg=NONE    guifg=#5f8787 | call s:FormatGroup('MoreMsg')
    highlight Question         ctermbg=NONE ctermfg=66   guibg=NONE    guifg=#5f8787 | call s:FormatGroup('Question')
    highlight WarningMsg       ctermbg=NONE ctermfg=215  guibg=NONE    guifg=#ffaf5f | call s:FormatGroup('WarningMsg')

    highlight TabLine          ctermbg=250  ctermfg=240  guibg=#bcbcbc guifg=#585858 | call s:FormatGroup('TabLine')
    highlight TabLineFill      ctermbg=252  ctermfg=236  guibg=#d0d0d0 guifg=#303030 | call s:FormatGroup('TabLineFill')
    highlight TabLineSel       ctermbg=24   ctermfg=255  guibg=#005f87 guifg=#eeeeee | call s:FormatGroup('TabLineSel')

    highlight Cursor           ctermbg=67   ctermfg=NONE guibg=#5f87af guifg=NONE    | call s:FormatGroup('Cursor')
    highlight CursorColumn     ctermbg=255  ctermfg=NONE guibg=#eeeeee guifg=NONE    | call s:FormatGroup('CursorColumn')
    highlight CursorLineNr     ctermbg=255  ctermfg=33   guibg=#eeeeee guifg=#0087ff | call s:FormatGroup('CursorLineNr')
    highlight CursorLine       ctermbg=255  ctermfg=NONE guibg=#eeeeee guifg=NONE    | call s:FormatGroup('CursorLine')

    highlight helpLeadBlank    ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE    | call s:FormatGroup('helpLeadBlank')
    highlight helpNormal       ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE    | call s:FormatGroup('helpNormal')

    highlight StatusLine       ctermbg=252  ctermfg=252  guibg=#d0d0d0 guifg=#303030 | call s:FormatGroup('StatusLine')
    highlight StatusLineNC     ctermbg=247  ctermfg=240  guibg=#9e9e9e guifg=#585858 | call s:FormatGroup('StatusLineNC')

    highlight StatusLineTerm   ctermbg=252  ctermfg=236  guibg=#d0d0d0 guifg=#303030 | call s:FormatGroup('StatusLineTerm')
    highlight StatusLineTermNC ctermbg=247  ctermfg=240  guibg=#9e9e9e guifg=#585858 | call s:FormatGroup('StatusLineTermNC')

    highlight Visual           ctermbg=152  ctermfg=237  guibg=#afd7d7 guifg=#3a3a3a | call s:FormatGroup('Visual')
    highlight VisualNOS        ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE    | call s:FormatGroup('VisualNOS')

    highlight VertSplit        ctermbg=247  ctermfg=247  guibg=#9e9e9e guifg=#9e9e9e | call s:FormatGroup('VertSplit')
    execute 'highlight WildMenu ctermbg=75 ctermfg=236 guibg=' . s:lightblue . ' guifg=#303030' | call s:FormatGroup('WildMenu')

    highlight Function         ctermbg=NONE ctermfg=88   guibg=NONE    guifg=#870000 | call s:FormatGroup('Function')
    highlight SpecialKey       ctermbg=NONE ctermfg=240  guibg=NONE    guifg=#585858 | call s:FormatGroup('SpecialKey')
    highlight Title            ctermbg=NONE ctermfg=33   guibg=NONE    guifg=#0087ff | call s:FormatGroup('Title')

    highlight DiffAdd          ctermbg=115  ctermfg=236  guibg=#87d7af guifg=#303030 | call s:FormatGroup('DiffAdd')
    highlight DiffChange       ctermbg=117  ctermfg=236  guibg=#87d7ff guifg=#303030 | call s:FormatGroup('DiffChange')
    highlight DiffDelete       ctermbg=210  ctermfg=236  guibg=#ff8787 guifg=#303030 | call s:FormatGroup('DiffDelete')
    highlight DiffText         ctermbg=215  ctermfg=236  guibg=#ffaf5f guifg=#303030 | call s:FormatGroup('DiffText')

    highlight IncSearch        ctermbg=211  ctermfg=236  guibg=#ff87af guifg=#303030 | call s:FormatGroup('IncSearch')
    execute 'highlight Search ctermbg=253 ctermfg=236  guibg=' . s:lightyellow . ' guifg=#303030' | call s:FormatGroup('Search')

    highlight Directory        ctermbg=NONE ctermfg=24   guibg=NONE    guifg=#005f87 | call s:FormatGroup('Directory')

    execute 'highlight SignColumn ctermbg=255 ctermfg=242 guibg=' . s:lightgray . ' guifg=#6c6c6c' | call s:FormatGroup('SignColumn')
    execute 'highlight ColorColumn ctermbg=NONE ctermfg=75 guibg=NONE guifg=' . s:lightblue | call s:FormatGroup('ColorColumn')

    highlight QuickFixLine     ctermbg=195  ctermfg=NONE guibg=#dfffff guifg=NONE    | call s:FormatGroup('QuickFixLine')
    highlight qfLineNr         ctermbg=NONE ctermfg=237  guibg=NONE    guifg=#3a3a3a | call s:FormatGroup('qfLineNr')
    highlight qfFileName       ctermbg=NONE ctermfg=24   guibg=NONE    guifg=#005f87 | call s:FormatGroup('rfFileName')
    highlight qfError          ctermbg=NONE ctermfg=210  guibg=NONE    guifg=#ff8787 | call s:FormatGroup('qfError')

    highlight ExtraWhitespace  ctermbg=210  ctermfg=NONE guibg=#ff8787 guifg=NONE    | call s:FormatGroup('ExtraWhitespace')

    highlight DebugPC          ctermbg=75   ctermfg=236  guibg=#5fafff guifg=#303030 | call s:FormatGroup('DebugPC')
    highlight DebugBreakpoint  ctermbg=33   ctermfg=236  guibg=#0087ff guifg=#303030 | call s:FormatGroup('DebugBreakpoint')

    " Markdown code.
    highlight mkdHeading       ctermbg=NONE ctermfg=33   guibg=NONE    guifg=#0087ff | call s:FormatGroup('mkdHeading', 'bold')
    highlight htmlH1           ctermbg=NONE ctermfg=33   guibg=NONE    guifg=#0087ff | call s:FormatGroup('htmlH1', 'bold')
    highlight mkdURL           ctermbg=NONE ctermfg=129  guibg=NONE    guifg=#af00ff | call s:FormatGroup('mkdURL')
    highlight mkdInlineURL     ctermbg=NONE ctermfg=129  guibg=NONE    guifg=#af00ff | call s:FormatGroup('mkdInlineURL')
    highlight mkdID            ctermbg=NONE ctermfg=129  guibg=NONE    guifg=#af00ff | call s:FormatGroup('mkdID')

    if has('gui_running')
        highlight SpellBad          ctermbg=230  ctermfg=236  guibg=NONE    guifg=#303030 guisp=#af87af | call s:FormatGroup('SpellBad', 'undercurl')
        highlight SpellCap          ctermbg=73   ctermfg=236  guibg=NONE    guifg=#303030 guisp=#5fafaf | call s:FormatGroup('SpellCap', 'undercurl')
        highlight SpellLocal        ctermbg=65   ctermfg=236  guibg=NONE    guifg=#303030 guisp=#87d7af | call s:FormatGroup('SpellLocal', 'undercurl')
        highlight SpellRare         ctermbg=172  ctermfg=236  guibg=NONE    guifg=#303030 guisp=#ffaf5f | call s:FormatGroup('SpellRare', 'undercurl')
    else
        highlight SpellBad          ctermbg=139  ctermfg=236  guibg=#af87af guifg=#303030 guisp=NONE    | call s:FormatGroup('SpellBad', 'undercurl')
        highlight SpellCap          ctermbg=73   ctermfg=236  guibg=#5fafaf guifg=#303030 guisp=NONE    | call s:FormatGroup('SpellCap', 'undercurl')
        highlight SpellLocal        ctermbg=115  ctermfg=236  guibg=#87d7af guifg=#303030 guisp=NONE    | call s:FormatGroup('SpellLocal', 'undercurl')
        highlight SpellRare         ctermbg=215  ctermfg=236  guibg=#ffaf5f guifg=#303030 guisp=NONE    | call s:FormatGroup('SpellRare', 'undercurl')
    endif

    if get(g:, 'xapprentice_ale', 1) ==? 1
        highlight ALEError          ctermbg=210  ctermfg=15   guibg=#ff8787 guifg=#303030  | call s:FormatGroup('ALEError')
        execute 'highlight ALEErrorSign ctermbg=255  ctermfg=210  guibg=' . s:lightgray . ' guifg=#ff8787'  | call s:FormatGroup('ALEErrorSign')
        highlight ALEErrorLine      ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE     | call s:FormatGroup('ALEErrorLine')

        highlight ALEWarning        ctermbg=215  ctermfg=236  guibg=#ffaf5f guifg=#303030  | call s:FormatGroup('ALEWarning')
        execute 'highlight ALEWarningSign ctermbg=255  ctermfg=208  guibg=' . s:lightgray . ' guifg=#ff8700'  | call s:FormatGroup('ALEWarningSign')
        highlight ALEWarningLine    ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE     | call s:FormatGroup('ALEWarningLine')

        highlight ALEInfo           ctermbg=215  ctermfg=236  guibg=#ffaf5f guifg=#303030  | call s:FormatGroup('ALEInfo')
        execute 'highlight ALEInfoSign ctermbg=255  ctermfg=208  guibg=' . s:lightgray . ' guifg=#ff8700'  | call s:FormatGroup('ALEInfoSign')
        highlight ALEInfoLine       ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE     | call s:FormatGroup('ALEInfoLine')
    else
        highlight ALEError          ctermbg=210  ctermfg=236  guibg=#ff8787 guifg=#303030  | call s:FormatGroup('ALEError')
        execute 'highlight ALEErrorSign ctermbg=255  ctermfg=210  guibg=' . s:lightgray . ' guifg=#ff8787'  | call s:FormatGroup('ALEErrorSign')
        highlight ALEErrorLine      ctermbg=210  ctermfg=15   guibg=#ff8787 guifg=#303030  | call s:FormatGroup('ALEErrorLine')

        highlight ALEWarning        ctermbg=215  ctermfg=236  guibg=#ffaf5f guifg=#303030  | call s:FormatGroup('ALEWarning')
        execute 'highlight ALEWarningSign ctermbg=255  ctermfg=208  guibg=' . s:lightgray . ' guifg=#ff8700'  | call s:FormatGroup('ALEWarningSign')
        highlight ALEWarningLine    ctermbg=215  ctermfg=236  guibg=#ffaf5f guifg=#303030  | call s:FormatGroup('ALEWarningLine')

        highlight ALEInfo           ctermbg=215  ctermfg=236  guibg=#ffaf5f guifg=#303030  | call s:FormatGroup('ALEInfo')
        execute 'highlight ALEInfoSign ctermbg=255  ctermfg=208  guibg=' . s:lightgray . ' guifg=#ff8700'  | call s:FormatGroup('ALEInfoSign')
        highlight ALEInfoLine       ctermbg=215  ctermfg=236  guibg=#ffaf5f guifg=#303030  | call s:FormatGroup('ALEInfoLine')
    endif

    if get(g:, 'xapprentice_signify', 1)
        execute 'highlight SignifySignAdd    ctermbg=255  ctermfg=29   guibg=' . s:lightgray . ' guifg=#00875f'  | call s:FormatGroup('SignifySignAdd')
        execute 'highlight SignifySignDelete ctermbg=255  ctermfg=210  guibg=' . s:lightgray . ' guifg=#ff8787'  | call s:FormatGroup('SignifySignDelete')
        execute 'highlight SignifySignChange ctermbg=255  ctermfg=33   guibg=' . s:lightgray . ' guifg=#0087ff'  | call s:FormatGroup('SignifySignChange')
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

    highlight Normal           ctermbg=NONE        ctermfg=white       | call s:FormatGroup('Normal')

    highlight Comment          ctermbg=NONE        ctermfg=gray        | call s:FormatGroup('Comment')
    highlight Conceal          ctermbg=NONE        ctermfg=white       | call s:FormatGroup('Conceal')
    highlight Constant         ctermbg=NONE        ctermfg=red         | call s:FormatGroup('Constant')
    highlight Function         ctermbg=NONE        ctermfg=yellow      | call s:FormatGroup('Function')
    highlight Identifier       ctermbg=NONE        ctermfg=darkblue    | call s:FormatGroup('Identifier')
    highlight PreProc          ctermbg=NONE        ctermfg=darkcyan    | call s:FormatGroup('PreProc')
    highlight Special          ctermbg=NONE        ctermfg=darkgreen   | call s:FormatGroup('Special')
    highlight Statement        ctermbg=NONE        ctermfg=blue        | call s:FormatGroup('Statement')
    highlight String           ctermbg=NONE        ctermfg=green       | call s:FormatGroup('String')
    highlight Todo             ctermbg=NONE        ctermfg=NONE        | call s:FormatGroup('Todo')
    highlight Type             ctermbg=NONE        ctermfg=magenta     | call s:FormatGroup('Type')

    highlight Error            ctermbg=NONE        ctermfg=darkred     | call s:FormatGroup('Error')
    highlight Ignore           ctermbg=NONE        ctermfg=NONE        | call s:FormatGroup('Ignore')
    highlight Underlined       ctermbg=NONE        ctermfg=NONE        | call s:FormatGroup('Underlined')

    highlight LineNr           ctermbg=black       ctermfg=gray        | call s:FormatGroup('LineNr')
    highlight NonText          ctermbg=NONE        ctermfg=darkgray    | call s:FormatGroup('NonText')

    highlight Pmenu            ctermbg=darkgray    ctermfg=white       | call s:FormatGroup('Pmenu')
    highlight PmenuSbar        ctermbg=gray        ctermfg=NONE        | call s:FormatGroup('PmenuSbar')
    highlight PmenuSel         ctermbg=darkcyan    ctermfg=black       | call s:FormatGroup('PmenuSel')
    highlight PmenuThumb       ctermbg=darkcyan    ctermfg=NONE        | call s:FormatGroup('PmenuThumb')

    highlight ErrorMsg         ctermbg=darkred     ctermfg=black       | call s:FormatGroup('ErrorMsg')
    highlight ModeMsg          ctermbg=darkgreen   ctermfg=black       | call s:FormatGroup('ModeMsg')
    highlight MoreMsg          ctermbg=NONE        ctermfg=darkcyan    | call s:FormatGroup('MoreMsg')
    highlight Question         ctermbg=NONE        ctermfg=green       | call s:FormatGroup('Question')
    highlight WarningMsg       ctermbg=NONE        ctermfg=darkred     | call s:FormatGroup('WarningMsg')

    highlight TabLine          ctermbg=darkgray    ctermfg=darkyellow  | call s:FormatGroup('TabLine')
    highlight TabLineFill      ctermbg=darkgray    ctermfg=black       | call s:FormatGroup('TabLineFill')
    highlight TabLineSel       ctermbg=darkyellow  ctermfg=black       | call s:FormatGroup('TabLineSel')

    highlight Cursor           ctermbg=NONE        ctermfg=NONE        | call s:FormatGroup('Cursor')
    highlight CursorColumn     ctermbg=darkgray    ctermfg=NONE        | call s:FormatGroup('CursorColumn')
    highlight CursorLineNr     ctermbg=black       ctermfg=cyan        | call s:FormatGroup('CursorLineNr')
    highlight CursorLine       ctermbg=darkgray    ctermfg=NONE        | call s:FormatGroup('CursorLine')

    highlight helpLeadBlank    ctermbg=NONE        ctermfg=NONE        | call s:FormatGroup('helpLeadBlank')
    highlight helpNormal       ctermbg=NONE        ctermfg=NONE        | call s:FormatGroup('helpNormal')

    highlight StatusLine       ctermbg=yellow      ctermfg=black       | call s:FormatGroup('StatusLine')
    highlight StatusLineNC     ctermbg=darkgray    ctermfg=darkyellow  | call s:FormatGroup('StatusLineNC')

    highlight StatusLineterm   ctermbg=darkyellow  ctermfg=white       | call s:FormatGroup('StatusLineterm')
    highlight StatusLinetermNC ctermbg=darkgray    ctermfg=darkyellow  | call s:FormatGroup('StatusLinetermNC')

    highlight Visual           ctermbg=black       ctermfg=blue        | call s:FormatGroup('Visual')
    highlight VisualNOS        ctermbg=black       ctermfg=white       | call s:FormatGroup('VisualNOS')

    highlight FoldColumn       ctermbg=black       ctermfg=darkgray    | call s:FormatGroup('FoldColumn')
    highlight Folded           ctermbg=black       ctermfg=darkgray    | call s:FormatGroup('Folded')

    highlight VertSplit        ctermbg=darkgray    ctermfg=darkgray    | call s:FormatGroup('VertSplit')
    highlight WildMenu         ctermbg=blue        ctermfg=black       | call s:FormatGroup('WildMenu')

    highlight SpecialKey       ctermbg=NONE        ctermfg=darkgray    | call s:FormatGroup('SpecialKey')
    highlight Title            ctermbg=NONE        ctermfg=white       | call s:FormatGroup('Title')

    highlight DiffAdd          ctermbg=black       ctermfg=green       | call s:FormatGroup('DiffAdd')
    highlight DiffChange       ctermbg=black       ctermfg=magenta     | call s:FormatGroup('DiffChange')
    highlight DiffDelete       ctermbg=black       ctermfg=darkred     | call s:FormatGroup('DiffDelete')
    highlight DiffText         ctermbg=black       ctermfg=red         | call s:FormatGroup('DiffText')

    highlight IncSearch        ctermbg=darkred     ctermfg=black       | call s:FormatGroup('IncSearch')
    highlight Search           ctermbg=yellow      ctermfg=black       | call s:FormatGroup('Search')

    highlight Directory        ctermbg=NONE        ctermfg=cyan        | call s:FormatGroup('Directory')
    highlight MatchParen       ctermbg=black       ctermfg=yellow      | call s:FormatGroup('MatchParen')

    highlight SpellBad         ctermbg=NONE        ctermfg=darkred     | call s:FormatGroup('SpellBad')
    highlight SpellCap         ctermbg=NONE        ctermfg=darkyellow  | call s:FormatGroup('SpellCap')
    highlight SpellLocal       ctermbg=NONE        ctermfg=darkgreen   | call s:FormatGroup('SpellLocal')
    highlight SpellRare        ctermbg=NONE        ctermfg=darkmagenta | call s:FormatGroup('SpellRare')

    highlight ColorColumn      ctermbg=black       ctermfg=NONE        | call s:FormatGroup('ColorColumn')
    highlight SignColumn       ctermbg=black       ctermfg=darkgray    | call s:FormatGroup('SignColumn')

    highlight QuickFixLine     ctermbg=black       ctermfg=NONE        | call s:FormatGroup('QuickFixLine')
    highlight qfLineNr         ctermbg=NONE        ctermfg=darkyellow  | call s:FormatGroup('qfLineNr')
    highlight qfFileName       ctermbg=NONE        ctermfg=darkcyan    | call s:FormatGroup('rfFileName')
    highlight qfError          ctermbg=NONE        ctermfg=red         | call s:FormatGroup('qfError')

    highlight ExtraWhitespace  ctermbg=red         ctermfg=NONE        | call s:FormatGroup('ExtraWhitespace')

    highlight DebugPC          ctermbg=blue        ctermfg=NONE        | call s:FormatGroup('DebugPC')
    highlight DebugBreakpoint  ctermbg=red         ctermfg=NONE        | call s:FormatGroup('DebugBreakpoint')

    " Markdown code.
    highlight mkdHeading       ctermbg=NONE        ctermfg=blue        | call s:FormatGroup('mkdHeading', 'bold')
    highlight htmlH1           ctermbg=NONE        ctermfg=blue        | call s:FormatGroup('htmlH1', 'bold')
    highlight mkdURL           ctermbg=NONE        ctermfg=red         | call s:FormatGroup('mkdURL')
    highlight mkdInlineURL     ctermbg=NONE        ctermfg=red         | call s:FormatGroup('mkdInlineURL')
    highlight mkdID            ctermbg=NONE        ctermfg=red         | call s:FormatGroup('mkdID')

    if get(g:, 'xapprentice_ale', 1) ==? 1
        highlight ALEError          ctermbg=lightred    ctermfg=black     | call s:FormatGroup('ALEError')
        highlight ALEErrorSign      ctermbg=black      ctermfg=lightred   | call s:FormatGroup('ALEErrorSign')
        highlight ALEErrorLine      ctermbg=NONE       ctermfg=NONE       | call s:FormatGroup('ALEErrorLine')

        highlight ALEWarning        ctermbg=darkyellow ctermfg=black      | call s:FormatGroup('ALEWarning')
        highlight ALEWarningSign    ctermbg=black      ctermfg=darkyellow | call s:FormatGroup('ALEWarningSign')
        highlight ALEWarningLine    ctermbg=NONE       ctermfg=NONE       | call s:FormatGroup('ALEWarningLine')

        highlight ALEInfo           ctermbg=darkyellow ctermfg=black      | call s:FormatGroup('ALEInfo')
        highlight ALEInfoSign       ctermbg=black      ctermfg=darkyellow | call s:FormatGroup('ALEInfoSign')
        highlight ALEInfoLine       ctermbg=NONE       ctermfg=NONE       | call s:FormatGroup('ALEInfoLine')
    else
        highlight ALEError          ctermbg=lightred    ctermfg=lightred  | call s:FormatGroup('ALEError')
        highlight ALEErrorSign      ctermbg=black      ctermfg=lightred   | call s:FormatGroup('ALEErrorSign')
        highlight ALEErrorLine      ctermbg=lightred    ctermfg=black     | call s:FormatGroup('ALEErrorLine')

        highlight ALEWarning        ctermbg=darkyellow ctermfg=black      | call s:FormatGroup('ALEWarning')
        highlight ALEWarningSign    ctermbg=black      ctermfg=darkyellow | call s:FormatGroup('ALEWarningSign')
        highlight ALEWarningLine    ctermbg=darkyellow ctermfg=black      | call s:FormatGroup('ALEWarningLine')

        highlight ALEInfo           ctermbg=darkyellow ctermfg=black      | call s:FormatGroup('ALEInfo')
        highlight ALEInfoSign       ctermbg=black      ctermfg=darkyellow | call s:FormatGroup('ALEInfoSign')
        highlight ALEInfoLine       ctermbg=darkyellow ctermfg=black      | call s:FormatGroup('ALEInfoLine')
    endif

    if get(g:, 'xapprentice_signify', 1)
        highlight SignifySignAdd    ctermbg=black ctermfg=green     | call s:FormatGroup('SignifySignAdd')
        highlight SignifySignDelete ctermbg=black ctermfg=darkred   | call s:FormatGroup('SignifySignDelete')
        highlight SignifySignChange ctermbg=black ctermfg=blue      | call s:FormatGroup('SignifySignChange')
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
        \ ['htmlItalic', 'Normal'],
        \ ['markdownHeadingDelimiter', 'htmlH1'],
        \ ['markdownCode', 'SpecialKey'],
        \ ['markdownCodeBlock', 'markdownCode'],
        \ ['markdownItalic', 'Error'],
        \ ['markdownUrl', 'PreProc'],
        \ ['markdownListMarker', 'Constant'],
        \ ['mkdURL', 'markdownUrl'],
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
