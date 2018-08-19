" don't make unnecessary files
set nobackup
set noswapfile

" enable the mouse in all modes, use system clipboard
set mouse=a
set clipboard=unnamed,unnamedplus

" case insensitive search and completion
set ignorecase
set smartcase  "case sensitive if search contains a capital letter
set infercase
set wildignorecase

" fold indented lines, initially all folds are open
set foldmethod=indent
set foldlevelstart=99

" make horizontal splits open below, vertical splits to the right
set splitbelow
set splitright

"disable timing out on mappings
set notimeout
set ttimeout

" wrap lines at word boundaries and show > on wrapped lines
set linebreak
set showbreak=>

" show colorcolumn at textwidth by default
set colorcolumn=+0

" don't wrap search at end of file because I tend to lose context
set nowrapscan

" bash-like command completion
set wildmode=list:longest

" sensible settings and neovim defaults
" https://github.com/tpope/vim-sensible
" https://neovim.io/doc/user/vim_diff.html
syntax on
filetype plugin indent on
set autoindent
set autoread
set backspace=indent,eol,start
set belloff=all
set complete-=i
set display=lastline
set encoding=utf-8
set formatoptions=tcqj
set history=1000
set hlsearch
set incsearch
set laststatus=2
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set nrformats=bin,hex
set ruler
set sessionoptions-=options
set showcmd
set scrolloff=1
set sidescrolloff=5
set smarttab
set tabpagemax=50
set tags=./tags;,tags
set viminfo^=!
set wildmenu
nnoremap <c-l> :nohlsearch<cr><c-l>

" j and k work over wrapped lines
nnoremap j gj
nnoremap k gk

" capital Y behaves like capital C and D
nnoremap Y y$

" ' will jump to marked line and column
nnoremap ' `

" auto indent on put
nnoremap p pmx=`]`x
nnoremap P Pmx=`]`x

" put over visual selection won't overwrite register with the replaced text
vnoremap p pgvy

" make some command mode bindings behave better
cnoremap <c-n> <down>
cnoremap <c-p> <up>
cnoremap <c-a> <home>

" tab after non-whitespace character does word completion
inoremap <expr> <tab> getline('.')[col('.')-2] =~ '\S' ? "\<c-p>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-n>" : "\<s-tab>"

" shortcuts use <space> instead of <leader> to avoid conflicts with plugins
nnoremap <space>w :w<cr>
nnoremap <space>q :q<cr>
nnoremap <space>e :e<cr>

" shortcuts to toggle or set options
nnoremap <space>on :setlocal invnumber number?<cr>
nnoremap <space>os :setlocal invspell spell?<cr>
nnoremap <space>ow :setlocal invwrap wrap?<cr>
nnoremap <space>ol :setlocal invlist list?<cr>
nnoremap <space>oet :setlocal invexpandtab expandtab?<cr>
nnoremap <space>ocl :setlocal invcursorline cursorline?<cr>
nnoremap <space>occ :setlocal colorcolumn=<c-r>=&cc<cr>
nnoremap <space>otw :setlocal textwidth=<c-r>=&tw<cr>
nnoremap <space>ots :setlocal tabstop=<c-r>=&ts<cr>

nnoremap <space>a :!git add -A <up>
nnoremap <space>c :!git commit -v <up>
nnoremap <space>u :!git push -u <up>
nnoremap <space>d :!git pull --rebase --autostash <up>

" git status: show changed files in the quickfix list
set errorformat+=%m\ %f
nnoremap <space>s :cexpr system('git status --porcelain')<cr>

" grep in tracked files, works on visual selection
" NOTE grep is relative to :pwd. Start vim in project root or use :cd
set grepprg=git\ --no-pager\ grep\ --no-color\ -I\ -n
nnoremap <space>g :grep<space>
vnoremap <space>g "xy:split\|grep -F '<c-r>x'

" auto write on :make (and some other commands)
set autowrite
nnoremap <space>m :make <up>

" easier quickfix navigation
nnoremap <space>n :cn<cr>
nnoremap <space>p :cp<cr>

" new tab shortcut opens it at the end of the list
nnoremap <space>t :$tabnew<cr>

" easier tab navigation
nnoremap <space><tab> gt
nnoremap <space><s-tab> gT

" shortcut to open a scratch file in a new window
nnoremap <space>x :new $HOME/.scratch<cr>

" easier window navigation
nnoremap <space>h <c-w>h
nnoremap <space>j <c-w>j
nnoremap <space>k <c-w>k
nnoremap <space>l <c-w>l

" Make a command :R similar to :r! but dumps output into a new scratch window.
" Prepend a count to start the cursor on that line number.
" Allows modifiers like :tab and :vert to control how the window opens.
command! -count -nargs=+ -complete=file R
      \ exe <q-mods> 'new'|set bt=nofile|exe '0r!'<q-args>|filet detect|<count>

nnoremap <space><cr> :R <up>

nnoremap <space>rb :tab .R git blame %<cr>
nnoremap <space>rl :tab R git log --stat -p -9 %
nnoremap <space>rs :R git show <c-r>=expand('<cword>')<cr>
nnoremap <space>rd :R git diff <up>

augroup vimrc
  "reset the group so that if vimrc is sourced again autocmds don't run twice
  autocmd!

  autocmd FileType javascript setlocal mp=./node_modules/.bin/eslint\ -f\ unix
  autocmd FileType gitcommit setlocal spell tw=72
  autocmd FileType markdown setlocal spell tw=80
  autocmd FileType qf setlocal colorcolumn=0 nowrap

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

" put machine-local stuff in ~/.vimrc.local (e.g. set background)
silent! source $HOME/.vimrc.local
