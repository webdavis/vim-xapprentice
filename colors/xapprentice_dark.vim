" Maintainer: Stephen A. Davis <stephen@webdavis.io>
" Repository: https://github.com/webdavis/vim-xapprentice.git
" Description: based on Apprentice, with a few tweaks.

if &g:compatible || v:version <? 700
    finish
endif

" sdfsfsfd
" Save the users compatible-options so that they may be restored later.
let s:save_cpoptions = &g:cpoptions
set cpoptions&vim

" Return highlight groups to default settings.
highlight clear
if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'xapprentice_dark'

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
        let s:lightyellow = '#e5c879'
    else
        let s:lightyellow = '#ffdf87'
    endif

    highlight Normal           ctermbg=235  ctermfg=250  guibg=#262626 guifg=#bcbcbc | call s:FormatGroup('Normal')
    highlight LineNr           ctermbg=234  ctermfg=242  guibg=#1c1c1c guifg=#6c6c6c | call s:FormatGroup('LineNr')
    highlight FoldColumn       ctermbg=234  ctermfg=242  guibg=#1c1c1c guifg=#6c6c6c | call s:FormatGroup('FoldColumn')
    highlight Folded           ctermbg=234  ctermfg=242  guibg=#1c1c1c guifg=#6c6c6c | call s:FormatGroup('Folded')
    highlight MatchParen       ctermbg=NONE ctermfg=132  guibg=NONE    guifg=#af5f87 | call s:FormatGroup('MatchParen')

    highlight Comment          ctermbg=NONE ctermfg=239  guibg=NONE    guifg=#4e4e4e | call s:FormatGroup('Comment')
    highlight Conceal          ctermbg=NONE ctermfg=250  guibg=NONE    guifg=#bcbcbc | call s:FormatGroup('Conceal')
    highlight Constant         ctermbg=NONE ctermfg=137  guibg=NONE    guifg=#af875f | call s:FormatGroup('Constant')
    highlight Error            ctermbg=235  ctermfg=131  guibg=#262626 guifg=#af5f5f | call s:FormatGroup('Error')
    highlight Identifier       ctermbg=NONE ctermfg=67   guibg=NONE    guifg=#5f87af | call s:FormatGroup('Identifier')
    highlight Ignore           ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE    | call s:FormatGroup('Ignore')

    highlight PreProc          ctermbg=NONE ctermfg=66   guibg=NONE    guifg=#5f8787 | call s:FormatGroup('PreProc')
    highlight Special          ctermbg=NONE ctermfg=65   guibg=NONE    guifg=#5f875f | call s:FormatGroup('Special')
    highlight Delimiter        ctermbg=NONE ctermfg=65   guibg=NONE    guifg=#5f875f | call s:FormatGroup('Delimiter')
    highlight Statement        ctermbg=NONE ctermfg=110  guibg=NONE    guifg=#8fafd7 | call s:FormatGroup('Statement')
    highlight String           ctermbg=NONE ctermfg=108  guibg=NONE    guifg=#87af87 | call s:FormatGroup('String')
    highlight Todo             ctermbg=NONE ctermfg=250  guibg=NONE    guifg=#bcbcbc | call s:FormatGroup('Todo')
    highlight Type             ctermbg=NONE ctermfg=103  guibg=NONE    guifg=#8787af | call s:FormatGroup('Type')
    highlight Underlined       ctermbg=NONE ctermfg=66   guibg=NONE    guifg=#5f8787 | call s:FormatGroup('Underlined', 'underline')

    highlight NonText          ctermbg=NONE ctermfg=240  guibg=NONE    guifg=#4e4e4e | call s:FormatGroup('NonText')

    highlight Pmenu            ctermbg=237  ctermfg=250  guibg=#3a3a3a guifg=#bcbcbc | call s:FormatGroup('Pmenu')
    highlight PmenuSbar        ctermbg=240  ctermfg=NONE guibg=#585858 guifg=NONE    | call s:FormatGroup('PmenuSbar')
    highlight PmenuSel         ctermbg=67   ctermfg=235  guibg=#5f87af guifg=#262626 | call s:FormatGroup('PmenuSel')
    highlight PmenuThumb       ctermbg=66   ctermfg=66   guibg=#5f8787 guifg=#5f8787 | call s:FormatGroup('PmenuThumb')

    " These require coc.nvim to be installed.
    if has('nvim')
        highlight CocHighlightText      ctermbg=67   ctermfg=235  guibg=#5f87af guifg=#262626 | call s:FormatGroup('CocHighlightText')
        highlight CocFloating           ctermbg=238  ctermfg=250  guibg=#444444 guifg=#bcbcbc | call s:FormatGroup('CocFloating')
        highlight CocCodeLens           ctermbg=NONE ctermfg=242  guibg=NONE    guifg=#6c6c6c | call s:FormatGroup('CocCodeLens')
        highlight CocInfoSign           ctermbg=NONE ctermfg=68   guibg=NONE    guifg=#5f87d7 | call s:FormatGroup('CocInfoSign')
        highlight CocInfoHighlight      ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE    | call s:FormatGroup('CocInfoHighlight')
        highlight CocHintSign           ctermbg=NONE ctermfg=65   guibg=NONE    guifg=#5f875f | call s:FormatGroup('CocHintSign')
        highlight CocHintHighlight      ctermbg=65   ctermfg=235  guibg=#5f875f guifg=#262626 | call s:FormatGroup('CocHintHighlight')
        execute 'highlight CocWarningSign ctermbg=NONE ctermfg=222 guibg=NONE guifg=' . s:lightyellow | call s:FormatGroup('CocWarningSign')
        execute 'highlight CocWarningHighlight ctermbg=222 ctermfg=235 guibg=' . s:lightyellow . ' guifg=#262626' | call s:FormatGroup('CocWarningHighlight')
        highlight CocErrorSign          ctermbg=NONE ctermfg=95   guibg=NONE    guifg=#875f5f | call s:FormatGroup('CocErrorSign')
        highlight CocErrorHighlight     ctermbg=95   ctermfg=234  guibg=#875f5f guifg=#1c1c1c | call s:FormatGroup('CocErrorHighlight')
        " coc-highlight.
        highlight HighlightedyankRegion ctermbg=108 ctermfg=235 guibg=#87af87 guifg=#262626 | call s:FormatGroup('HighlightedyankRegion')
    endif

    highlight ErrorMsg         ctermbg=NONE ctermfg=131  guibg=NONE    guifg=#af5f5f | call s:FormatGroup('ErrorMsg')
    highlight ModeMsg          ctermbg=108  ctermfg=235  guibg=#5f87af guifg=#262626 | call s:FormatGroup('ModeMsg')
    highlight MoreMsg          ctermbg=NONE ctermfg=66   guibg=NONE    guifg=#5f8787 | call s:FormatGroup('MoreMsg')
    highlight Question         ctermbg=NONE ctermfg=66   guibg=NONE    guifg=#5f8787 | call s:FormatGroup('Question')
    execute 'highlight WarningMsg ctermbg=NONE ctermfg=222 guibg=NONE guifg=' . s:lightyellow | call s:FormatGroup('WarningMsg')

    highlight TabLine          ctermbg=238  ctermfg=101  guibg=#444444 guifg=#878787 | call s:FormatGroup('TabLine')
    highlight TabLineFill      ctermbg=238  ctermfg=238  guibg=#444444 guifg=#444444 | call s:FormatGroup('TabLineFill')
    highlight TabLineSel       ctermbg=101  ctermfg=235  guibg=#878787 guifg=#262626 | call s:FormatGroup('TabLineSel')

    highlight Cursor           ctermbg=242  ctermfg=NONE guibg=#6c6c6c guifg=NONE    | call s:FormatGroup('Cursor')
    highlight CursorColumn     ctermbg=236  ctermfg=NONE guibg=#303030 guifg=NONE    | call s:FormatGroup('CursorColumn')
    highlight CursorLineNr     ctermbg=236  ctermfg=73   guibg=#303030 guifg=#5fafaf | call s:FormatGroup('CursorLineNr')
    highlight CursorLine       ctermbg=236  ctermfg=NONE guibg=#303030 guifg=NONE    | call s:FormatGroup('CursorLine')

    highlight helpLeadBlank    ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE    | call s:FormatGroup('helpLeadBlank')
    highlight helpNormal       ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE    | call s:FormatGroup('helpNormal')

    highlight StatusLine       ctermbg=240  ctermfg=252  guibg=#585858 guifg=#d0d0d0 | call s:FormatGroup('StatusLine')
    highlight StatusLineNC     ctermbg=238  ctermfg=101  guibg=#444444 guifg=#878787 | call s:FormatGroup('StatusLineNC')

    highlight StatusLineTerm   ctermbg=101  ctermfg=234  guibg=#af875f guifg=#1c1c1c | call s:FormatGroup('StatusLineTerm')
    highlight StatusLineTermNC ctermbg=238  ctermfg=101  guibg=#444444 guifg=#878787 | call s:FormatGroup('StatusLineTermNC')

    highlight Visual           ctermbg=110  ctermfg=235  guibg=#8fafd7 guifg=#262626 | call s:FormatGroup('Visual')
    highlight VisualNOS        ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE    | call s:FormatGroup('VisualNOS')

    highlight VertSplit        ctermbg=238  ctermfg=238  guibg=#444444 guifg=#444444 | call s:FormatGroup('VertSplit')
    highlight WildMenu         ctermbg=131  ctermfg=235  guibg=#5f87af guifg=#262626 | call s:FormatGroup('WildMenu')

    highlight Function         ctermbg=NONE ctermfg=250  guibg=NONE    guifg=#bcbcbc | call s:FormatGroup('Function')
    highlight SpecialKey       ctermbg=NONE ctermfg=240  guibg=NONE    guifg=#585858 | call s:FormatGroup('SpecialKey')
    highlight Title            ctermbg=NONE ctermfg=231  guibg=NONE    guifg=#ffffdf | call s:FormatGroup('Title')

    highlight DiffAdd          ctermbg=108  ctermfg=235  guibg=#87af87 guifg=#262626 | call s:FormatGroup('DiffAdd')
    highlight DiffChange       ctermbg=67   ctermfg=235  guibg=#5f87af guifg=#262626 | call s:FormatGroup('DiffChange')
    highlight DiffDelete       ctermbg=131  ctermfg=235  guibg=#af5f5f guifg=#262626 | call s:FormatGroup('DiffDelete')
    highlight DiffText         ctermbg=172  ctermfg=235  guibg=#d78700 guifg=#262626 | call s:FormatGroup('DiffText')

    highlight IncSearch        ctermbg=131  ctermfg=235  guibg=#af5f5f guifg=#262626 | call s:FormatGroup('IncSearch')
    highlight Search           ctermbg=223  ctermfg=235  guibg=#bcbcbc guifg=#262626 | call s:FormatGroup('Search')

    highlight Directory        ctermbg=NONE ctermfg=67   guibg=NONE    guifg=#5f87af | call s:FormatGroup('Directory')

    highlight SignColumn       ctermbg=234  ctermfg=242  guibg=#1c1c1c guifg=#6c6c6c | call s:FormatGroup('SignColumn')
    highlight ColorColumn      ctermbg=234  ctermfg=NONE guibg=#1c1c1c guifg=NONE    | call s:FormatGroup('ColorColumn')

    highlight QuickFixLine     ctermbg=236  ctermfg=NONE guibg=#303030 guifg=NONE    | call s:FormatGroup('QuickFixLine')
    highlight qfLineNr         ctermbg=NONE ctermfg=137  guibg=NONE    guifg=#af875f | call s:FormatGroup('qfLineNr')
    highlight qfFileName       ctermbg=NONE ctermfg=67   guibg=NONE    guifg=#5f87af | call s:FormatGroup('rfFileName')
    highlight qfError          ctermbg=NONE ctermfg=131  guibg=NONE    guifg=#af5f5f | call s:FormatGroup('qfError')

    highlight ExtraWhitespace  ctermbg=132  ctermfg=NONE guibg=#af5f87 guifg=NONE    | call s:FormatGroup('ExtraWhitespace')

    highlight DebugPC          ctermbg=67   ctermfg=NONE guibg=#5f87af guifg=NONE    | call s:FormatGroup('DebugPC')
    highlight DebugBreakpoint  ctermbg=131  ctermfg=NONE guibg=#af5f5f guifg=NONE    | call s:FormatGroup('DebugBreakpoint')

    " HTML
    highlight htmlH1           ctermbg=NONE ctermfg=67   guibg=NONE    guifg=#5f87af | call s:FormatGroup('htmlH1', 'bold')

    if has('gui_running')
        highlight SpellBad          ctermbg=230  ctermfg=250  guibg=NONE    guifg=#bcbcbc guisp=#af5f87 | call s:FormatGroup('SpellBad', 'undercurl')
        highlight SpellCap          ctermbg=73   ctermfg=250  guibg=NONE    guifg=#bcbcbc guisp=#5fafaf | call s:FormatGroup('SpellCap', 'undercurl')
        highlight SpellLocal        ctermbg=65   ctermfg=250  guibg=NONE    guifg=#bcbcbc guisp=#5f875f | call s:FormatGroup('SpellLocal', 'undercurl')
        highlight SpellRare         ctermbg=172  ctermfg=250  guibg=NONE    guifg=#bcbcbc guisp=#d78700 | call s:FormatGroup('SpellRare', 'undercurl')
    else
        highlight SpellBad          ctermbg=132  ctermfg=234  guibg=#af5f87 guifg=#1c1c1c guisp=NONE    | call s:FormatGroup('SpellBad', 'undercurl')
        highlight SpellCap          ctermbg=73   ctermfg=234  guibg=#5fafaf guifg=#1c1c1c guisp=NONE    | call s:FormatGroup('SpellCap', 'undercurl')
        highlight SpellLocal        ctermbg=65   ctermfg=234  guibg=#5f875f guifg=#1c1c1c guisp=NONE    | call s:FormatGroup('SpellLocal', 'undercurl')
        highlight SpellRare         ctermbg=172  ctermfg=234  guibg=#d78700 guifg=#1c1c1c guisp=NONE    | call s:FormatGroup('SpellRare', 'undercurl')
    endif

    if get(g:, 'xapprentice_ale', 1) ==? 1
        highlight ALEError          ctermbg=131  ctermfg=235  guibg=#af5f5f guifg=#262626  | call s:FormatGroup('ALEError')
        highlight ALEErrorSign      ctermbg=234  ctermfg=131  guibg=#1c1c1c guifg=#af5f5f  | call s:FormatGroup('ALEErrorSign')
        highlight ALEErrorLine      ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE     | call s:FormatGroup('ALEErrorLine')

        execute 'highlight ALEWarning ctermbg=222 ctermfg=235 guibg=' . s:lightyellow . ' guifg=#262626' | call s:FormatGroup('ALEWarning')
        execute 'highlight ALEWarningSign ctermbg=234 ctermfg=222 guibg=#1c1c1c guifg=' s:lightyellow | call s:FormatGroup('ALEWarningSign')
        highlight ALEWarningLine    ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE     | call s:FormatGroup('ALEWarningLine')

        highlight ALEInfo           ctermbg=68   ctermfg=235  guibg=#5f87d7 guifg=#262626  | call s:FormatGroup('ALEInfo')
        highlight ALEInfoSign       ctermbg=234  ctermfg=68   guibg=#1c1c1c guifg=#5f87d7  | call s:FormatGroup('ALEInfoSign')
        highlight ALEInfoLine       ctermbg=NONE ctermfg=NONE guibg=NONE    guifg=NONE     | call s:FormatGroup('ALEInfoLine')
    else
        highlight ALEError          ctermbg=131  ctermfg=131  guibg=#af5f5f guifg=#262626  | call s:FormatGroup('ALEError')
        highlight ALEErrorSign      ctermbg=235  ctermfg=131  guibg=#1c1c1c guifg=#af5f5f  | call s:FormatGroup('ALEErrorSign')
        highlight ALEErrorLine      ctermbg=131  ctermfg=235  guibg=#af5f5f guifg=#262626  | call s:FormatGroup('ALEErrorLine')

        execute 'highlight ALEWarning ctermbg=222 ctermfg=235 guibg=' . s:lightyellow . ' guifg=#262626' | call s:FormatGroup('ALEWarning')
        execute 'highlight ALEWarningSign ctermbg=235 ctermfg=222 guibg=#1c1c1c guifg=' . s:lightyellow | call s:FormatGroup('ALEWarningSign')
        execute 'highlight ALEWarningLine ctermbg=222 ctermfg=235 guibg=' . s:lightyellow . ' guifg=#262626' | call s:FormatGroup('ALEWarningLine')

        highlight ALEInfo           ctermbg=68   ctermfg=235  guibg=#5f87d7 guifg=#262626  | call s:FormatGroup('ALEInfo')
        highlight ALEInfoSign       ctermbg=235  ctermfg=68   guibg=#1c1c1c guifg=#5f87d7  | call s:FormatGroup('ALEInfoSign')
        highlight ALEInfoLine       ctermbg=68   ctermfg=235  guibg=#5f87d7 guifg=#262626  | call s:FormatGroup('ALEInfoLine')
    endif

    if get(g:, 'xapprentice_signify', 1)
        highlight SignifySignAdd    ctermbg=234  ctermfg=65   guibg=#1c1c1c guifg=#5f875f  | call s:FormatGroup('SignifySignAdd')
        highlight SignifySignDelete ctermbg=234  ctermfg=132  guibg=#1c1c1c guifg=#af5f87  | call s:FormatGroup('SignifySignDelete')
        highlight SignifySignChange ctermbg=234  ctermfg=67   guibg=#1c1c1c guifg=#5f87af  | call s:FormatGroup('SignifySignChange')
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
        \ '#1c1c1c',
        \ '#af5f5f',
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
        \ '#8fafd7',
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
        \ ['htmlBold', 'Normal'],
        \ ['htmlItalic', 'Error'],
        \ ['markdownHeadingDelimiter', 'htmlH1'],
        \ ['markdownCode', 'SpecialKey'],
        \ ['markdownCodeBlock', 'markdownCode'],
        \ ['markdownItalic', 'Error'],
        \ ['markdownUrl', 'PreProc'],
        \ ['markdownListMarker', 'Constant'],
        \ ['mkdURL', 'markdownUrl'],
        \ ['mkdHeading', 'htmlH1'],
        \ ['mkdListItem', 'Constant'],
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
        \ ['diffRemoved', 'ErrorMsg'],
        \ ['diffAdded', 'String'],
        \ ]

augroup Apprentice
    autocmd!
    autocmd ColorScheme * if expand('<amatch>') =~# 'xapprentice_dark'
                            \ | for link in s:links | execute 'hi link' link[0] link[1] | endfor
                            \ | else | for link in s:links | execute 'hi link' link[0] 'NONE' | endfor
                            \ | endif
augroup END

" Restore the previously saved compatible options.
let &g:cpoptions = s:save_cpoptions
unlet! s:save_cpoptions
