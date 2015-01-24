"============================================================================
"File:        eastwood.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  Venantius <venantius at gmail dot com>
"License:     Distributed under the Eclipse Public License 1.0, the same as
"             Clojure.
"
"============================================================================

if exists("g:loaded_syntastic_clojure_eastwood_checker")
    finish
endif
let g:loaded_syntastic_clojure_eastwood_checker = 1

let s:save_cpo = &cpo
set cpo&vim

" THIS STILL NEEDS DOING:

function! SyntaxCheckers_clojure_eastwood_GetLocList() dict
    let makeprg = self.makeprgBuild({})

    let errorformat = '%f:%l:%c: %m'

    let env = syntastic#util#isRunningWindows() ? {} : { 'TERM': 'dumb' }

    let loclist = SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'env': env,
        \ 'subtype': 'Style' })

    for e in loclist
        let e['type'] = e['text'] =~? '^W' ? 'W' : 'E'
    endfor

    return loclist
endfunction

" NOTE: DONE AFTER THIS

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'clojure',
    \ 'name': 'eastwood'})

let &cpo = s:save_cpo
unlet s:save_cpo

" TODO: I don't know what this is
" vim: set sw=4 sts=4 et fdm=marker: