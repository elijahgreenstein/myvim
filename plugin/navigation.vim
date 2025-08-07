" Description: Settings for navigation (Netrw)

" Section: Netrw appearance

" General settings (default, except for numbered lines: `nu`)
let g:netrw_bufsettings = "noma nomod nu nobl nowrap ro"
" Remove the Netrw banner (show it with `I`)
let g:netrw_banner=0
" Preview files in vertical split
let g:netrw_preview = 1


" Section: Navigation

" Explore current working directory
command Gowd execute "Ex" getcwd()
" Open directory of path under cursor
function OpenDir()
  let s:path=expand("<cfile>")
  exe "!open" s:path
endfunction
command OpenDir call OpenDir()

