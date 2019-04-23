function! signify#highlight#ToggleHighlight(bang)
    if !exists('g:colors_name') || g:colors_name !~# 'xapprentice_\(dark\|light\)'
        echoerr 'For this feature to work an xapprentice colorscheme must be set.'
        return 0
    elseif !exists('g:loaded_signify') || !has('signs') || &compatible
        echoerr 'For this feature to work vim-signify must be installed and loaded.'
        return 0
    endif

    if a:bang || get(g:, 'xapprentice_signify' , 1)
        let g:xapprentice_signify = 0
    else
        let g:xapprentice_signify = 1
    endif
    execute 'colorscheme ' . g:colors_name
endfunction
