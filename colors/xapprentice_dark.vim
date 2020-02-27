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

if $TERM =~? '256' || &t_Co >= 256 || has('gui_running')
  set background=dark

  if (exists('$COLORTERM') && $COLORTERM =~? 'truecolor' && has('termguicolors') && &g:termguicolors)
    let s:background = '#232627'
    let s:black = '#1c1e1f'
    let s:lightyellow = '#ceb46c'
    let s:darkyellow = '#b29c5e'
    let s:spacegray = '#2e3442'
    let s:silver = '#7a7a7a'
    let s:chrome = '#31363b'
    let s:metal = '#656767'
    let s:tint = '#323536'
  else
    let s:background = '#262626'
    let s:black = '#1c1c1c'
    let s:lightyellow = '#ffdf87'
    let s:darkyellow = '#ffdf87'
    let s:spacegray = '#3a3a3a'
    let s:silver = '#6c6c6c'
    let s:chrome = '#3a3a3a'
    let s:metal = '#626262'
    let s:tint = '#303030'
  endif

  execute 'highlight Normal           ctermbg=235  ctermfg=250  guibg='.s:background.' guifg=#bcbcbc'        | call format#FormatHighlightGroup('Normal')
  execute 'highlight LineNr           ctermbg=234  ctermfg=242  guibg='.s:black.'      guifg='.s:silver      | call format#FormatHighlightGroup('LineNr')
  execute 'highlight FoldColumn       ctermbg=234  ctermfg=242  guibg='.s:black.'      guifg='.s:silver      | call format#FormatHighlightGroup('FoldColumn')
  execute 'highlight Folded           ctermbg=234  ctermfg=242  guibg='.s:black.'      guifg='.s:silver      | call format#FormatHighlightGroup('Folded')
           highlight MatchParen       ctermbg=NONE ctermfg=132  guibg=NONE             guifg=#af5f87         | call format#FormatHighlightGroup('MatchParen')
           highlight Comment          ctermbg=NONE ctermfg=242  guibg=NONE             guifg=#6c6c6c         | call format#FormatHighlightGroup('Comment')
           highlight Conceal          ctermbg=NONE ctermfg=250  guibg=NONE             guifg=#bcbcbc         | call format#FormatHighlightGroup('Conceal')
           highlight Constant         ctermbg=NONE ctermfg=137  guibg=NONE             guifg=#af875f         | call format#FormatHighlightGroup('Constant')
           highlight Error            ctermbg=NONE ctermfg=131  guibg=NONE             guifg=#af5f5f         | call format#FormatHighlightGroup('Error')
           highlight Identifier       ctermbg=NONE ctermfg=67   guibg=NONE             guifg=#5f87af         | call format#FormatHighlightGroup('Identifier')
           highlight Ignore           ctermbg=NONE ctermfg=NONE guibg=NONE             guifg=NONE            | call format#FormatHighlightGroup('Ignore')
           highlight PreProc          ctermbg=NONE ctermfg=66   guibg=NONE             guifg=#5f8787         | call format#FormatHighlightGroup('PreProc')
           highlight Special          ctermbg=NONE ctermfg=65   guibg=NONE             guifg=#5f875f         | call format#FormatHighlightGroup('Special')
           highlight Delimiter        ctermbg=NONE ctermfg=65   guibg=NONE             guifg=#5f875f         | call format#FormatHighlightGroup('Delimiter')
           highlight Statement        ctermbg=NONE ctermfg=110  guibg=NONE             guifg=#8fafd7         | call format#FormatHighlightGroup('Statement')
           highlight String           ctermbg=NONE ctermfg=108  guibg=NONE             guifg=#87af87         | call format#FormatHighlightGroup('String')
           highlight Todo             ctermbg=NONE ctermfg=250  guibg=NONE             guifg=#bcbcbc         | call format#FormatHighlightGroup('Todo')
           highlight Type             ctermbg=NONE ctermfg=103  guibg=NONE             guifg=#8787af         | call format#FormatHighlightGroup('Type')
           highlight Underlined       ctermbg=NONE ctermfg=66   guibg=NONE             guifg=#5f8787         | call format#FormatHighlightGroup('Underlined', 'underline')
           highlight NonText          ctermbg=NONE ctermfg=239  guibg=NONE             guifg=#4e4e4e         | call format#FormatHighlightGroup('NonText')
  execute 'highlight Pmenu            ctermbg=237  ctermfg=250  guibg='.s:chrome.'     guifg=#bcbcbc'        | call format#FormatHighlightGroup('Pmenu')
           highlight PmenuSbar        ctermbg=241  ctermfg=NONE guibg=#626262          guifg=NONE            | call format#FormatHighlightGroup('PmenuSbar')
           highlight PmenuSel         ctermbg=96   ctermfg=232  guibg=#875f87          guifg=#080808         | call format#FormatHighlightGroup('PmenuSel')
           highlight PmenuThumb       ctermbg=66   ctermfg=66   guibg=#9e9e9e          guifg=#9e9e9e         | call format#FormatHighlightGroup('PmenuThumb')
           highlight ErrorMsg         ctermbg=NONE ctermfg=131  guibg=NONE             guifg=#af5f5f         | call format#FormatHighlightGroup('ErrorMsg')
  execute 'highlight ModeMsg          ctermbg=108  ctermfg=235  guibg=#5f87af          guifg='.s:background  | call format#FormatHighlightGroup('ModeMsg')
           highlight MoreMsg          ctermbg=NONE ctermfg=66   guibg=NONE             guifg=#5f8787         | call format#FormatHighlightGroup('MoreMsg')
           highlight Question         ctermbg=NONE ctermfg=66   guibg=NONE             guifg=#5f8787         | call format#FormatHighlightGroup('Question')
  execute 'highlight WarningMsg       ctermbg=NONE ctermfg=222  guibg=NONE             guifg='.s:lightyellow | call format#FormatHighlightGroup('WarningMsg')
           highlight TabLine          ctermbg=238  ctermfg=246  guibg=#444444          guifg=#949494         | call format#FormatHighlightGroup('TabLine')
           highlight TabLineFill      ctermbg=238  ctermfg=250  guibg=#444444          guifg=#bcbcbc         | call format#FormatHighlightGroup('TabLineFill')
           highlight TabLineSel       ctermbg=65   ctermfg=0    guibg=#5f8787          guifg=#000000         | call format#FormatHighlightGroup('TabLineSel')
           highlight Cursor           ctermbg=242  ctermfg=NONE guibg=#6c6c6c          guifg=NONE            | call format#FormatHighlightGroup('Cursor')
  execute 'highlight CursorColumn     ctermbg=236  ctermfg=NONE guibg='.s:tint.'       guifg=NONE'           | call format#FormatHighlightGroup('CursorColumn')
  execute 'highlight CursorLineNr     ctermbg=236  ctermfg=73   guibg='.s:tint.'       guifg=#5fafaf'        | call format#FormatHighlightGroup('CursorLineNr')
  execute 'highlight CursorLine       ctermbg=236  ctermfg=NONE guibg='.s:tint.'       guifg=NONE'           | call format#FormatHighlightGroup('CursorLine')
           highlight helpLeadBlank    ctermbg=NONE ctermfg=NONE guibg=NONE             guifg=NONE            | call format#FormatHighlightGroup('helpLeadBlank')
           highlight helpNormal       ctermbg=NONE ctermfg=NONE guibg=NONE             guifg=NONE            | call format#FormatHighlightGroup('helpNormal')
           highlight StatusLine       ctermbg=238  ctermfg=250  guibg=#444444          guifg=#bcbcbc         | call format#FormatHighlightGroup('StatusLine')
           highlight StatusLineNC     ctermbg=238  ctermfg=101  guibg=#444444          guifg=#878787         | call format#FormatHighlightGroup('StatusLineNC')
  execute 'highlight StatusLineTerm   ctermbg=101  ctermfg=234  guibg=#af875f          guifg='.s:black       | call format#FormatHighlightGroup('StatusLineTerm')
           highlight StatusLineTermNC ctermbg=238  ctermfg=101  guibg=#444444          guifg=#878787         | call format#FormatHighlightGroup('StatusLineTermNC')
  execute 'highlight Visual           ctermbg=103  ctermfg=235  guibg=#8787af          guifg='.s:background  | call format#FormatHighlightGroup('Visual')
           highlight VisualNOS        ctermbg=NONE ctermfg=NONE guibg=NONE             guifg=NONE            | call format#FormatHighlightGroup('VisualNOS')
           highlight VertSplit        ctermbg=238  ctermfg=238  guibg=#444444          guifg=#444444         | call format#FormatHighlightGroup('VertSplit')
  execute 'highlight WildMenu         ctermbg=131  ctermfg=235  guibg=#5f87af          guifg='.s:background  | call format#FormatHighlightGroup('WildMenu')
           highlight Function         ctermbg=NONE ctermfg=250  guibg=NONE             guifg=#bcbcbc         | call format#FormatHighlightGroup('Function')
           highlight SpecialKey       ctermbg=NONE ctermfg=241  guibg=NONE             guifg=#626262         | call format#FormatHighlightGroup('SpecialKey')
           highlight Title            ctermbg=NONE ctermfg=231  guibg=NONE             guifg=#ffffdf         | call format#FormatHighlightGroup('Title')
  execute 'highlight DiffAdd          ctermbg=108  ctermfg=235  guibg=#87af87          guifg='.s:background  | call format#FormatHighlightGroup('DiffAdd')
  execute 'highlight DiffChange       ctermbg=67   ctermfg=235  guibg=#5f87af          guifg='.s:background  | call format#FormatHighlightGroup('DiffChange')
  execute 'highlight DiffDelete       ctermbg=131  ctermfg=235  guibg=#af5f5f          guifg='.s:background  | call format#FormatHighlightGroup('DiffDelete')
  execute 'highlight DiffText         ctermbg=172  ctermfg=235  guibg=#d78700          guifg='.s:background  | call format#FormatHighlightGroup('DiffText')
  execute 'highlight IncSearch        ctermbg=131  ctermfg=235  guibg=#af5f5f          guifg='.s:background  | call format#FormatHighlightGroup('IncSearch')
  execute 'highlight Search           ctermbg=223  ctermfg=235  guibg=#bcbcbc          guifg='.s:background  | call format#FormatHighlightGroup('Search')
           highlight Directory        ctermbg=NONE ctermfg=67   guibg=NONE             guifg=#5f87af         | call format#FormatHighlightGroup('Directory')
  execute 'highlight SignColumn       ctermbg=234  ctermfg=242  guibg='.s:black.'      guifg=#6c6c6c'        | call format#FormatHighlightGroup('SignColumn')
  execute 'highlight ColorColumn      ctermbg=234  ctermfg=NONE guibg='.s:black.'      guifg=NONE'           | call format#FormatHighlightGroup('ColorColumn')
           highlight QuickFixLine     ctermbg=236  ctermfg=NONE guibg=#303030          guifg=NONE            | call format#FormatHighlightGroup('QuickFixLine')
           highlight qfLineNr         ctermbg=NONE ctermfg=137  guibg=NONE             guifg=#af875f         | call format#FormatHighlightGroup('qfLineNr')
           highlight qfFileName       ctermbg=NONE ctermfg=67   guibg=NONE             guifg=#5f87af         | call format#FormatHighlightGroup('rfFileName')
           highlight qfError          ctermbg=NONE ctermfg=131  guibg=NONE             guifg=#af5f5f         | call format#FormatHighlightGroup('qfError')
           highlight ExtraWhitespace  ctermbg=132  ctermfg=NONE guibg=#af5f87          guifg=NONE            | call format#FormatHighlightGroup('ExtraWhitespace')
           highlight DebugPC          ctermbg=67   ctermfg=NONE guibg=#5f87af          guifg=NONE            | call format#FormatHighlightGroup('DebugPC')
           highlight DebugBreakpoint  ctermbg=131  ctermfg=NONE guibg=#af5f5f          guifg=NONE            | call format#FormatHighlightGroup('DebugBreakpoint')
           " HTML
           highlight htmlH1           ctermbg=NONE ctermfg=67   guibg=NONE             guifg=#5f87af         | call format#FormatHighlightGroup('htmlH1', 'bold')
  execute 'highlight htmlBold         ctermbg=NONE ctermfg=222  guibg=NONE             guifg='.s:lightyellow | call format#FormatHighlightGroup('htmlBold', 'bold')

  if get(g:, 'xapprentice_ale', 1) ==? 1
    execute 'highlight ALEError              ctermbg=131  ctermfg=235   guibg=#af5f5f           guifg='.s:background  | call format#FormatHighlightGroup('ALEError')
    execute 'highlight ALEErrorSign          ctermbg=234  ctermfg=131   guibg='.s:black.'       guifg=#af5f5f'        | call format#FormatHighlightGroup('ALEErrorSign')
             highlight ALEErrorLine          ctermbg=NONE ctermfg=NONE  guibg=NONE              guifg=NONE            | call format#FormatHighlightGroup('ALEErrorLine')
    execute 'highlight ALEWarning            ctermbg=222  ctermfg=235   guibg='.s:lightyellow.' guifg='.s:background  | call format#FormatHighlightGroup('ALEWarning')
    execute 'highlight ALEWarningSign        ctermbg=234  ctermfg=222   guibg='.s:black.'       guifg='.s:lightyellow | call format#FormatHighlightGroup('ALEWarningSign')
             highlight ALEWarningLine        ctermbg=NONE ctermfg=NONE  guibg=NONE              guifg=NONE            | call format#FormatHighlightGroup('ALEWarningLine')
    execute 'highlight ALEInfo               ctermbg=68   ctermfg=235   guibg=#5f87d7           guifg='.s:background  | call format#FormatHighlightGroup('ALEInfo')
    execute 'highlight ALEInfoSign           ctermbg=234  ctermfg=68    guibg='.s:black.'       guifg=#5f87d7'        | call format#FormatHighlightGroup('ALEInfoSign')
             highlight ALEInfoLine           ctermbg=NONE ctermfg=NONE  guibg=NONE              guifg=NONE            | call format#FormatHighlightGroup('ALEInfoLine')
  else
    execute 'highlight ALEError              ctermbg=131  ctermfg=131   guibg=#af5f5f           guifg='.s:background  | call format#FormatHighlightGroup('ALEError')
    execute 'highlight ALEErrorSign          ctermbg=235  ctermfg=131   guibg='.s:black.'       guifg=#af5f5f'        | call format#FormatHighlightGroup('ALEErrorSign')
    execute 'highlight ALEErrorLine          ctermbg=131  ctermfg=235   guibg=#af5f5f           guifg='.s:background  | call format#FormatHighlightGroup('ALEErrorLine')
    execute 'highlight ALEWarning            ctermbg=222  ctermfg=235   guibg='.s:lightyellow.' guifg='.s:background  | call format#FormatHighlightGroup('ALEWarning')
    execute 'highlight ALEWarningSign        ctermbg=235  ctermfg=222   guibg='.s:black.'       guifg='.s:lightyellow | call format#FormatHighlightGroup('ALEWarningSign')
    execute 'highlight ALEWarningLine        ctermbg=222  ctermfg=235   guibg='.s:lightyellow.' guifg='.s:background  | call format#FormatHighlightGroup('ALEWarningLine')
    execute 'highlight ALEInfo               ctermbg=68   ctermfg=235   guibg=#5f87d7           guifg='.s:background  | call format#FormatHighlightGroup('ALEInfo')
    execute 'highlight ALEInfoSign           ctermbg=235  ctermfg=68    guibg='.s:black.'       guifg=#5f87d7'        | call format#FormatHighlightGroup('ALEInfoSign')
    execute 'highlight ALEInfoLine           ctermbg=68   ctermfg=235   guibg=#5f87d7           guifg='.s:background  | call format#FormatHighlightGroup('ALEInfoLine')
  endif

  " Requires neoclide/coc.nvim to be loaded.
  if exists('g:did_coc_loaded')
             highlight CocHighlightText      ctermbg=235  ctermfg=32    guibg=NONE              guifg=#0087d7         | call format#FormatHighlightGroup('CocHighlightText')
    execute 'highlight CocFloating           ctermbg=237  ctermfg=250   guibg='.s:spacegray.'   guifg=#bcbcbc'        | call format#FormatHighlightGroup('CocFloating')
    execute 'highlight CocCodeLens           ctermbg=NONE ctermfg=241   guibg=NONE              guifg='.s:metal       | call format#FormatHighlightGroup('CocCodeLens')
    execute 'highlight CocInfoSign           ctermbg=234  ctermfg=68    guibg='.s:black.'       guifg=#5f87d7'        | call format#FormatHighlightGroup('CocInfoSign')
             highlight CocInfoVirtualText    ctermbg=NONE ctermfg=68    guibg=NONE              guifg=#5f87d7         | call format#FormatHighlightGroup('CocInfoVirtualText')
             highlight CocInfoHighlight      ctermbg=NONE ctermfg=NONE  guibg=NONE              guifg=NONE            | call format#FormatHighlightGroup('CocInfoHighlight')
    execute 'highlight CocHintSign           ctermbg=234  ctermfg=65    guibg='.s:black.'       guifg=#5f875f'        | call format#FormatHighlightGroup('CocHintSign')
             highlight CocHintVirtualText    ctermbg=NONE ctermfg=65    guibg=NONE              guifg=#5f875f         | call format#FormatHighlightGroup('CocHintVirtualText')
             highlight CocHintHighlight      ctermbg=65   ctermfg=0     guibg=#5f875f           guifg=#000000         | call format#FormatHighlightGroup('CocHintHighlight')
    execute 'highlight CocWarningSign        ctermbg=234  ctermfg=222   guibg='.s:black.'       guifg='.s:lightyellow | call format#FormatHighlightGroup('CocWarningSign')
    execute 'highlight CocWarningVirtualText ctermbg=NONE ctermfg=222   guibg=NONE              guifg='.s:lightyellow | call format#FormatHighlightGroup('CocWarningVirtualText')
    execute 'highlight CocWarningHighlight   ctermbg=222  ctermfg=0     guibg='.s:darkyellow.'  guifg=#000000'        | call format#FormatHighlightGroup('CocWarningHighlight')
    execute 'highlight CocErrorSign          ctermbg=234  ctermfg=95    guibg='.s:black.'       guifg=#875f5f'        | call format#FormatHighlightGroup('CocErrorSign')
             highlight CocErrorVirtualText   ctermbg=NONE ctermfg=95    guibg=NONE              guifg=#875f5f         | call format#FormatHighlightGroup('CocErrorVirtualText')
             highlight CocErrorHighlight     ctermbg=95   ctermfg=232   guibg=#875f5f           guifg=#080808         | call format#FormatHighlightGroup('CocErrorHighlight')
    " Requires the extension coc-highlight.
    execute 'highlight HighlightedyankRegion ctermbg=108  ctermfg=235   guibg=#87af87           guifg='.s:background  | call format#FormatHighlightGroup('HighlightedyankRegion')

    " Requires the extension coc-git.
    execute 'highlight CocAddedSign          ctermbg=234  ctermfg=65    guibg='.s:black.'       guifg=#5f875f'        | call format#FormatHighlightGroup('CocAddedSign')
    execute 'highlight CocRemovedSign        ctermbg=234  ctermfg=132   guibg='.s:black.'       guifg=#af5f87'        | call format#FormatHighlightGroup('CocRemovedSign')
    execute 'highlight CocChangedSign        ctermbg=234  ctermfg=67    guibg='.s:black.'       guifg=#5f87af'        | call format#FormatHighlightGroup('CocChangedSign')
             highlight link CocTopRemovedSign    CocRemovedSign
             highlight link CocChangeRemovedSign CocChangedSign
  endif

  " Requires unblevable/quick-scope to be loaded.
  if exists('g:loaded_quick_scope')
             highlight QuickScopePrimary     ctermbg=NONE ctermfg=15    guibg=NONE              guifg=#ffffff         | call format#FormatHighlightGroup('QuickScopePrimary', 'bold')
             highlight QuickScopeSecondary   ctermbg=NONE ctermfg=209   guibg=NONE              guifg=#ff875f         | call format#FormatHighlightGroup('QuickScopeSecondary', 'bold')
  endif

  " Requires mhinz/vim-signify to be loaded.
  if get(g:, 'xapprentice_signify', 1)
    execute 'highlight SignifySignAdd        ctermbg=234  ctermfg=65    guibg='.s:black.'       guifg=#5f875f'        | call format#FormatHighlightGroup('SignifySignAdd')
    execute 'highlight SignifySignDelete     ctermbg=234  ctermfg=132   guibg='.s:black.'       guifg=#af5f87'        | call format#FormatHighlightGroup('SignifySignDelete')
    execute 'highlight SignifySignChange     ctermbg=234  ctermfg=67    guibg='.s:black.'       guifg=#5f87af'        | call format#FormatHighlightGroup('SignifySignChange')
             highlight link SignifySignDeleteFirstLine SignifySignDelete
             highlight link SignifySignChangeDelete    SignifySignChange
  else
             highlight link SignifySignAdd             DiffAdd
             highlight link SignifySignDelete          DiffDelete
             highlight link SignifySignDeleteFirstLine SignifySignDelete
             highlight link SignifySignChange          DiffChange
             highlight link SignifySignChangeDelete    SignifySignChange
  endif

  " Requires ntpeters/vim-better-whitespace to be loaded.
  if exists("g:loaded_better_whitespace_plugin")
    let g:better_whitespace_ctermcolor = '95'
    let g:better_whitespace_guicolor = '#875f5f'
  endif

  " Requires Yggdroot/LeaderF to be loaded.
  if exists('g:leaderf_loaded')
    execute 'highlight      Lf_hl_popup_inputText    ctermbg=237  ctermfg=250  guibg='.s:chrome.' guifg=#bcbcbc'
    execute 'highlight      Lf_hl_popup_window       ctermbg=237  ctermfg=250  guibg='.s:chrome.' guifg=#bcbcbc'
    execute 'highlight      Lf_hl_popup_blank        ctermbg=237  ctermfg=250  guibg='.s:chrome.' guifg=#bcbcbc'
             highlight      Lf_hl_popup_cursor       ctermbg=242  ctermfg=NONE guibg=#6c6c6c      guifg=NONE    
             highlight      Lf_hl_popup_prompt       ctermbg=NONE ctermfg=172  guibg=NONE         guifg=#d78700 
             highlight      Lf_hl_popup_lineInfo     ctermbg=188  ctermfg=237  guibg=#dfdfdf      guifg=#3a3a3a 
             highlight      Lf_hl_popup_total        ctermbg=66   ctermfg=232  guibg=#5f8787      guifg=#080808 
             highlight      Lf_hl_popup_spin         ctermbg=NONE ctermfg=131  guibg=NONE         guifg=#af5f5f
             highlight      Lf_hl_cursorline         ctermbg=NONE ctermfg=220  guibg=NONE         guifg=#ffdf00 
             highlight      Lf_hl_selection          ctermbg=72   ctermfg=NONE guibg=#5faf87      guifg=#080808
             highlight      Lf_hl_match              ctermbg=NONE ctermfg=42   guibg=NONE         guifg=#00d787
             highlight      Lf_hl_match0             ctermbg=NONE ctermfg=48   guibg=NONE         guifg=SpringGreen
             highlight      Lf_hl_match1             ctermbg=NONE ctermfg=214  guibg=NONE         guifg=#ffaf00 
             highlight      Lf_hl_match2             ctermbg=NONE ctermfg=81   guibg=NONE         guifg=#5fd7ff 
             highlight      Lf_hl_match3             ctermbg=NONE ctermfg=203  guibg=NONE         guifg=#ff7272 
             highlight      Lf_hl_match4             ctermbg=NONE ctermfg=133  guibg=NONE         guifg=#af5faf 
             highlight      Lf_hl_match4             ctermbg=NONE ctermfg=133  guibg=NONE         guifg=#af5faf 
             highlight      Lf_hl_popup_normalMode   ctermbg=145  ctermfg=232  guibg=#afafaf      guifg=#080808 
             highlight      Lf_hl_popup_inputMode    ctermbg=232  ctermfg=110  guibg=#8fafd7      guifg=#080808 
             highlight      Lf_hl_popup_category     ctermbg=240  ctermfg=253  guibg=#585858      guifg=#dadada 
             highlight      Lf_hl_popup_fuzzyMode    ctermbg=248  ctermfg=234  guibg=#a8a8a8      guifg=#1c1c1c 
             highlight      Lf_hl_popup_nameOnlyMode ctermbg=179  ctermfg=232  guibg=#cbb370      guifg=#080808 
             highlight      Lf_hl_popup_fullPathMode ctermbg=248  ctermfg=234  guibg=#a8a8a8      guifg=#1c1c1c 
             highlight      Lf_hl_popup_regexMode    ctermbg=108  ctermfg=232  guibg=#87af87      guifg=#080808 
             highlight      Lf_hl_popup_cwd          ctermbg=252  ctermfg=234  guibg=#d0d0d0      guifg=#1c1c1c 
             highlight link Lf_hl_bufNumber          Constant
             highlight link Lf_hl_bufIndicators      Statement
             highlight link Lf_hl_bufModified        String
             highlight link Lf_hl_bufNomodifiable    Comment
             highlight link Lf_hl_bufDirname         Directory
             highlight      Lf_hl_matchRefine        ctermbg=NONE ctermfg=132  guibg=NONE         guifg=#af5f87
             highlight link Lf_hl_help               Comment
             highlight link Lf_hl_helpCmd            Identifier
             highlight link Lf_hl_tagFile            Directory
             highlight link Lf_hl_tagType            Type
             highlight link Lf_hl_tagKeyword         Keyword
             highlight link Lf_hl_buftagKind         Title
             highlight link Lf_hl_buftagScopeType    Keyword
             highlight link Lf_hl_buftagScope        Type
             highlight link Lf_hl_buftagDirname      Directory
             highlight link Lf_hl_buftagLineNum      Constant
             highlight link Lf_hl_buftagCode         Comment
             highlight link Lf_hl_funcKind           Title
             highlight link Lf_hl_funcReturnType     Type
             highlight link Lf_hl_funcScope          Keyword
             highlight link Lf_hl_funcName           Function
             highlight link Lf_hl_funcDirname        Directory
             highlight link Lf_hl_funcLineNum        Constant
             highlight link Lf_hl_lineLocation       Comment
             highlight link Lf_hl_selfIndex          Constant
             highlight link Lf_hl_selfDescription    Comment
             highlight link Lf_hl_helpTagfile        Comment
             highlight link Lf_hl_rgFileName         Directory
             highlight link Lf_hl_rgLineNumber       Constant
             highlight link Lf_hl_rgLineNumber2      Folded
             highlight link Lf_hl_rgColumnNumber     Constant
             highlight      Lf_hl_rgHighlight        ctermbg=NONE ctermfg=232  guibg=#5f8787      guifg=#080808
             highlight link Lf_hl_gtagsFileName      Directory
             highlight link Lf_hl_gtagsLineNumber    Constant
             highlight      Lf_hl_gtagsHighlight     ctermbg=NONE ctermfg=66   guibg=NONE         guifg=#5f8787
             highlight link Lf_hl_previewTitle       Statusline
  endif

  if has('gui_running')
             highlight SpellBad   ctermbg=230 ctermfg=250 guibg=NONE    guifg=#bcbcbc     guisp=#af5f87 | call format#FormatHighlightGroup('SpellBad', 'undercurl')
             highlight SpellCap   ctermbg=73  ctermfg=250 guibg=NONE    guifg=#bcbcbc     guisp=#5fafaf | call format#FormatHighlightGroup('SpellCap', 'undercurl')
             highlight SpellLocal ctermbg=65  ctermfg=250 guibg=NONE    guifg=#bcbcbc     guisp=#5f875f | call format#FormatHighlightGroup('SpellLocal', 'undercurl')
             highlight SpellRare  ctermbg=172 ctermfg=250 guibg=NONE    guifg=#bcbcbc     guisp=#d78700 | call format#FormatHighlightGroup('SpellRare', 'undercurl')
  else
    execute 'highlight SpellBad   ctermbg=132 ctermfg=234 guibg=#af5f87 guifg='.s:black.' guisp=NONE'   | call format#FormatHighlightGroup('SpellBad', 'undercurl')
    execute 'highlight SpellCap   ctermbg=73  ctermfg=234 guibg=#5fafaf guifg='.s:black.' guisp=NONE'   | call format#FormatHighlightGroup('SpellCap', 'undercurl')
    execute 'highlight SpellLocal ctermbg=65  ctermfg=234 guibg=#5f875f guifg='.s:black.' guisp=NONE'   | call format#FormatHighlightGroup('SpellLocal', 'undercurl')
    execute 'highlight SpellRare  ctermbg=172 ctermfg=234 guibg=#d78700 guifg='.s:black.' guisp=NONE'   | call format#FormatHighlightGroup('SpellRare', 'undercurl')
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
        \ ['vimIsCommand', 'Statement'],
        \ ['vimFunction', 'FunctionStatement'],
        \ ]

augroup Xapprentice
    autocmd!
    autocmd ColorScheme * if expand('<amatch>') =~# 'xapprentice_dark'
                            \ | for link in s:links | execute 'highlight link' link[0] link[1] | endfor
                            \ | else | for link in s:links | execute 'highlight link' link[0] 'NONE' | endfor
                            \ | endif
augroup END

" Restore the previously saved compatible options.
let &g:cpoptions = s:save_cpoptions
unlet! s:save_cpoptions
