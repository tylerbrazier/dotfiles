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

" c-l also clears search highlighting
nnoremap <c-l> :nohlsearch<cr><c-l>

" make some command mode bindings behave better
cnoremap <c-n> <down>
cnoremap <c-p> <up>
cnoremap <c-a> <home>

" tab after non-whitespace character does word completion
inoremap <expr> <tab> getline('.')[col('.')-2] =~ '\S' ? "\<c-p>" : "\<tab>"

let mapleader = ' '

nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>e :e<cr>
nnoremap <leader>x :e $HOME/.scratch<cr>

nnoremap <leader>g :grep<space>
nnoremap <leader>c :cexpr system('git status --porcelain')<cr>
nnoremap <leader>n :cn<cr>
nnoremap <leader>p :cp<cr>

nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l
nnoremap <leader>s <c-w>s
nnoremap <leader>v <c-w>v
nnoremap <leader>o <c-w>o

nnoremap <leader>b :tab .R git blame %<cr>
nnoremap <leader>y :tab R git log -p -10 %
nnoremap <leader>z :tab R git show <c-r>=expand('<cword>')<cr>

nnoremap <leader>t :tabnew<cr>
nnoremap <leader>< :tabmove -<cr>
nnoremap <leader>> :tabmove +<cr>
nnoremap <leader><tab> gt
nnoremap <leader><s-tab> gT

nnoremap <leader><cr> :!<up>
vnoremap <leader><cr> :w !<up>


" Make a command :R similar to :r! but dumps output into a new scratch window.
" Prepend a count to start the cursor on that line number.
" Allows modifiers like :tab and :virt to control how the window opens.
command! -count -nargs=+ -complete=file R
      \ exe <q-mods> 'new'|set bt=nofile|exe '0r!'<q-args>|filet detect|<count>


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
  Plug 'justinmk/vim-dirvish'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'airblade/vim-gitgutter'
  Plug 'tylerbrazier/vim-flintstone'
  Plug 'tylerbrazier/vim-bracepair'
  Plug 'tylerbrazier/vim-tagpair', {'for': 'html'}
  Plug 'pangloss/vim-javascript', {'for': 'javascript'}
  Plug 'gcmt/taboo.vim'
  call plug#end()

  " idle delay before firing CursorHold, updating gitgutter
  set updatetime=1000

  let g:ctrlp_switch_buffer = 0
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

  nnoremap <leader>r :TabooRename<space>
  nmap <leader>d <plug>GitGutterPreviewHunk
  nmap <leader>a <plug>GitGutterStageHunk
  nmap <leader>u <plug>GitGutterUndoHunk

  colorscheme flintstone
catch
endtry
