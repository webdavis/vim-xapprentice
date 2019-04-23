function! format#PersistAttribute(group, attribute)
    execute 'let g:xapprentice_' . a:attribute . '_group = get(g:, "xapprentice_' . a:attribute . '_group", [])'
    if index(eval('g:xapprentice_' . a:attribute . '_group'), a:group) ==? -1
        call add(eval('g:xapprentice_' . a:attribute . '_group'), a:group)
    else
        call filter(eval('g:xapprentice_' . a:attribute . '_group'), 'v:val !=# a:group')
    endif
endfunction

function! format#Group()
    let l:group = {}
    let l:group.cterm = []
    let l:group.gui = []
    let l:group.term = []

    function! l:group.Add(group, attribute)
        let self.cterm = split(substitute(matchstr(execute('highlight ' . a:group), 'cterm=.\{-}\ '), 'cterm=\| ', '', 'g'), ',')
        call add(self.cterm, a:attribute)
        call insert(self.cterm, 'cterm=NONE')
        let self.cterm = filter(filter(copy(self.cterm), 'index(self.cterm, v:val, v:key + 1) == -1'), 'v:val !=? ""')
        let self.cterm = join(self.cterm, ',')

        let self.gui = split(substitute(matchstr(execute('highlight ' . a:group), 'gui=.\{-}\ '), 'gui=\| ', '', 'g'), ',')
        call add(self.gui, a:attribute)
        call insert(self.gui, 'gui=NONE')
        let self.gui = filter(filter(copy(self.gui), 'index(self.gui, v:val, v:key + 1) == -1'), 'v:val !=? ""')
        let self.gui = join(self.gui, ',')

        let self.term = split(substitute(matchstr(execute('highlight ' . a:group), 'term=.\{-}\ '), 'term=\| ', '', 'g'), ',')
        call add(self.term, a:attribute)
        call insert(self.term, 'term=NONE')
        let self.term = filter(filter(copy(self.term), 'index(self.term, v:val, v:key + 1) == -1'), 'v:val !=? ""')
        let self.term = join(self.term, ',')

        execute 'highlight ' . a:group . ' ' . self.cterm . ' ' . self.gui . ' ' . self.term
    endfunction

    function! l:group.Remove(group, attribute)
        let self.cterm = split(substitute(matchstr(execute('highlight ' . a:group), 'cterm=.\{-}\ '), 'cterm=\| ', '', 'g'), ',')
        if index(self.cterm, a:attribute) ==? -1
            return 0
        endif
        let self.cterm = filter(copy(self.cterm), 'v:val !=# a:attribute')
        call insert(self.cterm, 'cterm=NONE')
        let self.cterm = join(self.cterm, ',')

        let self.gui = split(substitute(matchstr(execute('highlight ' . a:group), 'gui=.\{-}\ '), 'gui=\| ', '', 'g'), ',')
        let self.gui = filter(copy(self.gui), 'v:val !=# a:attribute')
        call insert(self.gui, 'gui=NONE')
        let self.gui = join(self.gui, ',')

        let self.term = split(substitute(matchstr(execute('highlight ' . a:group), 'term=.\{-}\ '), 'term=\| ', '', 'g'), ',')
        let self.term = filter(copy(self.term), 'v:val !=# a:attribute')
        call insert(self.term, 'term=NONE')
        let self.term = join(self.term, ',')

        execute 'highlight ' . a:group . ' ' . self.cterm . ' ' . self.gui . ' ' . self.term
        return 1
    endfunction

    return l:group
endfunction

function! format#Set(attribute, bang, ...)
    if !exists('g:colors_name') || g:colors_name !~# 'xapprentice_\(dark\|light\)'
        echoerr 'For this feature to work an xapprentice colorscheme must be set.'
        return 0
    endif

    if !empty(join(a:000))
        for l:g in split(join(a:000, ','))
            if a:bang
                call format#PersistAttribute(l:g, a:attribute)
            endif

            let l:group = format#Group()
            if l:group.Remove(l:g, a:attribute) ==? 1
                continue
            endif
            call l:group.Add(l:g, a:attribute)
        endfor
	return 0
    elseif a:bang || get(g:, eval(string('xapprentice_' . a:attribute)) , 1)
	execute 'let g:xapprentice_' . a:attribute . ' = 0'
    else
	execute 'let g:xapprentice_' . a:attribute . ' = 1'
    endif

    execute 'colorscheme ' . g:colors_name
endfunction
