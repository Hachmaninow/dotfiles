" Get rid of Vi compatibility mode. SET FIRST!
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-sensible'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bling/vim-bufferline'
Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let g:airline_theme='solarized'

" Basic settings
set encoding=utf-8
set wrap                  " wrap text...
set linebreak             " ...but only at specific characters
set laststatus=2          " last window always has a statusline

" Clipboard / Copy and paste
set clipboard=unnamedplus

" Colors
set t_Co=256

syntax enable
set background=dark
colorscheme solarized

" Tab settings
set tabstop=2             " tab spacing
set softtabstop=2         " unify
set shiftwidth=2          " indent/outdent by 2 columns
set expandtab             " use spaces instead of tabs
set shiftround            " always indent/outdent to the nearest tabstop

" Tab navigation using ctrl-tab-key
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

" Remap K to split line
:nnoremap K i<CR><Esc>

" Buffers
set hidden                " automatically hide unsaved buffer

" Programming
set number
set relativenumber
set ruler                 " Always show info along bottom.
syntax enable             " enable syntax highlighting (previously syntax on).
filetype on               " Enable file type detection
filetype indent on        " activates indenting for files
filetype plugin indent on " filetype detection[ON] plugin[ON] indent[ON]
set autoindent            " auto-indent

" Search
set ignorecase            " Make searches case-insensitive.
set smartcase             " Automatically switch to a case-sensitive search if you use any capital letters.
set hlsearch              " Highlight searched phrases.
set incsearch             " Start to highlight as you type your search.
