function! xale#highlight#ToggleHighlight()
    if !exists('g:colors_name') || g:colors_name !~# 'xapprentice_\(dark\|light\)'
        echoerr 'For this feature to work an xapprentice colorscheme must be set.'
        return 0
    elseif !exists('g:loaded_ale') || !has('signs') || &compatible
        echoerr 'For this feature to work ALE must be installed and loaded.'
        return 0
    endif

    if get(g:, 'xapprentice_ale' , 1) ==? 1
        let g:xapprentice_ale = 0
    else
        let g:xapprentice_ale = 1
    endif
    execute 'colorscheme ' . g:colors_name
endfunction
