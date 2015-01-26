" eastwood.vim - Clojure linting and code cleanup
" Maintainer:   Venantius <http://venanti.us>
" Version:      0.1

if exists('g:syntastic_extra_filetypes')
    call add(g:syntastic_extra_filetypes, 'clojure')
else
    let g:syntastic_extra_filetypes = ['clojure']
endif

function g:EastwoodRequire()
    let cmd = "(require 'eastwood.lint)"
    try
        call fireplace#session_eval(cmd)
        return ''
    catch /^Clojure:.*/
        return ''
    endtry
endfunction

function EastwoodCallback()
    return "(fn [x] " . 
          \ " (if (= (:kind x) :lint-warning) " .
          \ "   (let [{:keys [line file column msg] :as x} (:warn-data x)" .
          \ "         warning (clojure.string/join \":\" [file line column msg])]" .
          \ "     (println warning))))"
endfunction

function g:EastwoodLintNS()
    let cmd = "(eastwood.lint/eastwood {:namespaces ['" . fireplace#ns() . "] :callback " . EastwoodCallback() . "})"
    try
        silent! call fireplace#session_eval(cmd)
        return ''
    catch /^Clojure:.*/
        return ''
    endtry
endfunction
