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

" Try to require 'eastwood.lint
function! SyntaxCheckers_clojure_eastwood_IsAvailable() dict
    try
        call g:EastwoodRequire()
        return 1
    catch
        return 0
    endtry
endfunction

function! SyntaxCheckers_clojure_eastwood_GetLocList() dict
    let env = syntastic#util#isRunningWindows() ? {} : { 'TERM': 'dumb'  }
    let opts = {'add_linters': exists('g:eastwood_add_linters') ? g:eastwood_add_linters : []}
    return g:EastwoodLintNS(opts)
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'clojure',
    \ 'name': 'eastwood'})

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:
