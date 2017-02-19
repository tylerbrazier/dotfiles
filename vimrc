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
set colorcolumn=80
set numberwidth=3
set scrolloff=1
set display=lastline
set laststatus=2  " always show statusline
set statusline=%f\ %y%r%m%=spell=%{&spell}\ tw=%{&tw}\ %l,%c%V\ %P
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
nnoremap <space>d :ls<cr>:bd<space>
nnoremap <space>a :e #<cr>
nnoremap <space>x :e $HOME/.scratch<cr>
nnoremap <space>s :wa\|mksession! <c-r>=v:this_session<cr>
nnoremap <space>n :setlocal invnumber<cr>
nnoremap <space>z :setlocal invspell<cr>
nnoremap <space>- :rightbelow new<cr>
nnoremap <space>\ :rightbelow vnew<cr>
nnoremap <space>h <c-w>h
nnoremap <space>j <c-w>j
nnoremap <space>k <c-w>k
nnoremap <space>l <c-w>l
nnoremap <space>t :tabnew<cr>
nnoremap <space><tab> gt
nnoremap <space><s-tab> gT
nnoremap <space><cr> :!


" reset all autocommands in case vimrc is sourced twice
autocmd!

syntax on
filetype plugin indent on

autocmd FileType gitcommit setlocal spell tw=72
autocmd FileType markdown setlocal spell tw=79

" highlight trailing whitespace in normal mode
autocmd InsertLeave * match Error /\s\+$/
autocmd InsertEnter * match none


if has('nvim')
  tnoremap <esc> <c-\><c-n>
  nnoremap <space><cr> :terminal<cr>
endif


try
  " https://github.com/junegunn/vim-plug
  call plug#begin()
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'

  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'scrooloose/nerdtree'

  Plug 'scrooloose/nerdcommenter'
  Plug 'tylerbrazier/vim-bracepair'
  Plug 'tylerbrazier/vim-tagpair', {'for': 'html'}

  Plug 'pangloss/vim-javascript', {'for': 'javascript'}
  Plug 'tylerbrazier/vim-flintstone'
  call plug#end()

  " show current git branch on status line
  set statusline+=\ %{fugitive#head(7)}

  set updatetime=1000 " idle delay before firing CursorHold, updating gitgutter
  let g:gitgutter_diff_base = 'HEAD' " diff against HEAD instead of the index

  " <c-p> for recent files, then <c-f> to find anything else tracked by git
  let g:ctrlp_cmd = 'CtrlPMRU'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
  let g:ctrlp_regexp = 1 "regex instead of fuzzy; <c-r> to toggle

  " :help fugitive
  nmap     <space>gs :Gstatus<cr><c-n>
  nnoremap <space>gw :Gwrite<cr>
  nnoremap <space>ga :wa\|Git add -A<space>
  nnoremap <space>gc :Gcommit -v<space>
  nnoremap <space>gd :Gvdiff<space>
  nnoremap <space>gu :Git push -u origin <c-r>=fugitive#head()<cr><space>
  nnoremap <space>gp :Git pull --ff-only<space>
  nnoremap <space>gl :copen<cr><c-w>p:silent Glog --
  vnoremap <space>gl :Glog<cr>:copen<cr>
  nnoremap <space>gg :copen\|silent Ggrep! -i<space>
  vnoremap <space>gg "xy:copen\|sil Ggrep! -F <c-r>=shellescape(getreg('x'))<cr>
  nnoremap <space>gb :Gblame<cr>
  nnoremap <space>g<cr> :Git<space>

  nnoremap <space>e :NERDTreeFind<cr>
  map      <space>/ <Plug>NERDCommenterToggle

  colorscheme flintstone
catch
endtry
