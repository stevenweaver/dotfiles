"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Command mode related
"    -> Moving around, tabs and buffers
"    -> Statusline
"    -> Editing mappings
"    -> Omni complete functions
"    -> Python section
"    -> JavaScript section
"    -> Vundles
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700
set foldmethod=syntax

" Enable filetype plugin
filetype plugin on
filetype indent plugin on

" Set to auto read when a file is changed from the outside
set autoread
"set paste

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

nnoremap <F5> "=strftime("%Y%m%d")<CR>P
inoremap <F5> <C-R>=strftime("%Y%m%d")<CR>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the curors - when moving vertical..
set so=7
set nu
set wildmenu
set ruler "Always show current position
set cmdheight=1 "The commandbar height
set hid "Change buffer - without saving

set nocompatible

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase

set nohlsearch "Highlight search things
set noincsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros 
set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

colorscheme elflord 
set background=dark
set nu

set encoding=utf8
set ffs=unix,dos,mac "Default file types


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=2
set tabstop=2
set smarttab

set lbr
set tw=500

set ai "Auto indent
set si "Smart indet
set nowrap 

set listchars=tab:>-,trail:- "View tabs and trailing spaces


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / (search) and c-space to ? (backgwards search)
map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

"if bufwinnr(1)
"    map + <C-W>+
"    map _ <C-W>-
"    map = <C-W>>
"    map - <C-W><
"endif

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always display the statusline
set laststatus=2

" Format the statusline
set statusline=\ %F%m%r%h\ %w\ Line:\ %l/%L:%c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType css set omnifunc=csscomplete#CompleteCSS


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Filetypes 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufRead *.as set filetype=actionscript
autocmd BufRead *.phtml set filetype=php
autocmd BufRead *.pde set filetype=c
autocmd BufRead *.gcov set filetype=cpp
autocmd BufRead *.bf set filetype=hyphy
autocmd BufRead *.wbf set filetype=hyphy
autocmd BufRead *.hbl set filetype=hyphy
autocmd BufRead *.mdl set filetype=hyphy
autocmd BufRead *.py set filetype=python
au BufNewFile,BufRead *.md set ft=md
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self
au BufNewFile,BufRead *.mako set ft=mako

""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
    return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction

""""""""""""""""""""""""""""""
" => HyPhy section
"""""""""""""""""""""""""""""""
let g:NERDCustomDelimiters = {
\ 'hyphy': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' }
\ }

""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .git generated'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>pp :setlocal paste!<cr>

" Vundles
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/Neocomplcache.vim'
Plugin 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'Lokaltog/vim-powerline'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'kien/ctrlp.vim'
Bundle 'rking/ag.vim'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'slim-template/vim-slim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'jpalardy/vim-slime'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'justinj/vim-react-snippets'
Plugin 'rhysd/vim-clang-format'
call vundle#end()

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11",
            \ "BreakBeforeBraces" : "Stroustrup"}

let g:neocomplcache_enable_at_startup = 1
let g:slime_target = "tmux"

