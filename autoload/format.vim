let s:vim_attributes = ['bold', 'italic', 'underline', 'reverse', 'inverse', 'standout', 'undercurl']

function! s:IsHighlightGroupInAttributeList(attribute, highlight_group)
    return index(get(g:, eval(string('xapprentice_' . a:attribute . '_group')), []), a:highlight_group, 0, 1) >=? 0
endfunction

function! s:IsAttributeOn(attribute)
    return get(g:, eval(string('xapprentice_' . a:attribute)), 1)
endfunction

function! s:CanAddAttribute(attribute, highlight_group)
    return s:IsAttributeOn(a:attribute) && s:IsHighlightGroupInAttributeList(a:attribute, a:highlight_group)
endfunction

" Allows the User to dynamically add an attribute to a highlight group.
function! format#FormatHighlightGroup(highlight_group, ...)
    let l:cterm = []
    let l:gui = []
    let l:term = []
    call insert(l:cterm, 'cterm=NONE')
    call insert(l:gui, 'gui=NONE')
    call insert(l:term, 'term=NONE')

    if !empty(a:000)
        for l:arg in a:000
            call add(l:term, l:arg)
            call add(l:gui, l:arg)
            call add(l:cterm, l:arg)
        endfor
    endif

    for l:attribute in s:vim_attributes
        if s:CanAddAttribute(l:attribute, a:highlight_group)
            call add(l:cterm, l:attribute)
            call add(l:gui, l:attribute)
            call add(l:term, l:attribute)
        endif
    endfor

    let l:cterm = filter(filter(copy(l:cterm), 'index(l:cterm, v:val, v:key + 1) == -1'), 'v:val !=? ""')
    let l:cterm = join(l:cterm, ',')

    let l:gui = filter(filter(copy(l:gui), 'index(l:gui, v:val, v:key + 1) == -1'), 'v:val !=? ""')
    let l:gui = join(l:gui, ',')

    let l:term = filter(filter(copy(l:term), 'index(l:term, v:val, v:key + 1) == -1'), 'v:val !=? ""')
    let l:term = join(l:term, ',')

    execute 'highlight ' . a:highlight_group . ' ' . l:cterm . ' ' . l:gui . ' ' . l:term
endfunction

function! format#PersistAttribute(group, attribute)
    execute 'let g:xapprentice_' . a:attribute . '_group = get(g:, "xapprentice_' . a:attribute . '_group", [])'
    if index(eval('g:xapprentice_' . a:attribute . '_group'), a:group) ==? -1
        call add(eval('g:xapprentice_' . a:attribute . '_group'), a:group)
    else
        call filter(eval('g:xapprentice_' . a:attribute . '_group'), 'v:val !=# a:group')
    endif
endfunction

function! s:Add(group, attribute)
    let l:cterm = []
    let l:gui = []
    let l:term = []

    let l:cterm = split(substitute(matchstr(execute('highlight ' . a:group), 'cterm=.\{-}\ '), 'cterm=\| ', '', 'g'), ',')
    call add(l:cterm, a:attribute)
    call insert(l:cterm, 'cterm=NONE')
    let l:cterm = filter(filter(copy(l:cterm), 'index(l:cterm, v:val, v:key + 1) == -1'), 'v:val !=? ""')
    let l:cterm = join(l:cterm, ',')

    let l:gui = split(substitute(matchstr(execute('highlight ' . a:group), 'gui=.\{-}\ '), 'gui=\| ', '', 'g'), ',')
    call add(l:gui, a:attribute)
    call insert(l:gui, 'gui=NONE')
    let l:gui = filter(filter(copy(l:gui), 'index(l:gui, v:val, v:key + 1) == -1'), 'v:val !=? ""')
    let l:gui = join(l:gui, ',')

    let l:term = split(substitute(matchstr(execute('highlight ' . a:group), 'term=.\{-}\ '), 'term=\| ', '', 'g'), ',')
    call add(l:term, a:attribute)
    call insert(l:term, 'term=NONE')
    let l:term = filter(filter(copy(l:term), 'index(l:term, v:val, v:key + 1) == -1'), 'v:val !=? ""')
    let l:term = join(l:term, ',')

    execute 'highlight ' . a:group . ' ' . l:cterm . ' ' . l:gui . ' ' . l:term
endfunction

function! s:Remove(group, attribute)
    let l:cterm = []
    let l:gui = []
    let l:term = []

    let l:cterm = split(substitute(matchstr(execute('highlight ' . a:group), 'cterm=.\{-}\ '), 'cterm=\| ', '', 'g'), ',')
    if index(l:cterm, a:attribute) ==? -1
        return 0
    endif
    let l:cterm = filter(copy(l:cterm), 'v:val !=# a:attribute')
    call insert(l:cterm, 'cterm=NONE')
    let l:cterm = join(l:cterm, ',')

    let l:gui = split(substitute(matchstr(execute('highlight ' . a:group), 'gui=.\{-}\ '), 'gui=\| ', '', 'g'), ',')
    let l:gui = filter(copy(l:gui), 'v:val !=# a:attribute')
    call insert(l:gui, 'gui=NONE')
    let l:gui = join(l:gui, ',')

    let l:term = split(substitute(matchstr(execute('highlight ' . a:group), 'term=.\{-}\ '), 'term=\| ', '', 'g'), ',')
    let l:term = filter(copy(l:term), 'v:val !=# a:attribute')
    call insert(l:term, 'term=NONE')
    let l:term = join(l:term, ',')

    execute 'highlight ' . a:group . ' ' . l:cterm . ' ' . l:gui . ' ' . l:term
    return 1
endfunction

function! format#Set(attribute, bang, ...)
    if !exists('g:colors_name') || g:colors_name !~# 'xapprentice_\(dark\|light\)'
        echoerr 'For this feature to work an xapprentice colorscheme must be set.'
        return 0
    endif

    if !empty(join(a:000))
        for l:highlight_group in split(join(a:000, ','))
            if a:bang
                call format#PersistAttribute(l:highlight_group, a:attribute)
            endif

            if s:Remove(l:highlight_group, a:attribute) ==? 1
                continue
            endif
            call s:Add(l:highlight_group, a:attribute)
        endfor
	return 0
    elseif a:bang || get(g:, eval(string('xapprentice_' . a:attribute)) , 1)
	execute 'let g:xapprentice_' . a:attribute . ' = 0'
    else
	execute 'let g:xapprentice_' . a:attribute . ' = 1'
    endif

    execute 'colorscheme ' . g:colors_name
endfunction
