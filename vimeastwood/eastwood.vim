#!/usr/bin/vim

function s:RequireEastwood()
    let cmd = "(require 'eastwood.lint)"
    try
        call fireplace#session_eval(cmd)
        return ''
    catch /^Clojure:.*/
        return ''
    endtry
endfunction

function BuildCallback()
    return "(fn [x] " . 
          \ " (if (= (:kind x) :lint-warning) " .
          \ "   (let [{:keys [line file] :as x} (:warn-data x)" .
          \ "         warning (str file \":\")]" .
          \ "     (println warning))))"
endfunction

function LintItAll()
    let cmd = "(eastwood.lint/eastwood {:namespaces ['" . $EASTWOOD_NS . "] :callback " . BuildCallback() . "})"
    echom cmd
    try
        call fireplace#session_eval(cmd)
        return ''
    catch /^Clojure:.*/
        return ''
    endtry
endfunction

function! s:ImportFireplace()
    silent! runtime! plugin/**/*.vim
    execute pathogen#infect()
    silent! runtime! plugin/**/*.vim
    return ''
endfunction

call s:ImportFireplace()
call s:RequireEastwood()
call LintItAll()

:q
