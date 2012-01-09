colorscheme elflord

set ts=4
set sw=4
set nowrap
set foldmethod=syntax
set autoindent
set smartindent
set cindent
set ignorecase
set smartcase
set expandtab

filetype indent off 
filetype on
set nu
set nobackup
set gfn=Courier:h9:cANSI
set guioptions-=T
"set columns=110
""set lines=70

syntax on
autocmd BufRead *.as set filetype=actionscript
autocmd BufRead *.phtml set filetype=php
autocmd BufRead *.pde set filetype=c
autocmd BufRead *.gcov set filetype=cpp
autocmd BufRead *.bf set filetype=cpp

if bufwinnr(1)
    map + <C-W>+
    map _ <C-W>-
    map = <C-W>>
    map - <C-W><
endif

au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

set nohlsearch

nnoremap <F5> "=strftime("%Y%m%d")<CR>P
inoremap <F5> <C-R>=strftime("%Y%m%d")<CR>
