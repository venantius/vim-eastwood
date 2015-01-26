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
    let errorformat = '%f:%l:%c: %m'

    let env = syntastic#util#isRunningWindows() ? {} : { 'TERM': 'dumb' }
    
    redir => eastwood_output
    call g:EastwoodLintNS()
    redir end
    let result_array = split(eastwood_output, "\n")[1:]
    let loclist = []

    for message in result_array
        let error = {}
        let filename_idx = match(message, ":", 0, 1)
        let filename = message[0 : filename_idx - 1]

        let line_idx = match(message, ":", 0, 2)
        let line = message[filename_idx + 1 : line_idx - 1]

        let column_idx = match(message, ":", 0, 3)
        let column = message[line_idx + 1 : column_idx - 1]
        let msg = message[column_idx + 1 : ]

        let error.text = msg
        let error.lnum = line
        let error.col = column
        let error.valid = 1
        let error.type = "E"
        let error.bufnr = bufnr('%')
        call add(loclist, error)
    endfor

    return loclist
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'clojure',
    \ 'name': 'eastwood'})

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:
