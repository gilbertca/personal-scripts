" C Gilbert - VIM Configuration
" Created 2022-12-17
" Updated 2025-08-24 and uploaded to github.com @gilbertca
"Left here, and a bit later --> https://learnvimscriptthehardway.stevelosh.com/chapters/31.html
"source $VIMRUNTIME/defaults.vim
"NOTES:{{{
" imode: c-u delete to start of line
" nmode: s-k runs `! man {word}` for {word} under cursor
" nmode: c-v runs visual block
" nmode: s-v runs visual line
" remappings shouldn't include comments at the end
"}}}
"LEADER:{{{
let maplocalleader=" "
"}}}

"STATUS LINE:{{{
set laststatus=2 ":h laststatus
set statusline=%f\ -\ %l/%L\ \(%c\)
"}}}

"OPTIONS:{{{
filetype on
set showcmd
"}}}

"AUTOCOMMANDS & GROUPS:{{{
"}}}
augroup python_group{{{
	autocmd!
	autocmd FileType python nnoremap <buffer> <localleader><localleader> I#<esc>
	autocmd FileType python nnoremap <buffer> <tab> mcI<tab><esc>`c
	autocmd FileType python set number|
\set tabstop=4|
\set shiftwidth=4|
\set autoindent|
\set expandtab|
\set backspace=indent,eol,start|
\set hlsearch|
\set incsearch|
\set colorcolumn=80|
augroup END
"}}}
augroup rust_group{{{
autocmd FileType rust set number|
\set colorcolumn=80|
augroup END
"}}}
augroup vim_group{{{
	autocmd FileType vim nnoremap <buffer> <localleader><localleader><localleader> :execute "<c-u>normal! 0i"<esc>"
	autocmd FileType vim setlocal foldmethod=marker
	autocmd FileType vim setlocal number
augroup END
"}}}}}}
"TODO: WORD COUNT FUNCTION
"MAPPINGS:
"TODO: map custom jkl; movements to proper operator
"OPERATOR-PENDING MAPPINGS:{{{
":onoremap <map> <motion>
"}}}

"INSERT MODE MAPPINGS:{{{
inoremap jk <esc>l
inoremap JK <esc>l
"INSERT MODE ABBREVIATIONS:
"EX iabbrev {abbrev} Fulltext
"}}}

"NORMAL MODE MAPPINGS:{{{
" Open .vimrc{{{
nnoremap <F2> :vsplit $MYVIMRC<cr>
"}}}
" Close & source .vimrc{{{
nnoremap <F3> :source $MYVIMRC<cr>
"}}}
" Movement keys{{{
" Up 6 
nnoremap <c-k> 6k
" Down 6
nnoremap <c-j> 6j
"}}}
" Window Switching{{{
" Window above:
nnoremap <localleader>k <c-w>k
nnoremap <localleader>K <c-w>K
" Window below:
nnoremap <localleader>j <c-w>j
nnoremap <localleader>J <c-w>J
" Window left:
nnoremap <localleader>h <c-w>h
nnoremap <localleader>H <c-w>H
" Window right:
nnoremap <localleader>l <c-w>l
nnoremap <localleader>L <c-w>L
"}}}
" Fold shortcut{{{
nnoremap <localleader>f za  
"}}}}}}

"VISUAL MODE MAPPINGS:{{{
"}}}}}}

"To prevent auto-indent while pasting:
set pastetoggle=<F1>

"Yank to clip-board
vnoremap <localleader>y $h"+y
nnoremap <localleader>y myv$h"+y`y

"Splits/Explore:
nnoremap <localleader>O :Vex<cr>
nnoremap <localleader>o :Sex<cr>
nnoremap <localleader>e :Ex<cr>

"Tabs:
nnoremap <localleader>t :tabnew<CR>:Ex<cr>
nnoremap <C-l> :tabn<CR>
nnoremap <C-h> :tabp<CR>

"Hide highlight:
nnoremap <localleader>/ /\c
nnoremap <localleader>? :noh<CR>
"Brace handling:
""Blocks:
inoremap {}} {<cr>a<cr>}<esc>kA<bs>
""Move cursor inside braces after typing
inoremap {}h {}<esc>ci{

set number
