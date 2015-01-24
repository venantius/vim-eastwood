" janitor.vim - Clojure linting and code cleanup
" Maintainer:   Venantius <http://venanti.us>
" Version:      0.1

" TODO
function LintEastwood()
    let ns = fireplace#ns()
    echom ns
    return ''
endfunction

function RequireEastwood()
    let cmd = "(require 'eastwood.lint)"
    try
        call fireplace#session_eval(cmd)
        return ''
    catch /^Clojure:.*/
        return ''
    endtry
endfunction

function TryToPrint()
    let cmd = '(println "butts")'
    try
        call fireplace#session_eval(cmd)
        return ''
    catch /^Clojure:.*/
        return ''
    endtry
endfunction
