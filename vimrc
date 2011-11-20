call pathogen#infect()

syntax on
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
if has("autocmd")
  filetype indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd			" Show (partial) command in status line.
set modeline
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
"set hidden         " Hide buffers when they are abandoned
set mouse=nicr	    " Enable mouse usage 

set backup
set backupdir=~/.vim/backup

if (match(getline(1), "#!/bin/bash" ) != -1)
    so /usr/share/vim/vimcurrent/syntax/bash.vim
endif

function! SearchAndSource()

	let rc=findfile('vimrc', '**')
	if (rc != "")
"		echo "Sourcing vimrc file at" rc 
		execute 'source ' . rc
        return
	endif
	let rc=findfile('.vimrc', '**')
	if (rc != "")
"		echo "Sourcing .vimrc file at" rc 
		execute 'source ' . rc
        return
	endif

endfunction

function! CheckForShebang()
    if (match( getline(1) , '^\#!') == 0)
        normal :map <F5> :!./%CR
    else
        unmap <F5>
    endif
endfunction

map <F5> :call CheckForShebang()

let g:treeExplVertical=0
let g:treeExplWinSize=50
let g:treeExplNoList=0

"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

set number
set shiftwidth=4
set tabstop=4
set expandtab

au! BufRead,BufNewFile *.py setlocal noexpandtab

map <F12> :source ~/.vimrc<CR>


vnoremap > >gv
vnoremap < <gv

" put q register in newline at eof
noremap qp Go"qp
" delete last line back into q register
noremap qd G0"qd$dd:w

" fuck some <F1> help
nmap <F1> 
imap <F1> 

map gf :e <cfile><CR>
map <C-W><C-F> :new <cfile><CR>

nmap Q A



" I do these aaalllll the time...
abb String String
abb pacakge package
abb sahrk shark
abb serviec service

" quick vimgrep on current word
nmap vg yaw:vimgrep '"
nnoremap U ddO

nnoremap <C-p> :normal <CR>

nnoremap <C-w>yy "+yy
nnoremap <C-w>y "+y
vnoremap <C-w>y "+y
nnoremap <C-w>dd "+dd
nnoremap <C-w>d "+d
vnoremap <C-w>d "+d
nnoremap <C-w>p "+p
vnoremap <C-w>p "+p
nnoremap <C-w>P "+P
vnoremap <C-w>P "+P

filetype plugin indent on
let clj_highlight_builtins=1
let clj_highlight_contrib=1
let clj_paren_rainbow=1
let clj_want_gorilla=1
let vimclojure#NailgunClient = "/usr/bin/nc localhost 9999 "
let maplocalleader = ","

set ruler
set backspace=2

let @n = ".n"
let @j = "j."
let @k = "k."
set exrc

set autoindent
set smartindent
set hlsearch
highlight clear Search
highlight Search cterm=underline

vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>\:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs
nmap  :nohl<CR>

set ttymouse=xterm2
au VimEnter * call MyInit()

function! MyInit()
    if &filetype != "gitcommit" && &filetype != "todo"
        NERDTree
        if (argc() > 0)
            execute 'normal l'
        endif
    else
        normal gg 
    endif
endfunction
