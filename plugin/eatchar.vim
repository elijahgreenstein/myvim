" Description: 'Eat' space character after an appreviation
"
" The function below is copied from the Vim Reference Manual (`:helpgrep
" Eatchar`).
"
" The Vim user manual and reference manual are Copyright (c) 1988 by Bram
" Moolenaar. This material may be distributed only subject to the terms and
" conditions set forth in the Open Publication License, v1.0 or later. The
" latest version is presently available at: https://opencontent.org/openpub/
"
" To access the Vim Reference Manual copyright notice: `:help manual-copyright`.

func Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunc

