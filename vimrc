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
set colorcolumn=+0 "relative to textwidth
set numberwidth=3
set scrolloff=1
set display=lastline
set listchars=tab:>\ ,trail:-,nbsp:+
set linebreak
set showbreak=>

set laststatus=2 "always show statusline
set ruler "show the cursor's line,col number and position of view in file

set grepprg=git\ --no-pager\ grep\ --no-color\ -I\ -n
set errorformat+=%m\ %f  "for :cexpr git status --porcelain

set notimeout ttimeout "disable timing out on mappings

set splitbelow splitright

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

" quickfix navigation from vim-unimpaired (don't need the whole plugin)
nnoremap ]q :cnext<cr>
nnoremap [q :cprevious<cr>

" c-l also clears search highlighting
nnoremap <c-l> :nohlsearch<cr><c-l>

" make some command mode bindings behave better
cnoremap <c-n> <down>
cnoremap <c-p> <up>
cnoremap <c-a> <home>

" tab after non-whitespace character does word completion
inoremap <expr> <tab> getline('.')[col('.')-2] =~ '\S' ? "\<c-p>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-n>" : "\<s-tab>"


" use <space> instead of <leader> to avoid conflicts with plugin mappings
nnoremap <space>w :w<cr>
nnoremap <space>q :q<cr>
nnoremap <space>e :e<cr>
nnoremap <space>x :new $HOME/.scratch<cr>
nnoremap <space>i :set invspell invnumber invlist<cr>
nnoremap <space>c :set colorcolumn=80

nnoremap <space>m :make <up>
nnoremap <space>g :grep<space>
vnoremap <space>g "xy:split\|grep -F '<c-r>x'
nnoremap <space>s :cexpr system('git status --porcelain')<cr>

nnoremap <space>h <c-w>h
nnoremap <space>j <c-w>j
nnoremap <space>k <c-w>k
nnoremap <space>l <c-w>l

nnoremap <space>t :$tabnew<cr>
nnoremap <space>< :tabmove -<cr>
nnoremap <space>> :tabmove +<cr>
nnoremap <space><tab> gt
nnoremap <space><s-tab> gT

nnoremap <space><cr> :R <up>
nnoremap <space>rb :tab .R git blame %<cr>
nnoremap <space>rl :tab R git log -p -10 %
nnoremap <space>rs :tab R git show <c-r>=expand('<cword>')<cr>


" Make a command :R similar to :r! but dumps output into a new scratch window.
" Prepend a count to start the cursor on that line number.
" Allows modifiers like :tab and :virt to control how the window opens.
command! -count -nargs=+ -complete=file R
      \ exe <q-mods> 'new'|set bt=nofile|exe '0r!'<q-args>|filet detect|<count>


augroup vimrc
  "reset the group so that if vimrc is sourced again autocmds don't run twice
  autocmd!

  autocmd FileType javascript setlocal mp=./node_modules/.bin/eslint\ -f\ unix
  autocmd FileType gitcommit setlocal spell tw=72
  autocmd FileType markdown setlocal spell tw=80
  autocmd FileType qf setlocal colorcolumn=0 nowrap nocursorline

  " auto open the quickfix window for commands that use it
  autocmd QuickFixCmdPost * botright cwindow

  " auto close the quickfix window if it is the last one open
  autocmd WinEnter * if &ft == 'qf' && winnr('$') == 1 | quit | endif

  " autoread seems to only kick in on :! and c-z so this fires it on buf change
  autocmd BufEnter * checktime

  " highlight trailing whitespace in normal mode
  autocmd InsertLeave * match Error /\s\+$/
  autocmd InsertEnter * match none
augroup end

syntax on
filetype plugin indent on

" put machine-local stuff in ~/.vimrc.local (e.g. set background)
silent! source $HOME/.vimrc.local
