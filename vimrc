set nocompatible             " vim, not vi. should be first in vimrc
set encoding=utf-8           " set the encoding displayed by vim
set wildmode=longest,list    " bash-like command completion
set numberwidth=3            " number of spaces occupied by line numbers
set backspace=2              " backspace works over indent, eol, and start
set mouse=a                  " enable mouse in all modes
set nobackup                 " don't make example.txt~ files
set noswapfile               " swap files are annoying
set hidden                   " can switch buffers w/out save
set ttimeout ttimeoutlen=50  " distinguish escape sequences like esc x and alt-x
set incsearch                " start highlighting when searching
set hlsearch                 " highlight previously searched words
set ignorecase               " searches are case insensitive
set smartcase                " unless the search contains a capital letter
set wildignorecase           " case insensitive file name completion
set autoread                 " reload file when external changes are made
set autowrite                " write when doing some commands, including :!
set autochdir                " auto cd to dir of file in current buffer
set showcmd                  " show incomplete commands
set showmode                 " show current mode
set laststatus=2             " always show the statusline
set updatetime=1000          " millis until CursorHold autocmd
set listchars=tab:»·,trail:· " what to show when :set list is on
set nolist                   " list off by default (airline warns of bad spaces)
set colorcolumn=80           " show a line at column
set expandtab                " spaces instead of tabs
set ts=2 sts=2 sw=2          " number of spaces to use for tab/indent
set guifont=Monospace\ 10    " gvim font
set foldmethod=indent        " fold indented lines
set foldlevelstart=99        " initially open all folds
set clipboard=unnamedplus    " yank, delete, put, etc use system clipboard
set completeopt-=preview     " preview window is more annoying than useful
set formatoptions+=j         " remove comment chars when joining commented lines

" reset autocmds so sourcing vimrc again doesn't run them twice
autocmd!
" autosave in normal mode every updatetime (1s) if able
autocmd CursorHold ?\+ if &modifiable && !&readonly | update | endif
" don't split the window when looking at help pages
autocmd FileType help only
" git commits should be <= 72 chars wide; http://git-scm.com/book/ch5-2.html
autocmd FileType gitcommit setlocal colorcolumn=72 spell
" auto wrap words when writing markdown docs
autocmd FileType markdown setlocal textwidth=80 spell

filetype plugin indent on
syntax on
colorscheme pablo

" Sensible overrides
" q            :quit because I always accidentally start recording
" Y            behaves like capital C and D; plus it's redundant with yy
" j/k          move up and down thru wrapped lines
" gb           [g]o [b]ack (ctrl-o) after gd, gf, etc
" backspace    start shell command (quicker to type than :!)
" 2xbackspace  execute previous shell command
" enter        enter vim command (quicker to type than :)
nnoremap q :q
nnoremap Y y$
nnoremap j gj
nnoremap k gk
nnoremap gb <c-o>
nnoremap <bs>     :!
nnoremap <bs><bs> :!!<cr>
nnoremap <cr> :
imap <expr> <cr> pumvisible() ? "\<c-y>" :
               \ exists('b:loaded_autoclosetag') ? '<Plug>HtmlExpandCR' :
               \ exists('b:delimitMate_enabled') ? '<Plug>delimitMateCR' :
               \ "\<cr>"

" Buffer and window shortcuts; precede each with alt (meta)
" d        delete buffer
" n/p      next/previous buffer
" h/j/k/l  move to window left/down/up/right
nnoremap <expr> <m-d> ':Sayonara'.(&bt != 'nofile' ? '!' : '')."\<cr>"
inoremap <expr> <m-d> "\<esc>:Sayonara".(&bt != 'nofile' ? '!' : '')."\<cr>"
nnoremap <m-n> :bnext<cr>
inoremap <m-n> <esc>:bnext<cr>
nnoremap <m-p> :bprevious<cr>
inoremap <m-p> <esc>:bprevious<cr>
nnoremap <m-h> <c-w>h
inoremap <m-h> <esc><c-w>h
nnoremap <m-j> <c-w>j
inoremap <m-j> <esc><c-w>j
nnoremap <m-k> <c-w>k
inoremap <m-k> <esc><c-w>k
nnoremap <m-l> <c-w>l
inoremap <m-l> <esc><c-w>l
" Allow terminal to recognize escape sequences with alt:
" http://stackoverflow.com/a/10216459
" http://vim.wikia.com/wiki/Get_Alt_key_to_work_in_terminal
for i in range(char2nr('a'), char2nr('z'))
  execute 'set <m-'.nr2char(i).">=\e".nr2char(i)
endfor

" Shortcuts for common stuff; precede each with <space>
" h   toggle [h]ighlighting
" n   toggle line [n]umbers
" f   toggle [f]old
" c   toggle [c]omment (or <leader>-/ or ctrl-/ in some terminals)
" t   toggle nerd[t]ree file explorer
" s   toggle [s]pell check
" w   fix misspelled [w]ord
" e   [e]dit ~/.scratch file
" gb  [g]it [b]lame
" gd  [g]it [d]iff on chunk
" gr  [g]it [r]evert chunk
let mapleader = ' '
nnoremap <leader>h :set invhlsearch<cr>
nnoremap <leader>n :set invnumber<cr>
nnoremap <leader>f za
map <leader>c <Plug>NERDCommenterToggle
map <leader>/ <Plug>NERDCommenterToggle
map <c-_>     <Plug>NERDCommenterToggle
nnoremap <leader>t :NERDTreeToggle<cr>
nnoremap <leader>s :set invspell<cr>
nnoremap <leader>w a<c-x>s
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
Plug 'mhinz/vim-sayonara'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'ervandew/supertab'
Plug 'pangloss/vim-javascript'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'fatih/vim-go'
Plug 'tylerbrazier/HTML-AutoCloseTag'
call plug#end()

" silent in case plugins haven't been installed yet
silent! colorscheme molokai

" no 'X lines:' as part of folded text
set foldtext=collapse#foldtext()

" try to use smarter completion after '.', '::', and '->'
let g:SuperTabDefaultCompletionType = 'context'

" we're using custom gitgutter mappings so prevent conflicts with the defaults
let g:gitgutter_map_keys = 0

" don't complete quotes
let g:delimitMate_quotes = ''
" pressing space in a situation like (|) causes ( | )
let g:delimitMate_expand_space = 1

let g:airline_theme = 'murmur'
" no unicode chars since they're hard to make look right in all terminals
let g:airline_left_sep = ''
let g:airline_right_sep = ''
" tabline at the top
let g:airline#extensions#tabline#enabled = 1
" don't show 'buffer' at right since we only use buffers, not tabs
let g:airline#extensions#tabline#show_tab_type = 0
" just show the the file name unless two of them differ
let g:airline#extensions#tabline#formatter = 'unique_tail'
" no unicode chars since they're hard to make look right in all terminals
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
