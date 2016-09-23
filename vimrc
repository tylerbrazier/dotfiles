set encoding=utf-8

set expandtab
set smarttab
set autoindent
set tabstop=2
set shiftwidth=2

set autoread
set autowrite
set autochdir

set noswapfile
set nobackup

set hlsearch
set incsearch
set ignorecase
set smartcase

set mouse=a
set clipboard=unnamedplus
set backspace=indent,eol,start

set showcmd
set colorcolumn=80
set numberwidth=3
set laststatus=2
set scrolloff=1
set display=lastline
set listchars=tab:>\ ,trail:-,nbsp:+

set infercase
set complete-=i           " don't scan includes
set completeopt-=preview  " no annoying preview window

set formatoptions+=j  " J (join lines) removes unnecessary comment characters
set nrformats-=octal  " ctrl-a/x doesn't treat a number with leading 0 as octal

set wildmode=longest,list  " bash-like command completion
set wildignorecase


" reset all autocommands in case vimrc is sourced twice
autocmd!

filetype plugin indent on
syntax on

" disable auto comment on next line when hitting enter or using o/O.
" still works with textwidth. autocmd because setting filetype resets these opts
autocmd FileType * setlocal formatoptions-=r formatoptions-=o


nnoremap j gj
nnoremap k gk
nnoremap ' `
nnoremap q :q<cr>

" capital Y behaves like capital C and D
nnoremap Y y$

" auto format pasted text
nnoremap p pmx=`]`x
nnoremap P Pmx=`]`x

" / works on visual selection (use * or # to search for word under cursor)
vnoremap / "xy/<c-r>=escape(getreg('x'), '/~.*^$[]\')<cr>

" - works like cd - and git checkout - but for buffers
nnoremap - :buffer #<cr>

" tab after non-whitespace character does completion
inoremap <expr> <tab> getline('.')[col('.')-2] =~ '\S' ? "\<c-p>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-n>" : "\<c-x>\<c-o>"

" backspace for previous shell command
nnoremap <bs> :!<up>

" enter to start a vim command (not in quickfix window)
nnoremap <expr> <cr> &buftype == 'quickfix' ? "\<cr>" : ':'

" insert-mode enter selects completion options and expands braces and html tags
imap <expr> <cr> pumvisible() ? "\<c-y>\<esc>" :
      \ exists('b:loaded_autoclosetag') ? '<Plug>HtmlExpandCR' :
      \ exists('g:loaded_bracepair') ? '<Plug>bracepairExpandCR' :
      \ "\<cr>"


let mapleader = ' '

nnoremap <leader>n :setlocal invnumber<cr>
nnoremap <leader>w :setlocal textwidth=80<cr>
nnoremap <leader>s :setlocal invspell<cr>

" fix misspelled word under cursor
nnoremap <leader>m a<c-x>s

nnoremap <leader>e :Explore<cr>
nnoremap <leader>b :ls<cr>:buffer<space>
nnoremap <leader>x :edit $HOME/.scratch<cr>

nnoremap <leader>l :nohlsearch<cr>:redraw!<cr>


" <c--> also triggers <c-_> in the terminal
nnoremap <c-_> :split<cr>
nnoremap <c-\> :vsplit<cr>

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

nnoremap <c-t> :tabnew<cr>
nnoremap <c-n> gt
nnoremap <c-p> gT

if has('nvim')
  nnoremap <leader>t :terminal<cr>

  tnoremap <esc> <c-\><c-n>

  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
endif


try
  " https://github.com/junegunn/vim-plug
  call plug#begin()

  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'

  Plug 'scrooloose/nerdcommenter'
  Plug 'tylerbrazier/vim-bracepair'

  Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all --no-update-rc'}
  Plug 'junegunn/fzf.vim'

  Plug 'tylerbrazier/molokai'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'jamessan/vim-gnupg'
  Plug 'pangloss/vim-javascript', {'for': 'javascript'}
  Plug 'tylerbrazier/HTML-AutoCloseTag', {'for': 'html'}

  call plug#end()

  " idle delay before triggering CursorHold, updating gitgutter
  set updatetime=1000

  map <leader>/ <Plug>NERDCommenterToggle

  nnoremap <leader>f :GFiles<cr>
  nnoremap <leader>b :Buffers<cr>

  " git grep (works on visual selection)
  nnoremap <leader>g :copen\|silent Ggrep! -i<space>
  vnoremap <leader>g "xy:copen\|silent Ggrep! -i '<c-r>=getreg('x')<cr>'

  colorscheme molokai

  let g:airline_theme = 'murmur'
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_splits = 0
  let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#tabline#show_tab_nr = 0
  let g:airline#extensions#tabline#show_tab_type = 0
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#right_sep = ''
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#right_alt_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''
catch
endtry
