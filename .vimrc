" This should go without saying, but just in case…
set nocompatible

" Use 256 colors
set t_Co=256

" Enable backups and choose where they should be stored. If the preferred
" directory doesn't exist, try a less preferred one.
set writebackup
set backup
set backupdir=~/.vim/backups,~/tmp,./

" Also move swap and undo files
set directory=~/.vim/swaps,~/tmp,./
set undodir=~/.vim/undo,~/tmp,./

" Persistent undo; saves history to a file
set undofile
set undolevels=10000
set undoreload=10000

" Confirm instead of requiring !
set confirm

" Set manual folding
set fdm=manual

" Show line numbers
set number

" Syntax highlighting
syntax on

" Auto-indent
"set autoindent
"set smartindent

" Show cursor position
set ruler

" Show filename in window title
set title

" Window switching
"nnoremap <C-R> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>

" Enable mouse support
set mouse=a

" Set path so you can type gf to open a linked file
set path=$PWD/**

" Show context while scrolling
set scrolloff=3

" Indent wrapped lines intelligently
if v:version >= 704 && has('patch594')
 set breakindent
endif

" Use wordwrap
set linebreak

" Show commands as you type them
"set showcmd

" Visual autocomplete
set wildmenu

" Highlight matching braces
"set showmatch

" No error bells
"set noerrorbells

" Switch escape and tab
"nnoremap <Tab> <Esc>
"vnoremap <Tab> <Esc>gV
"onoremap <Tab> <Esc>
"inoremap <Tab> <Esc>`^
"inoremap <Leader><Tab> <Tab>

" Allow backspacing old text

set backspace=indent,eol,start

" The number of spaces to indent to
set shiftwidth=1

" Remove comment characters when joining commented lines
if v:version >= 704
 set formatoptions+=j
endif

" Let arrow keys scroll by screen lines
map <Up> gk
map <Down> gj

" Show where long lines are wrapped
set showbreak=¬

" Make readonly files non-modifiable
function UpdateModifiable()
 if !exists("b:setmodifiable")
  let b:setmodifiable = 0
 endif
 if &readonly
  if &modifiable
   setlocal nomodifiable
   let b:setmodifiable = 1
  endif
  else
   if b:setmodifiable
    setlocal modifiable
   endif
 endif
endfunction
autocmd BufReadPost * call UpdateModifiable()

" Autocomplete words from the UNIX dictionary; useful in conjunction with 
" CTRL-X CTRL-K completion
if filereadable("/usr/share/dict/words")
 set dictionary=/usr/share/dict/words
endif

" Disable blinking cursor in case you're running gvim or your terminal 
" emulator doesn't have the option.
set guicursor+=a:blinkon0

" Change theme depending on operating system
if has("win32")
 colorscheme blue
else
 if has("unix")
  let s:uname=system("uname")
   if s:uname == "Darwin\n"
    colorscheme darkblue
   endif
 endif
endif

" Automatic indentation; this needs to be turned off when pasting code into
" the terminal. Use `set shiftwidth=N` to change indentation amount.
set autoindent
set smartindent

" Use the spell checker. Spelling commands start with z (which is pretty
" much where all the miscellaneous functions go).
" 
" zg -> mark word as a Good spelling
" zw -> mark word as Wrong spelling
" z= -> SET as spelling suggestion from menu
"
" Navigating through misspelled words:
" [s = previous misspelled word
" ]s = next misspelled word
set spell

" Keep a separate ignore spelling file per file
let spelldir = "~/.vim/spell/"
if !isdirectory(expand(spelldir))
  let spelldir = "."
endif
let fn = spelldir.substitute(@%, '/', '%', 'g').".utf-8.add"
execute "setlocal spellfile+=".fn
