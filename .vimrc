set encoding=utf-8

" Style
"set background=dark
colorscheme badwolf
syntax on
highlight Normal ctermbg=None
highlight Folded ctermbg=None
highlight NonText ctermbg=None
highlight LineNr ctermbg=None

" Indentation and Folding
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set foldmethod=indent
set foldcolumn=2
set foldlevel=0
set foldlevelstart=1

" Navigation
set mouse=a
set paste

" Layout
set number
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set timeoutlen=50
set equalalways

" Searching
set hlsearch
set incsearch

" Keybinds
map <F7> :tabp<CR>
map <F8> :tabn<CR>
nnoremap <CR> :let @/ = ""<CR>:<BACKSPACE><CR>
