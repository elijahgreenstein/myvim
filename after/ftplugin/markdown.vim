" Description: Markdown settings

" Section: Abbreviations
call abbrTex#loadAbbr()

" Section: Commands
let s:cmd="silent !pbpaste | pandoc -f markdown -t html | pbcopy"
command -bar Mhall %y+ | exe s:cmd | redraw!

" Section: Settings
call writingSettings#writer()

