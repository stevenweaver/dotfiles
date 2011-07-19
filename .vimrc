set ts=4
set sw=4
set nowrap
set foldmethod=marker
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

map <C-B> :!php -l %<CR>

if bufwinnr(1)
	map + <C-W>+
	map _ <C-W>-
	map = <C-W>>
	map - <C-W><
endif

au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

