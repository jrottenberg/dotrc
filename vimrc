" $Date: 2008-02-02 01:14:11 -0500 (Sat, 02 Feb 2008) $
" $Author: ju $
"
" use vim defaults
set nocompatible 

set history=50          " keep 50 lines of command line history

"set ruler 		"Always show cursor position
"set rulerformat=%h%r%m%=%f
"set statusline=%<%f%h%m%r%=%{strftime(\"%l:%M:%S\ \%p,\ %a\ %b\ %d,\ %Y\")}\ %{&ff}\ %l,%c%V\ %P

" Automatically indent based on file type: 
filetype indent on
filetype plugin indent on 
" Keep indentation level from previous line: 
set autoindent

" hilight the screen line of the cursor
"set cursorline
"highlight CursorLine term=none cterm=none ctermbg=0
"autocmd InsertLeave * hi CursorLine term=none cterm=none ctermbg=0
" autocmd InsertEnter * hi CursorLine term=none cterm=none ctermbg=0


set hidden


"map <silent> <Leader>cl      :set                  cursorline! <CR>
"imap <silent> <Leader>cl <Esc>:set                  cursorline! <CR>a

" WhitespaceEOL == Bad
highlight WhitespaceEOL ctermbg=red guibg=red

"Make the completion menus readable
highlight Pmenu ctermfg=0 ctermbg=3
highlight PmenuSel ctermfg=0 ctermbg=7


set background=dark
colorscheme elflord

" hostname:/path/to/
set title
let &titlestring  = hostname() . ':' . '%{expand("%:p:~:h")}' 
set laststatus=2

"Syntax highlighting if appropriate
syntax on
highlight MatchParen ctermbg=darkblue guibg=blue
set hlsearch
set incsearch 
"Usually I don't care about case
set ignorecase
"Only ignore case when we type lower case
set smartcase
set showmatch

" Color !
syn on 	





" Python syntax check
syn match pythonError "^\s*def\s\+\w\+(.*)\s*$" display
syn match pythonError "^\s*class\s\+\w\+(.*)\s*$" display
syn match pythonError "^\s*for\s.*[^:]$" display
syn match pythonError "^\s*except\s*$" display
syn match pythonError "^\s*finally\s*$" display
syn match pythonError "^\s*try\s*$" display
syn match pythonError "^\s*else\s*$" display
syn match pythonError "^\s*else\s*[^:].*" display
syn match pythonError "^\s*if\s.*[^\:]$" display
syn match pythonError "^\s*except\s.*[^\:]$" display
syn match pythonError "[;]$" display
syn keyword pythonError         do

" Syntax checking entire file
" Usage: :make (check file)
" :clist (view list of errors)
" :cn, :cp (move around list of errors)
autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m


" PEP 8 
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal smarttab
setlocal expandtab
setlocal smartindent


" Menu
set wildmenu


set commentstring=\ #\ %s
set wildignore+=*.pyc,*.zip,*.gz,*.bz,*.tar,*.jpg,*.png,*.gif,*.avi,*.wmv,*.ogg,*.mp3,*.mov


" Tabs
map \t :tabnew<cr>
map \n :tabnext<cr>
map \p :tabprevious<cr>
map \c :tabclose<cr>



" Number of spaces to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
" Python: 4 spaces
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4

" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for a new tab use shiftwidth.
" Python: 8
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=8

" Replace tabs with the equivalent number of spaces.
" Also have an autocmd for Makefiles since they require hard tabs.
" Python: yes
" Makefile: no
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile Makefile* set noexpandtab

" Use the below highlight group when displaying bad whitespace is desired
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
" Python: 79 
" C: 79
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=79

" Turn off settings in 'formatoptions' relating to comment formatting.
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - r : do not insert the comment leader when hitting <Enter> in insert mode
" Python: not needed
" C: prevents insertion of '*' at the beginning of every line in a comment
au BufRead,BufNewFile *.c,*.h set formatoptions-=c formatoptions-=o formatoptions-=r

" Use UNIX (\n) line endings.
" Only used for new files so as to not force existing files to change their
" line endings.
" Python: yes
" C: yes
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix


" ----------------------------------------------------------------------------
" The following section contains suggested settings.  While in no way required
" to meet coding standards, they are helpful.

" Set the default file encoding to UTF-8: ``set encoding=utf-8``

" Puts a marker at the beginning of the file to differentiate between UTF and
" UCS encoding (WARNING: can trick shells into thinking a text file is actually
" a binary file when executing the text file): ``set bomb``

" For full syntax highlighting:
let python_highlight_all=1


" Folding based on indentation: 
"set foldmethod=indent
au BufWinLeave * mkview
au BufWinEnter * silent loadview


