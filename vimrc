" Get rid of Vi compatibility mode. SET FIRST!
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
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
set nowrap                " don't wrap text
set laststatus=2          " last window always has a statusline

" Clipboard / Copy and paste
set clipboard=unnamed

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q>   	<C-V>

" CTRL-X is Cut
vnoremap <C-x> "+x

" CTRL-C is Copy
vnoremap <C-c> "+y

" CTRL-V is Paste
map <C-v>   	"+gP

" Colors
set t_Co=256

set background=light
colorscheme solarized

" Use the same symbols as TextMate for tabstops and EOLs
" TODO: incompatible with Mac 
" set listchars=tab:▸\ ,eol:¬

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
set number                " show line numbers
set ruler                 " Always show info along bottom.
syntax enable             " enable syntax highlighting (previously syntax on).
filetype on               " Enable file type detection
filetype indent on        " activates indenting for files
filetype plugin indent on " filetype detection[ON] plugin[ON] indent[ON]
set autoindent            " auto-indent

" Search
set ignorecase            " Make searches case-insensitive.
set nohlsearch              " Don't continue to highlight searched phrases.
set incsearch             " But do highlight as you type your search.

" Only do this part when compiled with support for autocommands
if has("autocmd")

  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " Customisations based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab

  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml
endif
