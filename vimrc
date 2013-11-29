filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My bundles here:
"
" original repos on GitHub
Bundle 'tpope/vim-fugitive'
Bundle 'Valloric/YouCompleteMe'
" ...

filetype plugin indent on     " required!

syntax on
set background=dark

" jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal g'\"" | endif
filetype indent on

set showcmd			" Show (partial) command in status line.
set modeline
set showmatch		" Show matching brackets.
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set number
set shiftwidth=2
set tabstop=2
set expandtab
set backup
set backupdir=~/.vim/backup
set ruler
set exrc
set backspace=2
set autoindent
set smartindent
set hlsearch

au! BufRead,BufNewFile *.py setlocal noexpandtab
au! BufRead,BufNewFile .vimrc map <F5> :so %<CR>

map <F12> :source ~/.vimrc<CR>

>>>>>>> 413693aa7178a99afcfaaacd9e6e39ad7a008f98

vnoremap > >gv
vnoremap < <gv

" put q register in newline at eof
noremap qp maGo"qp
" delete last line back into q register
noremap qd G0"qd$dd:w`a

nmap Q A

let mapleader = ","
let maplocalleader = ","
let @n = ".n"
let @j = "j."
let @k = "k."

highlight clear Search
highlight Search cterm=underline

nmap  :nohl<CR>

nmap ,rc :split ~/.vimlocal/vimrc<CR>
nmap ,vs :source ~/.vimrc<CR>

nmap ,rr :?^!

au BufRead,BufEnter *.py set expandtab
