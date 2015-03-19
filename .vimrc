set encoding=utf-8
set nocompatible
let mapleader=","

call pathogen#infect()
call pathogen#helptags()
filetype plugin on

" Style (color list: http://pln.jonas.me/xterm-colors)
syntax on
colorscheme badwolf

" Make background transparent
highlight Normal ctermbg=None
highlight Folded ctermbg=None
highlight NonText ctermbg=None
highlight LineNr ctermbg=None

" Indentation
set expandtab
set tabstop=8
set shiftwidth=4
set softtabstop=4

" Code Folding
set foldmethod=indent
set foldcolumn=1
set foldlevelstart=99

" Wrapping
set wrap
set linebreak
set showbreak=…

" Disable swap files (that's what git is for)
set updatetime=500
set nobackup
set noswapfile

" Navigation
set mouse=a

" Layout
set number
set laststatus=2
set equalalways

" Searching
set hlsearch
set incsearch
set smartcase

" Keybinds
set pastetoggle=<F2>
nnoremap <CR> :let @/ = ""<CR>:<BACKSPACE><CR>
nnoremap <F5> :GundoToggle<CR>
nnoremap <F6> :NERDTreeToggle<CR>
nnoremap <F7> :tabp<CR>
nnoremap <F8> :tabn<CR>

" Airline
let g:airline_left_sep = ""
let g:airline_right_sep = ""
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'custom'
let g:airline#themes#custom#palette = {}
let s:N1 = [ '#005f00' , '#aeee00' , 22  , 154 ]
let s:N2 = [ '#a8a8a8' , '#45413b' , 248 , 238 ]
let s:N3 = [ '#8a8a8a' , '#242321' , 245 , 235 ]
let s:I1 = [ '#005f5f' , '#ffffff' , 23  , 15  ]
let s:I2 = [ '#00d7ff' , '#0087af' , 45  , 31  ]
let s:I3 = [ '#00d7ff' , '#005f87' , 45  , 24  ]
let s:R1 = [ '#ffffff' , '#d70000' , 15  , 160 ]
let s:V1 = [ '#d75f00' , '#ffaf00' , 166 , 214 ]
let s:M  = [ '#ff8700', 208 ]
let g:airline#themes#custom#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#custom#palette.normal_modified = {
    \ 'airline_c': [ s:M[0], s:N3[1], s:M[1], s:N3[3], '' ] }
let g:airline#themes#custom#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#custom#palette.insert_modified = {
    \ 'airline_c': [ s:M[0], s:I3[1], s:M[1], s:I3[3], '' ] }
let g:airline#themes#custom#palette.replace = airline#themes#generate_color_map(s:R1, s:N2, s:N3)
let g:airline#themes#custom#palette.replace_modified = g:airline#themes#custom#palette.normal_modified
let g:airline#themes#custom#palette.visual = airline#themes#generate_color_map(s:V1, s:N2, s:N3)
let g:airline#themes#custom#palette.visual_modified = g:airline#themes#custom#palette.normal_modified
let g:airline#themes#custom#palette.inactive = airline#themes#generate_color_map(s:N2, s:N2, s:N3)
