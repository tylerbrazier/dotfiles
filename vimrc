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
set laststatus=2
set listchars=tab:>\ ,trail:-,nbsp:+
set mouse=a
set nobackup
set noswapfile
set nrformats-=octal
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
colorscheme pablo

" Normal mode overrides
" '            ` because ' is easier to type but ` behaves better
" q            :quit because I always accidentally start recording
" Y            behaves like capital C and D; plus it's redundant with yy
" P/p          http://vim.wikia.com/wiki/Format_pasted_text_automatically
" j/k          move up and down thru wrapped lines
" backspace    start shell command (quicker to type than :!)
" 2xbackspace  execute previous shell command
" enter        enter vim command (quicker to type than :)
nnoremap ' `
nnoremap q :q
nnoremap Y y$
nnoremap p p=`]
nnoremap P P=`]
nnoremap j gj
nnoremap k gk
nnoremap <bs> :!
nnoremap <bs><bs> :!!<cr>
nnoremap <cr> :
imap <expr> <cr> pumvisible() ? "\<c-y>\<esc>" :
      \ exists('b:loaded_autoclosetag') ? '<Plug>HtmlExpandCR' :
      \ exists('b:delimitMate_enabled') ? '<Plug>delimitMateCR' :
      \ "\<cr>"

" Buffer and window shortcuts; precede each with alt (meta)
" n/p      next/previous buffer
" s/v      split window horizontally/vertically
" h/j/k/l  move to window left/down/up/right
" d        delete buffer
" q        :quit
nnoremap <m-n> :bnext<cr>
nnoremap <m-p> :bprevious<cr>
nnoremap <m-s> :split<cr>
nnoremap <m-v> :vsplit<cr>
nnoremap <m-h> <c-w>h
nnoremap <m-j> <c-w>j
nnoremap <m-k> <c-w>k
nnoremap <m-l> <c-w>l
nnoremap <m-d> :bprevious<cr>:bdelete #<cr>
nnoremap <m-q> :quit<cr>
if has('nvim')
  tnoremap <m-n> <c-\><c-n>:bnext<cr>
  tnoremap <m-p> <c-\><c-n>:bprevious<cr>
  tnoremap <m-s> <c-\><c-n>:split<cr>
  tnoremap <m-v> <c-\><c-n>:vsplit<cr>
  tnoremap <m-h> <c-\><c-n><c-w>h
  tnoremap <m-j> <c-\><c-n><c-w>j
  tnoremap <m-k> <c-\><c-n><c-w>k
  tnoremap <m-l> <c-\><c-n><c-w>l
  tnoremap <m-d> <c-\><c-n>:bprevious<cr>:bdelete #<cr>
  tnoremap <m-q> <c-\><c-n>:quit<cr>
  tnoremap <m-[> <c-\><c-n>
else
  " Allow terminal to recognize escape sequences with alt:
  " http://stackoverflow.com/a/10216459
  " http://vim.wikia.com/wiki/Get_Alt_key_to_work_in_terminal
  set ttimeout ttimeoutlen=50
  for i in range(char2nr('a'), char2nr('z'))
    execute 'set <m-'.nr2char(i).">=\e".nr2char(i)
  endfor
endif

" Shortcuts for common stuff; precede each with <space>
" h   toggle [h]ighlighting
" n   toggle line [n]umbers
" c   toggle [c]omment (or <leader>-/ or ctrl-/ in some terminals)
" f   toggle nerdtree [f]ile explorer
" s   toggle [s]pell check
" m   fix [m]isspelled word
" t   open neovim [t]erminal
" w   [w]rap words at 80 chars
" e   [e]dit ~/.scratch file
" gb  [g]it [b]lame
" gd  [g]it [d]iff on chunk
" gr  [g]it [r]evert chunk
let mapleader = ' '
nnoremap <leader>h :set invhlsearch<cr>
nnoremap <leader>n :set invnumber<cr>
map <leader>c <Plug>NERDCommenterToggle
map <leader>/ <Plug>NERDCommenterToggle
map <c-_>     <Plug>NERDCommenterToggle
nnoremap <leader>f :NERDTreeToggle<cr>
nnoremap <leader>s :setlocal invspell<cr>
nnoremap <leader>m a<c-x>s
nnoremap <leader>t :terminal<cr>
nnoremap <leader>w :setlocal textwidth=80<cr>
nnoremap <leader>e :edit $HOME/.scratch<cr>
nnoremap <leader>gb :Gblame<cr>
nmap     <leader>gd <Plug>GitGutterPreviewHunk<c-w>p
nmap     <leader>gr <Plug>GitGutterRevertHunk


" https://github.com/junegunn/vim-plug
try | execute plug#begin() | catch | finish | endtry
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tylerbrazier/molokai'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'tylerbrazier/vim-collapse'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'ervandew/supertab'
Plug 'pangloss/vim-javascript'
Plug 'tylerbrazier/HTML-AutoCloseTag'
call plug#end()

" silent in case plugins haven't been installed yet
silent! colorscheme molokai

" no 'X lines:' as part of folded text
set foldtext=collapse#foldtext()

" prevent gitgutter default keybindings from conflicting with custom ones
let g:gitgutter_map_keys = 0

" don't complete quotes
let g:delimitMate_quotes = ''
" pressing space in a situation like (|) causes ( | )
let g:delimitMate_expand_space = 1

let g:airline_theme = 'murmur'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
" show only buffers on the tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
