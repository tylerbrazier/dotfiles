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
set nowrapscan
set ignorecase
set smartcase

set mouse=a
set clipboard=unnamedplus
set backspace=indent,eol,start
set sessionoptions-=options

set showcmd
set nowrap
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
autocmd FileType gitcommit setlocal spell


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

" tab after non-whitespace character does word completion
" shift-tab does "smart" completion
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


nnoremap <c-t> :tabnew<cr>
nnoremap <c-n> gt
nnoremap <c-p> gT

" <c--> also triggers <c-_> in the terminal
nnoremap <c-_> :split<cr>
nnoremap <c-\> :vsplit<cr>

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l


let mapleader = ' '

nnoremap <leader>n :setlocal invnumber<cr>
nnoremap <leader>w :setlocal textwidth=79<cr>
nnoremap <leader>s :setlocal invspell<cr>

" fix misspelled word under cursor
nnoremap <leader>m a<c-x>s

nnoremap <leader>l :nohlsearch<cr>:redraw!<cr>
nnoremap <leader>b :ls<cr>:b<space>
nnoremap <leader>e :Explore<cr>
nnoremap <leader>x :e $HOME/.scratch<cr>


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

  Plug 'tylerbrazier/molokai'

  Plug 'pangloss/vim-javascript', {'for': 'javascript'}
  Plug 'tylerbrazier/HTML-AutoCloseTag', {'for': 'html'}

  call plug#end()

  " idle delay before triggering CursorHold, updating gitgutter
  set updatetime=1000

  " gitgutter diffs against HEAD instead of the index
  let g:gitgutter_diff_base = 'HEAD'

  " hacky git ls-files search until fugitive has this functionality
  " https://github.com/tpope/vim-fugitive/issues/132
  set errorformat+=%f  " allow selecting lines with just filenames in quickfix
  nnoremap <leader>f :Gcd\|:copen\|:cgetexpr
        \ system('git ls-files \\| grep -i ')<left><left>

  nnoremap <leader>g :Gcd\|:copen\|silent Ggrep! -i<space>

  map <leader>/ <Plug>NERDCommenterToggle

  colorscheme molokai
catch
endtry
