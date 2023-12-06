set encoding=utf-8
set nocompatible
let mapleader=","

" Load plugins
call plug#begin(stdpath('data') . '/plugged')

" Layout
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'

" Language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tpope/vim-rails'
Plug 'kaarmu/typst.vim'

" Navigation & Search
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Misc
Plug 'godlygeek/tabular'
Plug 'mbbill/undotree'

Plug 'tpope/vim-dispatch'

call plug#end()

" Style (color list: http://jonasjacek.github.io/colors/)
syntax on
set synmaxcol=500
set background=dark
colorscheme gruvbox
set cursorline
set lazyredraw

" Whitespace
set listchars=tab:>·,trail:~
set list
highlight ExtraWhitespace ctermbg=red guibg=red
highlight link CocInlayHint GruvboxBg2
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
autocmd FileType klist set nolist
autocmd FileType klist highlight clear ExtraWhitespace

" Indentation
set expandtab
set tabstop=8
set shiftwidth=4
set softtabstop=4
set autoindent
autocmd FileType make set expandtab ts=4 sts=4 sw=4
let g:typescript_indent_disable = 1
autocmd FileType typescript set sts=2 sw=2
autocmd FileType ruby set sts=2 sw=2

" Code Folding
set foldcolumn=1
set foldlevelstart=99
set foldmethod=indent
"set foldmethod=expr " TODO: neovim only
set foldexpr=nvim_treesitter#foldexpr()

" Wrapping
set wrap
set linebreak
set showbreak=…

" Disable swap files (that's what git is for)
set updatetime=300
set nobackup
set nowritebackup
set noswapfile

" Navigation
set mouse=a
set scrolloff=2
set backspace=indent,eol,start

" Layout
autocmd FileType css ColorHighlight
set number relativenumber
"" Always show the signcolumn, otherwise it would shift the text each time
"" diagnostics appear/become resolved.
set signcolumn=yes
set laststatus=2
set equalalways
let g:gitgutter_max_signs = 3000
set tabpagemax=100
function! TabResize()
  let tabnr = tabpagenr()
  tabdo exe "normal! \<c-w>="
  exe 'tabnext' tabnr
endfunction
au VimResized * call TabResize()

" Splits
set splitright
set diffopt+=vertical
cabbrev hs horizontal split
cabbrev vs vertical split

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set rtp+=/usr/bin/fzf
let g:ackprg = "rg --vimgrep --smart-case"
cabbrev rg Ack
autocmd BufRead,BufNewFile *.rs set wildignore+=*/target/*
let g:ctrlp_max_files = 0

" Keybinds
set pastetoggle=<F2>
nnoremap <CR> :let @/ = ""<CR>:<BACKSPACE><CR>
nnoremap <F4> :UndotreeToggle<CR>
nnoremap <F5> :NERDTreeTabsToggle<CR>
nnoremap <F6> :NERDTreeTabsFind<CR>
nnoremap <F7> :tabp<CR>
nnoremap <F8> :tabn<CR>
map <F9> :set path += "."<CR><C-w>gf
nnoremap <F12> :tabe ~/.vimrc<CR>
nnoremap <Left> :cprev<CR>
nnoremap <Right> :cnext<CR>
nnoremap <Space> za
vmap <C-C> "+y

" Cargo
cabbrev Dargo Dispatch cargo
cabbrev Cargo ! cargo

if has("nvim")
    tnoremap <Esc> <C-\><C-n>
endif

" HexMode
" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
    " hex mode should be considered a read-only operation
    " save values for modified and read-only for restoration later,
    " and clear the read-only flag for now
    let l:modified=&mod
    let l:oldreadonly=&readonly
    let &readonly=0
    let l:oldmodifiable=&modifiable
    let &modifiable=1
    if !exists("b:editHex") || !b:editHex
        " save old options
        let b:oldft=&ft
        let b:oldbin=&bin
        " set new options
        setlocal binary " make sure it overrides any textwidth, etc.
        silent :e " this will reload the file without trickeries
                            "(DOS line endings will be shown entirely )
        let &ft="xxd"
        " set status
        let b:editHex=1
        " switch to hex editor
        %!xxd
    else
        " restore old options
        let &ft=b:oldft
        if !b:oldbin
            setlocal nobinary
        endif
        " set status
        let b:editHex=0
        " return to normal editing
        %!xxd -r
    endif
    " restore values for modified and read only state
    let &mod=l:modified
    let &readonly=l:oldreadonly
    let &modifiable=l:oldmodifiable
endfunction

cmap w!! %!sudo tee > /dev/null %

"let g:chadtree_settings = { 'theme.text_colour_set': 'nerdtree_syntax_dark' }
let g:chadtree_settings = {
    \ 'theme.text_colour_set': 'solarized_universal',
    \ 'keymap.tertiary': ['t'],
    \ 'keymap.trash': []
    \ }

" Lightline
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'relativepath', 'modified' ] ]
    \ },
    \ 'colorscheme': 'default',
    \ 'separator': { 'left': "\ue0b8", 'right': "\ue0ba" },
    \ 'subseparator': { 'left': "\ue0b9", 'right': "\ue0bb" },
    \ 'tabline_separator': { 'left': "\ue0bc", 'right': "\ue0be" },
    \ 'tabline_subseparator': { 'left': "\ue0bb", 'right': "\ue0ba" },
    \ }

let g:lightline#colorscheme#default#palette.normal.right[0] = g:lightline#colorscheme#default#palette.normal.left[0]
let g:lightline#colorscheme#default#palette.tabline.middle[0] = g:lightline#colorscheme#default#palette.normal.middle[0]
let g:lightline#colorscheme#default#palette.tabline.left[0] = g:lightline#colorscheme#default#palette.normal.left[1]
let g:lightline#colorscheme#default#palette.tabline.tabsel[0] = g:lightline#colorscheme#default#palette.normal.left[0]

" Treesitter TODO: only for neovim
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
}
EOF

" Latex Live Preview
let g:livepreview_previewer = 'zathura'
let g:livepreview_use_biber = 1

" CoC
set hidden
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
