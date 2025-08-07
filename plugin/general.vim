" Description: General Vim settings.
"
" - Appearance
" - Buffers, splits
" - Filetypes, syntax highlighting
" - Spelling
" - Tabs, spaces, indents
" - Mappings
" - Miscellaneous

" ============================================================
" Section: Appearance

" ------------------------------------------------------------
" Subsection: Basic settings

set colorcolumn=+1        "Column after textwidth will be highlighted
set display+=lastline     "Allow display of last part of line, not @@@
set formatoptions=cq      "Wrap comments only, format comments w/ gq
set hlsearch              "Enable search highlighting
set ignorecase            "Ignore case when searching
set incsearch             "Shows partial search matches
set laststatus=2          "Always show last status
set linebreak             "Avoid wrapping line in middle of word
set list                  "Show white space characters as listchars
set listchars=eol:¬,tab:>\ ,trail:·,extends:>,precedes:<,space:·,nbsp:_
set number                "Absolute number of lines
set numberwidth=5         "Line numbers width (default is 4)
set relativenumber        "Relative number of lines other than current
set scrolloff=5           "Keep last five and top five lines visible
set showbreak=↪           "Character when line is wrapped
set showcmd               "Show commands after execution
set textwidth=80          "Width for wrapping
set title                 "Terminal window title as 'titlestring'
set visualbell            "Flash visual bell rather than audio bell

augroup terminal          "Do not have line numbers when in Terminal window
  autocmd!
  au TerminalOpen * set nonumber norelativenumber
augroup END

augroup cursor_line       "Cursor line (only in active window)
  autocmd!
  au WinEnter * set cursorline
  au WinLeave * set nocursorline
augroup END

set guioptions-=e         " Use terminal-style tabline instead of GUI

" ------------------------------------------------------------
" Subsection: Light / dark background

" Set light background between 08:00 and 20:00, o.w. dark
let hour = strftime("%H")
let light_min = 8
let light_max = 20
if ((hour >= light_max) == 1) + ((hour < light_min) == 1) > 0
  set background=dark
else
  set background=light
endif

" Toggle dark / light background
function ToggleDarkLight()
  if &background == "dark"
    execute "set background=light"
  else
    execute "set background=dark"
  endif
endfunction


" ------------------------------------------------------------
" Subsection: Set up status line, with options:
"   - Base status line
"   - File path status line
"   - Status line with word count

function! StatusLineBaseString()
  let l:sl = "%2n\\|%<"                       "Buffer number    3char
  let l:sl = l:sl . "%-20.20F"                "File path       20char
  let l:sl = l:sl . "%-10y"                   "Type of file    10char
  let l:sl = l:sl . "\\|c:\\ %3v"             "Current column   7char
  let l:sl = l:sl . "\\|L:%5l/%5L\\ %3p%%"    "Lines       19char
  return l:sl
endfunction

let g:mod_flag = "\\ %-3m" "Modified flag 4char

" Set base status line globally
function StatusLineBase()
"  call StatusLineModeColour()
  exe "set statusline=" . StatusLineBaseString() . g:mod_flag
endfunction

" Set base status line locally
function StatusLineLocalBase()
"  call StatusLineModeColourLocal()
  exe "setlocal statusline=" . StatusLineBaseString() . g:mod_flag
endfunction

" Add word count to status line locally
function StatusLineLocalWordCount()
"  call StatusLineLocalBase()
  exe "setlocal statusline=" . StatusLineBaseString()
  setlocal statusline+=\|w:%5{wordcount().words} "Word      8char
  exe "setlocal statusline+=" . g:mod_flag
endfunction

" Set file path status line locally
function StatusLineLocalFilePath()
"  call StatusLineModeColourLocal()
  setlocal statusline=%F              "Full file path
endfunction

" Call base status line on start up
call StatusLineBase()


" ------------------------------------------------------------
" Subsection: Application window

" Set up gvim to size for single split, to text width, max height of screen
command Single execute "set columns=" . (&textwidth + 6) "lines=999"
" Set up gvim to size for single split (80), navigator (20+1), max height
command SingleNav execute "set columns=108 lines=999"
" Set up gvim to size for two splits (80 each), max height of screen
command Double execute "set columns=173 lines=999"
" Set up gvim to size for two splits (80 each), navigator (20+1), max height
command DoubleNav execute "set columns=195 lines=999"


" ============================================================
" Section: Buffers, splits

set hidden                "Hide abandoned buffers instead of closing
set splitbelow            "Split window below current one
set splitright            "Vertical split will open to right


" ============================================================
" Section: Filetypes, syntax highlighting
"
if !exists("g:syntax_on") "Enable syntax highlighting (loads once)
  syntax enable
endif
"
filetype plugin indent on "Enable file-type detection


" ============================================================
" Section: Spelling

set spelllang=en_ca       "When `spell` is set, use Canadian English
set spelllang+=cjk        "Exclude CJK characters from spell check
" Set up custom word list for use with `zg` and `zw`
set spellfile=$HOME/.vim/spell/custom-dict.utf-8.add


" ============================================================
" Section: Tabs, spaces, indents

set autoindent            "New lines inherit previous indentation
set expandtab             "Enter tab char with CTRL-V<Tab>
set shiftround            "Round indent to multiple of 'shiftwidith'
set shiftwidth=2          "Spaces for each step of autoindent
set softtabstop=2         "Backspace treats two spaces like tab
set tabstop=2             "Insert two spaces for tab


" ============================================================
" Section: Mappings

" Leaders
nnoremap <space> <nop>
let mapleader="\<space>"
let maplocalleader="\\"

" ------------------------------------------------------------
" Subsection: Insert

" ESC from INSERT with jk
inoremap jk <esc>

" Arrows from n-dash, m-dash
inoremap – ->
inoremap — <-

" ------------------------------------------------------------
" Subsection: Normal

" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" Letters

" Z
" Use zG to access local spellfile
nnoremap zG 2zg

" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" Leader - Letter

" O
" Open directory
nnoremap <leader>od :!open .<cr>

" Z
" Correct nearest incorrect word ahead of cursor
nnoremap <leader>cw ]s1z=``
" Correct nearest incorrect word behind cursor
nnoremap <leader>cW [s1z=``

" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" Arrows

" Movement between windows
nnoremap <Right> <c-w><Right>
nnoremap <Left> <c-w><Left>
nnoremap <Up> <c-w><Up>
nnoremap <Down> <c-w><Down>


" ============================================================
" Section: Miscellaneous

set autoread              "Reread file when outside changes detected
set encoding=utf-8        "Encoding (in Vim, in files) to UTF-8
set mouse=a               "Enable use of mouse on terminal

" Help in vertical split
command -nargs=? H vert h <args>

