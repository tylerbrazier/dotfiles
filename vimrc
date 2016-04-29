set autochdir
set autoindent
set autoread
set autowriteall
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

" reset autocmds so sourcing vimrc again doesn't run them twice
autocmd!
" autosave in normal mode every 'updatetime' millis if able
autocmd CursorHold * silent! update
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

filetype plugin indent on
syntax on

nnoremap ' `
nnoremap q :q
" capital Y should behave like capital C and D
nnoremap Y y$
" auto format pasted text:
nnoremap p pmx=`]`x
nnoremap P Pmx=`]`x
nnoremap j gj
nnoremap k gk
nnoremap <bs> :!
nnoremap <bs><bs> :!!<cr>
nnoremap <cr> :
" enter in insert mode selects completion options and expands braces, html tags
imap <expr> <cr> pumvisible() ? "\<c-y>\<esc>" :
      \ exists('b:loaded_autoclosetag') ? '<Plug>HtmlExpandCR' :
      \ exists('g:loaded_bracepair') ? '<Plug>bracepairExpandCR' :
      \ "\<cr>"

nnoremap <m-t> :tabnew<cr>
nnoremap <m-n> :tabnext<cr>
nnoremap <m-p> :tabprevious<cr>
nnoremap <m-s> :split<cr>
nnoremap <m-v> :vsplit<cr>
nnoremap <m-h> <c-w>h
nnoremap <m-j> <c-w>j
nnoremap <m-k> <c-w>k
nnoremap <m-l> <c-w>l
nnoremap <m-d> :bprevious\|bdelete #<cr>
nnoremap <m-q> :quit<cr>
if has('nvim')
  tnoremap <m-[> <c-\><c-n>
  tnoremap <m-t> <c-\><c-n>:tabnew<cr>
  tnoremap <m-n> <c-\><c-n>:tabnext<cr>
  tnoremap <m-p> <c-\><c-n>:tabprevious<cr>
  tnoremap <m-s> <c-\><c-n>:split +terminal<cr>
  tnoremap <m-v> <c-\><c-n>:vsplit +terminal<cr>
  tnoremap <m-h> <c-\><c-n><c-w>h
  tnoremap <m-j> <c-\><c-n><c-w>j
  tnoremap <m-k> <c-\><c-n><c-w>k
  tnoremap <m-l> <c-\><c-n><c-w>l
  tnoremap <m-d> <c-\><c-n>:bprevious\|bdelete #<cr>
  tnoremap <m-q> <c-\><c-n>:quit<cr>
else
  " Allow terminal to recognize escape sequences with alt:
  " http://stackoverflow.com/a/10216459
  " http://vim.wikia.com/wiki/Get_Alt_key_to_work_in_terminal
  set ttimeout ttimeoutlen=0
  for i in range(char2nr('a'), char2nr('z'))
    execute 'set <m-'.nr2char(i).">=\e".nr2char(i)
  endfor
endif

let mapleader = ' '
nnoremap <leader>h :setlocal invhlsearch<cr>
nnoremap <leader>n :setlocal invnumber<cr>
map <leader>c <Plug>NERDCommenterToggle
map <leader>/ <Plug>NERDCommenterToggle
" <c-/> triggers <c-_> in the terminal
map <c-_>     <Plug>NERDCommenterToggle
nnoremap <leader>f :NERDTreeToggle<cr>
nnoremap <leader>s :setlocal invspell<cr>
" fix misspelled word:
nnoremap <leader>m a<c-x>s
nnoremap <leader>t :terminal<cr>
nnoremap <leader>w :setlocal textwidth=80<cr>
nnoremap <leader>e :edit $HOME/.scratch<cr>
nnoremap <leader>gf :GitFiles<cr>
nnoremap <leader>gb :Gblame<cr>
nmap     <leader>gd <Plug>GitGutterPreviewHunk<c-w>p
nmap     <leader>gr <Plug>GitGutterRevertHunk


" https://github.com/junegunn/vim-plug
" finish executing vimrc if vim-plug isn't installed
try | call plug#begin() | catch | finish | endtry
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tylerbrazier/molokai'
Plug 'tylerbrazier/vim-bracepair'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-update-rc' }
Plug 'junegunn/fzf.vim'
Plug 'ervandew/supertab'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'tylerbrazier/HTML-AutoCloseTag', { 'for': 'html' }
call plug#end()

" silent in case plugins haven't been installed yet
silent! colorscheme molokai

" don't conflict with custom <leader>h mapping
let g:gitgutter_map_keys = 0

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
