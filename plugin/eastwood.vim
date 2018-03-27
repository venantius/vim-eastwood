" eastwood.vim - Clojure linting and code cleanup plugin
" Maintainer:   Venantius <venantius at gmail dot com>
" Version:      0.2

if exists('g:syntastic_extra_filetypes')
    call add(g:syntastic_extra_filetypes, 'clojure')
else
    let g:syntastic_extra_filetypes = ['clojure']
endif

function! g:EastwoodRequire()
    let cmd = "(require 'eastwood.lint)"
    try
        call fireplace#session_eval(cmd)
        return ''
    catch /^Clojure:.*/
        return ''
    endtry
endfunction

function! g:EastwoodLintNS(...) abort
    let opts = a:0 ? a:1 : {}
    let add_linters = exists('opts.add_linters') ? opts.add_linters : []

    let cmd = "(->> (eastwood.lint/lint { " .
            \     " :namespaces '[" . fireplace#ns() . "]" .
            \     " :add-linters [" . join(map(copy(add_linters), '":" . v:val'), " ") ."]" .
            \ " })" .
            \ " :warnings" .
            \ " (map (fn [e]" .
            \     "{:text (:msg e)" .
            \     " :lnum (:line e)"  .
            \     " :col (:column e)" .
            \     " :valid true"  .
            \     " :bufnr " . bufnr('%')  .
            \     " :type \"E\"})))"
    try
        call g:EastwoodRequire() " In case if REPL was restarted
        let res=fireplace#query(cmd)
        return res
    catch /^Clojure:.*/
        return []
    endtry
endfunction
