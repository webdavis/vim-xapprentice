" Maintainer: Stephen A. Davis <stephen@webdavis.io>
" Repository: https://github.com/webdavis/vim-xapprentice.git
" Description: based on Apprentice, with a few tweaks.

" Consult this webpage for color terminology:
" https://www.uwgb.edu/heuerc/2D/ColorTerms.html

" This theme is only compatible with vim7 and later.
if exists('g:loaded_xapprentice_plugin') || &compatible || v:version <? 700
    finish
endif
let g:loaded_xapprentice_plugin = 1

" Save the current compatible options. This will be reset at the end of this script.
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" Toggles the following format options on and off.
command! -bar -bang -nargs=* XBold call format#ToggleAttribute('bold', <bang>0, <q-args>)
command! -bar -bang -nargs=* XItalic call format#ToggleAttribute('italic', <bang>0, <q-args>)
command! -bar -bang -nargs=* XUnderline call format#ToggleAttribute('underline', <bang>0, <q-args>)
command! -bar -bang -nargs=* XStandout call format#ToggleAttribute('standout', <bang>0, <q-args>)

" Toggles enhanced Signify colors on and off.
command! -bar -bang -nargs=0 XSignifyHighlight call xsignify#highlight#ToggleHighlight(<bang>0)

" Toggles enhanced ALE colors on and off.
command! -bar -nargs=0 XALEHighlight call xale#highlight#ToggleHighlight()

" Restore the previously saved compatible options.
let &cpoptions = s:save_cpoptions
unlet! s:save_cpoptions
