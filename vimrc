set nocompatible
filetype off


set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

set colorcolumn=85


Bundle 'tpope/vim-fugitive'
syntax enable
Bundle 'scrooloose/syntastic'
" let g:syntastic_puppet_lint_arguments = '--no-80chars-check'
if has('statusline')
      set laststatus=2
      " Broken down into easily includeable segments
      set statusline=%<%f\    " Filename
      set statusline+=%w%h%m%r " Options
      set statusline+=%{fugitive#statusline()} "  Git Hotness
      set statusline+=\ [%{&ff}/%Y]            " filetype
      set statusline+=\ [%{getcwd()}]          " current dir
      set statusline+=%#warningmsg#
      set statusline+=%{SyntasticStatuslineFlag()}
      set statusline+=%*
      let g:syntastic_enable_signs=1
      set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

Bundle 'godlygeek/tabular'
Bundle 'tpope/vim-sensible'

Bundle 'reinh/vim-makegreen'
nnoremap <unique> <leader>t :MakeGreen %<CR>
