"Change color of whitespace chars
hi Whitespace ctermfg=11
"highlight all whitespace chars
match Whitespace /\s/
"
set list
set listchars+=eol:¬,trail:~,extends:>,precedes:<,space:·
set listchars+=tab:\│\ 
set noexpandtab

syntax on 
" make selection look okay

" Disavle vi compability stuff
set nocompatible

" Encoding
set encoding=utf-8

" Status
set laststatus=2

" Line Numbers
set number relativenumber

" Syntax Highlighting
syntax on 

set cursorline

set cursorcolumn
set showcmd
" use the system clipboard, becasue I can't be bothered
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

set ruler
set rulerformat=%#Ruler#%l,%c%V%=%P
"Typing Behavior
set backspace=indent,eol,start
" Ctrl+w to delete a word
noremap <C-w> daw
"delete last word with ctrl backslash
imap <C-BS> <C-W>
" wildmenu 
set wildmenu
set wildmode=list:longest,full
set showmatch
set complete-=i
set smarttab

"Formatting
"set nowrap
set wrap
set tabstop=2 shiftwidth=2 softtabstop=2
set foldlevelstart=2

"Word splitting
set iskeyword+=-

"Markdown Stuff
set conceallevel=2

" clever completing with :find
set path+=**

" Movement
set mouse=a
set keymodel=startsel,stopsel

" Performance
set lazyredraw
set ttyfast

" Splits
" Movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Behaviour
set splitbelow
set splitright
"Show Tabs as lines

"Change Split Char
:set fillchars+=vert:\│

