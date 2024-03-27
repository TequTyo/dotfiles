syntax on
filetype plugin indent on

set relativenumber
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set noexpandtab
set smartindent
set nocompatible
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set autoindent
set undofile
set incsearch
set path+=**
set wildmenu
set showcmd
set novisualbell
set wildmode=longest,list,full
set splitright splitbelow
set fileformat=unix
set encoding=utf-8
set fileencoding=utf-8
set colorcolumn=110
set background=dark
set lbr
set tw=500

inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>0
inoremap {;<CR> {<CR>};<ESC>0

highlight ColorColumn ctermbg=0 guibg=lightgrey

autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType css setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2

if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'mbbill/undotree'
Plug 'Chiel92/vim-autoformat'
Plug 'tell-k/vim-autopep8'
Plug 'puremourning/vimspector'
call plug#end()

let g:vimcspector_enable_mappings = 'HUMAN'
