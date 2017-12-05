" :help 'option' for documentation about any option
set encoding=utf-8

set noswapfile
set nobackup

set autoread
set autowrite

set expandtab
set tabstop=2
set shiftwidth=0 "match tabstop
set smarttab
set autoindent

set hlsearch
set incsearch
set nowrapscan
set ignorecase
set smartcase

set mouse=a
set clipboard=unnamed,unnamedplus
set backspace=indent,eol,start
set nrformats-=octal
set formatoptions+=j

set showcmd
set cursorline
set colorcolumn=+1 "relative to textwidth
set numberwidth=3
set scrolloff=1
set display=lastline
set listchars=tab:>\ ,trail:-,nbsp:+
set linebreak
set showbreak=>

set laststatus=2 "always show statusline
set ruler "show the cursor's line,col number and position of view in file

set grepprg=git\ --no-pager\ grep\ --no-color\ -I\ -n
set errorformat=%f:%l:%m,%m\ %f  "for git grep,status

set notimeout ttimeout "disable timing out on mappings

set foldmethod=indent
set foldlevelstart=99 "initially open all folds

set complete-=i
set infercase

set wildmode=longest,list "bash-like command completion using <tab>
set wildignorecase


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

" tab after non-whitespace character does word completion
" shift-tab does 'smart' completion
inoremap <expr> <tab> getline('.')[col('.')-2] =~ '\S' ? "\<c-p>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-n>" : "\<c-x>\<c-o>"

" c-l also clears search highlighting
nnoremap <c-l> :nohlsearch<cr><c-l>


" use <space> instead of <leader> to avoid conflicts with plugin mappings
nnoremap <space>w :w<cr>
nnoremap <space>q :q<cr>
nnoremap <space>e :e<cr>
nnoremap <space>x :e $HOME/.scratch<cr>

nnoremap <space>g :grep<space>
nnoremap <space>s :cexpr system('git status --porcelain')<cr>
nnoremap <space>n :cnext<cr>
nnoremap <space>p :cprevious<cr>

nnoremap <space>- :rightbelow new<cr>
nnoremap <space>\ :rightbelow vnew<cr>
nnoremap <space>o :only<cr>
nnoremap <space>h <c-w>h
nnoremap <space>j <c-w>j
nnoremap <space>k <c-w>k
nnoremap <space>l <c-w>l

nnoremap <space>t :tabnew<cr>
nnoremap <space>< :tabmove -<cr>
nnoremap <space>> :tabmove +<cr>
nnoremap <space><tab> gt
nnoremap <space><s-tab> gT

nnoremap <space><cr> :!<up>
vnoremap <space><cr> :w !<up>


" reset all autocommands in case vimrc is sourced twice
autocmd!

syntax on
filetype plugin indent on

autocmd FileType gitcommit setlocal spell tw=72
autocmd FileType markdown setlocal spell tw=79
autocmd FileType qf setlocal colorcolumn=0 nowrap nocursorline

" auto open the quickfix window for commands that use it
autocmd QuickFixCmdPost * cwindow

" auto close the quickfix window if it is the last one open
autocmd WinEnter * if &ft == 'qf' && winnr('$') == 1 | quit | endif

" autoread seems to only kick in on :! and c-z so this fires it on buf change
autocmd BufEnter * checktime

" highlight trailing whitespace in normal mode
autocmd InsertLeave * match Error /\s\+$/
autocmd InsertEnter * match none


try
  " https://github.com/junegunn/vim-plug
  call plug#begin()
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'airblade/vim-gitgutter'
  Plug 'tylerbrazier/vim-flintstone'
  Plug 'tylerbrazier/vim-chronolog'
  Plug 'tylerbrazier/vim-bracepair'
  Plug 'tylerbrazier/vim-tagpair', {'for': 'html'}
  Plug 'pangloss/vim-javascript', {'for': 'javascript'}
  Plug 'gcmt/taboo.vim'
  call plug#end()

  " idle delay before firing CursorHold, updating gitgutter
  set updatetime=1000

  let g:ctrlp_switch_buffer = 0
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

  nnoremap <space>r :TabooRename<space>
  nnoremap <space>f :NERDTreeFind<cr>
  nnoremap <space>d :GitGutterPreviewHunk<cr>
  nnoremap <space>a :GitGutterStageHunk<cr>
  nnoremap <space>u :GitGutterUndoHunk<cr>
  nnoremap <space>b :tab ChronoBlame %<cr>
  nnoremap <space>y :tab ChronoLog -p -10 %
  nnoremap <space>z :tab ChronoShow <c-r>=expand('<cword>')<cr>

  colorscheme flintstone
catch
endtry
