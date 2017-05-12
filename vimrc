" :help 'option' for documentation about any option
set encoding=utf-8

set noswapfile
set nobackup

set autoread
set autowrite
set autochdir

set expandtab
set smarttab
set autoindent
set tabstop=2
set shiftwidth=2

set hlsearch
set incsearch
set nowrapscan
set ignorecase
set smartcase

set mouse=a
set clipboard=unnamed,unnamedplus
set backspace=indent,eol,start
set nrformats-=octal

set showcmd
set cursorline
set colorcolumn=+1
set numberwidth=3
set scrolloff=1
set display=lastline
set laststatus=2  " always show statusline
set statusline=%F\ %r%m\ %=spell=%{&spell}\ tw=%{&tw}\ %l,%c%V\ %P
set listchars=tab:>\ ,trail:-,nbsp:+
set linebreak
set showbreak=>

set foldmethod=indent
set foldlevelstart=99  " initially open all folds

set complete-=i
set infercase

set wildmode=longest,list  " bash-like command completion using <tab>
set wildignorecase

set sessionoptions=buffers,curdir,folds,tabpages,winsize
set formatoptions=tcqj


" j and k work over wrapped lines
nnoremap j gj
nnoremap k gk

" ' will jump to marked line and column
nnoremap ' `

" capital Y behaves like capital C and D
nnoremap Y y$

" auto indent on put
nnoremap p pmx=`]`x
nnoremap P Pmx=`]`x

" put over visual selection won't overwrite register with the replaced text
vnoremap p pgvy

" / in visual mode to search for whole selection (:help \V, :help c_ctrl-r)
" * and # are still faster to search for single word under cursor
vnoremap / "xy/\V<c-r>x

" tab after non-whitespace character does word completion
" shift-tab does 'smart' completion
inoremap <expr> <tab> getline('.')[col('.')-2] =~ '\S' ? "\<c-p>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-n>" : "\<c-x>\<c-o>"

" c-l also clears search highlighting
nnoremap <c-l> :nohlsearch<cr><c-l>


" use <space> instead of <leader> to avoid conflicts with plugin mappings
nnoremap <space>w :w<cr>
nnoremap <space>q :q<cr>
nnoremap <space>o :only<cr>
nnoremap <space>b :ls<cr>:b<space>
nnoremap <space>a :e #<cr>
nnoremap <space>x :e $HOME/.scratch<cr>
nnoremap <space>s :setlocal invspell<cr>
nnoremap <space>m :make<up>
nnoremap <space>n :cnext<cr>
nnoremap <space>p :cprevious<cr>

nnoremap <space>- :rightbelow split<cr>
nnoremap <space>\ :rightbelow vsplit<cr>
nnoremap <space>h <c-w>h
nnoremap <space>j <c-w>j
nnoremap <space>k <c-w>k
nnoremap <space>l <c-w>l

nnoremap <space>t :tab split<cr>
nnoremap <space><tab> gt
nnoremap <space><s-tab> gT

nnoremap <space><cr> :!<up>
vnoremap <space><cr> :w !<up>


" reset all autocommands in case vimrc is sourced twice
autocmd!

syntax on
filetype plugin indent on

" highlight trailing whitespace in normal mode
autocmd InsertLeave * match Error /\s\+$/
autocmd InsertEnter * match none

autocmd FileType gitcommit setlocal spell tw=72
autocmd FileType markdown setlocal spell tw=79
autocmd FileType javascript setlocal makeprg=$(npm\ bin)/eslint\ -f\ unix
autocmd FileType qf setlocal colorcolumn=0 nowrap nocursorline

" open full-width quickfix window on quickfix commands (:make, :grep, ...)
autocmd QuickFixCmdPost * botright cwindow

" auto close the quickfix window if it is the last one open
autocmd WinEnter * if &ft == 'qf' && winnr('$') == 1 | quit | end


try
  " https://github.com/junegunn/vim-plug
  call plug#begin()
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'

  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'scrooloose/nerdtree'

  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'scrooloose/nerdcommenter'
  Plug 'tylerbrazier/vim-bracepair'
  Plug 'tylerbrazier/vim-tagpair', {'for': 'html'}

  Plug 'pangloss/vim-javascript', {'for': 'javascript'}
  Plug 'tylerbrazier/vim-flintstone'
  Plug 'gcmt/taboo.vim'
  call plug#end()

  " show current git branch on status line
  set statusline+=\ %{fugitive#head(7)}

  " idle delay before firing CursorHold, updating gitgutter
  set updatetime=1000

  let g:ctrlp_match_window = 'max:20'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

  let g:taboo_modified_tab_flag = '[+]'

  " :help fugitive
  nmap     <space>gs :Gstatus<cr><c-n>
  nnoremap <space>gw :Gwrite<cr>
  nnoremap <space>gc :Gcommit -v <up>
  nnoremap <space>gb :Gblame<cr>
  nnoremap <space>gl :Glog --follow -- %<cr>
  nnoremap <space>gg :Ggrep -I<space>
  vnoremap <space>gg "xy:Ggrep -I -F <c-r>=shellescape(getreg('x'))<cr>

  nnoremap <space>r :TabooRename<space>
  nnoremap <space>e :NERDTreeFind<cr>
  map      <space>/ <Plug>NERDCommenterToggle

  colorscheme flintstone
catch
endtry
