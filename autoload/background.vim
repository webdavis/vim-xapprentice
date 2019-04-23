function! background#Switch()
    if !exists('g:colors_name') || g:colors_name !~# 'xapprentice_\(dark\|light\)'
        echoerr 'For this feature to work an xapprentice colorscheme must be set.'
        return 0
    endif

    if g:colors_name ==# 'xapprentice_dark'
        colorscheme xapprentice_light
    else
        colorscheme xapprentice_dark
    endif
endfunction
