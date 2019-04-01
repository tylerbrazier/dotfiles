" common settings (defaults.vim, sensible, neovim defaults)
syntax enable
filetype plugin indent on
set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set belloff=all
set complete-=i
set display+=lastline
set encoding=utf-8
set formatoptions+=j
set history=1000
set hlsearch
set incsearch
set laststatus=2
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set mouse=a
set nrformats-=octal
set ruler
set scrolloff=5 sidescrolloff=5
set showcmd
set sidescroll=1
set smarttab
set tabpagemax=50
set tags=./tags;,tags
set ttimeout
set ttimeoutlen=100
set wildmenu

" write a file when leaving it
set autowriteall

" use the system clipboard for yank, delete, change, and put operations
set clipboard=unnamed,unnamedplus

" case insensitive search and completion
set ignorecase wildignorecase infercase
set smartcase "case sensitive if search contains a capital letter

" stop shitting out unnecessary files
set nobackup noswapfile

" wrap lines at word boundaries and show > on wrapped lines
set linebreak showbreak=>

" show colorcolumn at textwidth
set colorcolumn=+0

" helps not to lose context when searching
set nowrapscan

" show all completion suggestions, like bash
set wildmode=list:longest

" idle delay before firing CursorHold (updates gitgutter right away)
set updatetime=100

" make ctrlp ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" make j and k work over wrapped lines
nnoremap j gj
nnoremap k gk

" capital Y should behave like capital C and D (use yy to yank whole line)
nnoremap Y y$

" ' will jump to marked line and column
nnoremap ' `

" auto indent on put
nnoremap p p=`]
nnoremap P P=`]

" put over visual selection won't overwrite register with the replaced text
vnoremap p pgvy

" use Tab to complete words (suggest recent words first)
inoremap <expr> <Tab> getline('.')[col('.')-2] =~ '\S' ? "\<C-P>" : "\<Tab>"

nnoremap <Space>w :w<CR>
nnoremap <Space>q :q<CR>
nnoremap <Space>e :e <C-D>
nnoremap <Space>b :ls<CR>:b
nnoremap <Space>t :tabedit<CR>
nnoremap <Space>x :new $HOME/.scratch<CR>
nnoremap <Space>m :make <Up>
nnoremap <Space><CR> :!<Up>

" copy current filename to system clipboard (for e.g. cli operations)
nnoremap <Space>c :let @*=@%<Bar>let @+=@%<CR>

" git status: show changed files in the quickfix list
set errorformat+=%m\ %f
nnoremap <Space>s :cexpr system('git status --porcelain')<CR>

" grep tracked files (relative to :pwd)
set grepprg=git\ --no-pager\ grep\ --no-color\ -I\ -n
nnoremap <Space>g :grep<Space>

augroup vimrc
  autocmd!

  autocmd FileType gitcommit setlocal spell
  autocmd FileType qf setlocal nowrap colorcolumn=0

  " auto open the quickfix window for commands that use it
  autocmd QuickFixCmdPost * botright cwindow

  " auto close the quickfix window if it is the last one open
  autocmd WinEnter * if &ft == 'qf' && winnr('$') == 1 | quit | endif

  " highlight trailing whitespace in normal mode
  autocmd InsertLeave * match Error /\s\+$/
  autocmd InsertEnter * match none
augroup end
