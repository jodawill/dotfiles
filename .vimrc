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

" Show cursor position
set ruler

" Show filename in window title
set title

" Enable mouse support; disabled because it breaks clipboard copying in GNU
" Screen.
"set mouse=a

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

" Show commands as you type them; disabled because it slows things down
"set showcmd

" Visual autocomplete
set wildmenu

" Switch escape and tab; disabled because I remapped caps lock to the escape
" key at the OS level
"nnoremap <Tab> <Esc>
"vnoremap <Tab> <Esc>gV
"onoremap <Tab> <Esc>
"inoremap <Tab> <Esc>`^
"inoremap <Leader><Tab> <Tab>

" Allow backspacing old text
set backspace=indent,eol,start

" Use one space for indentation and never use tabs
set shiftwidth=1
set expandtab

" Automatic indentation; this needs to be turned off when pasting code into
" the terminal. Use `set shiftwidth=N` to change indentation amount.
filetype plugin indent on
set cinoptions=l1

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

function EnableSpellChecker()
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
endfunction

" Don't use spell checker unless we're dealing with plain text.
autocmd FileType text,plaintext call EnableSpellChecker()
