set history=500 "set how many lines of history vim has to remember

" Enable filetype plugins
" filetype plugin on
" filetype indent on

set autoread " auto read file when is changed from the outside
au FocusGained,BufEnter * silent! checktime

set ruler " Always show current position
set backspace=eol,start,indent "something about backspace
set whichwrap+=<,>,h,l "same as prev
set smartcase "try to be smart when searching about cases
set hlsearch " highlight search results
set incsearch " made search act like search in modern browsers
set lazyredraw " Don't redraw while executing macros (good performance config)
set magic " for regular expressions turn magic on
set showmatch " show matching brackets when text indicator is over them
set mat=2 " how many tenths of a second to blink when matching brackets
set noerrorbells " no annoying sound on errors
set novisualbell
set t_vb=
set tm=500
set foldcolumn=1 " add a bit extra margin on the left
set number
set relativenumber


" => Colors and Fonts
syntax enable " enable syntax highlighting
set regexpengine=0 " set regular expresson engine automatically
set background=dark
set encoding=utf-8
set ffs=unix,dos,mac " use Unix as the standard file type

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


