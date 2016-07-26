set autochdir
set autoindent
set autoread
set autowrite
set backspace=indent,eol,start
set clipboard=unnamedplus
set colorcolumn=80
set complete-=i
set completeopt-=preview
set display=lastline
set encoding=utf-8
set expandtab
set foldlevelstart=99
set foldmethod=indent
set formatoptions+=j
set hlsearch
set ignorecase
set incsearch
set infercase
set laststatus=2
set listchars=tab:>\ ,trail:-,nbsp:+
set mouse=a
set nobackup
set noswapfile
set nrformats-=octal
set numberwidth=3
set scrolloff=1
set sessionoptions-=options
set shiftwidth=2
set showcmd
set smartcase
set smarttab
set tabstop=2
set updatetime=1000
set wildignorecase
set wildmode=longest,list

autocmd!
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

filetype plugin indent on
syntax on

nnoremap j gj
nnoremap k gk
nnoremap ' `
nnoremap q :q<cr>
nnoremap <c-l> :nohlsearch<cr><c-l>
nnoremap <c-n> :GFiles<cr>
nnoremap <c-p> :Buffers<cr>
" capital Y should behave like capital C and D
nnoremap Y y$
" auto format pasted text
nnoremap p pmx=`]`x
nnoremap P Pmx=`]`x
" for searching multiple words:  (use * to search for single word under cursor)
vnoremap / "xy/<c-r>=escape(getreg('x'), '/~.*^$[]\')<cr>
" let `-` work like `cd -` and `git checkout -` but for buffers
nnoremap - :buffer #<cr>
" tab after non-whitespace char does completion
inoremap <expr> <tab> getline('.')[col('.')-2] =~ '\S' ? "\<c-p>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-n>" : "\<c-x>\<c-o>"
" enter to start a command
nnoremap <expr> <cr> &buftype != 'quickfix' ? ':' : "\<cr>"
" insert mode enter selects completion options and expands braces and html tags
imap <expr> <cr> pumvisible() ? "\<c-y>\<esc>" :
      \ exists('b:loaded_autoclosetag') ? '<Plug>HtmlExpandCR' :
      \ exists('g:loaded_bracepair') ? '<Plug>bracepairExpandCR' :
      \ "\<cr>"

let mapleader = ' '
nnoremap <leader>n :setlocal invnumber<cr>
nnoremap <leader>w :setlocal textwidth=80<cr>
nnoremap <leader>s :setlocal invspell<cr>
" fix misspelled word:
nnoremap <leader>m a<c-x>s
nnoremap <leader>t :terminal<cr>
nnoremap <leader>x :edit $HOME/.scratch<cr>
" git grep:
nnoremap <leader>g :copen\|silent Ggrep! -i<space>
" git grep for visual selection:
vnoremap <leader>g "xy:copen\|silent Ggrep! -i '<c-r>=getreg('x')<cr>'
nnoremap <leader>e :NERDTreeToggle<cr>
map      <leader>/ <Plug>NERDCommenterToggle
" <c-/> triggers <c-_> in the terminal
map      <c-_>     <Plug>NERDCommenterToggle

nnoremap <a-t> :tabnew<cr>
nnoremap <a-n> :tabnext<cr>
nnoremap <a-p> :tabprevious<cr>
nnoremap <a-s> :split<cr>
nnoremap <a-v> :vsplit<cr>
nnoremap <a-h> <c-w>h
nnoremap <a-j> <c-w>j
nnoremap <a-k> <c-w>k
nnoremap <a-l> <c-w>l
inoremap <a-t> <esc>:tabnew<cr>
inoremap <a-n> <esc>:tabnext<cr>
inoremap <a-p> <esc>:tabprevious<cr>
inoremap <a-s> <esc>:split<cr>
inoremap <a-v> <esc>:vsplit<cr>
inoremap <a-h> <esc><c-w>h
inoremap <a-j> <esc><c-w>j
inoremap <a-k> <esc><c-w>k
inoremap <a-l> <esc><c-w>l
if has('nvim')
  tnoremap <a-[> <c-\><c-n>
  tnoremap <a-t> <c-\><c-n>:tabnew<cr>
  tnoremap <a-n> <c-\><c-n>:tabnext<cr>
  tnoremap <a-p> <c-\><c-n>:tabprevious<cr>
  tnoremap <a-s> <c-\><c-n>:split +terminal<cr>
  tnoremap <a-v> <c-\><c-n>:vsplit +terminal<cr>
  tnoremap <a-h> <c-\><c-n><c-w>h
  tnoremap <a-j> <c-\><c-n><c-w>j
  tnoremap <a-k> <c-\><c-n><c-w>k
  tnoremap <a-l> <c-\><c-n><c-w>l
else
  " Allow terminal to recognize escape sequences with alt:
  " http://stackoverflow.com/a/10216459
  " http://vim.wikia.com/wiki/Get_Alt_key_to_work_in_terminal
  set ttimeout ttimeoutlen=0
  for i in range(char2nr('a'), char2nr('z'))
    execute 'set <a-'.nr2char(i).">=\e".nr2char(i)
  endfor
endif

try
  call plug#begin() " https://github.com/junegunn/vim-plug
  Plug 'tylerbrazier/molokai'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
  Plug 'scrooloose/nerdcommenter'
  Plug 'tylerbrazier/vim-bracepair'
  Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all --no-update-rc'}
  Plug 'junegunn/fzf.vim'
  Plug 'pangloss/vim-javascript', {'for': 'javascript'}
  Plug 'tylerbrazier/HTML-AutoCloseTag', {'for': 'html'}
  call plug#end()

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
