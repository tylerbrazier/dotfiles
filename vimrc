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


" Autocommands
" ------------
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


" Vundle plugin stuff
" -------------------
" :PluginList       - lists configured plugins
" :PluginInstall    - append `!` to update or just :PluginUpdate
" :PluginSearch foo - append `!` to refresh local cache
" :PluginClean      - remove unused plugins; append `!` to auto-approve removal
" :help vundle      - or check the wiki
if isdirectory(expand('~/.vim/bundle/Vundle.vim'))
  set runtimepath+=~/.vim/bundle/Vundle.vim
  filetype off                      " required by vundle
  call vundle#begin()               " define all plugins after this
  Plugin 'VundleVim/Vundle.vim'     " let Vundle manage Vundle, required
  Plugin 'bling/vim-airline'        " statusline
  Plugin 'tomasr/molokai'           " colorscheme
  Plugin 'tpope/vim-fugitive'       " git integration
  Plugin 'airblade/vim-gitgutter'   " show git modifications at the left
  Plugin 'scrooloose/nerdtree'      " project file explorer
  Plugin 'scrooloose/nerdcommenter' " for commenting lines of code
  Plugin 'mhinz/vim-sayonara'       " better buffer closing
  Plugin 'ctrlpvim/ctrlp.vim'       " fuzzy search for files, buffers, etc
  Plugin 'Raimondi/delimitMate'     " auto close parens, brackets, etc
  Plugin 'ervandew/supertab'        " tab completion
  Plugin 'pangloss/vim-javascript'  " better indent, syntax, etc for js
  Plugin 'fatih/vim-go'             " excellent go support
  Plugin 'tylerbrazier/HTML-AutoCloseTag'
  call vundle#end()
endif
filetype plugin indent on
syntax on


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


" Supertab
" --------
" try to use smarter completion after '.', '::', and '->'
let g:SuperTabDefaultCompletionType = 'context'
" preview creates a useless window and causes the screen to blink
set completeopt-=preview


" Gitgutter
" ---------
" we're using custom gitgutter mappings so prevent conflicts with the defaults
let g:gitgutter_map_keys = 0


" DelimitMate
" -----------
" don't complete quotes
let g:delimitMate_quotes = ''
" pressing space in a situation like (|) causes ( | )
let g:delimitMate_expand_space = 1


" Airline
" -------
" t_Co is needed for colors to show up right; it should come before colorscheme
set t_Co=256
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


" Colorscheme
" -----------
" fallback colorscheme
colorscheme slate
" silent to suppress errors in case plugins aren't loaded
silent! colorscheme molokai
" :help group-name for other highlight groups
" See 256 colors at https://en.wikipedia.org/wiki/File:Xterm_256color_chart.svg
" background NONE so we can see thru the transparent term window
hi Normal ctermbg=NONE ctermfg=255
" make comments not so hard to see (due to transparent bg)
hi Comment ctermfg=244
" same with delimiter
hi Delimiter ctermfg=172
" and visual selection
hi Visual ctermbg=236
" by default, strings look bad
hi String ctermfg=33 guifg=#0087ff
" same with label (json key)
hi Label ctermfg=220 guifg=#ffdf00
" better looking links
hi Underlined ctermfg=48 guifg=#00ff87
" and errors
hi Error ctermbg=88 ctermfg=255 guibg=#780000 guifg=#eeeeee
" and highlighting
hi Search ctermbg=51 guibg=#00ffff
" easier to read git diff
hi DiffAdd    ctermbg=236 ctermfg=10   guibg=#303030 guifg=#00ff00
hi DiffDelete ctermbg=236 ctermfg=172  guibg=#303030 guifg=#d78700
hi DiffChange ctermbg=236 ctermfg=63   guibg=#303030 guifg=#5f5fff
hi DiffText   ctermbg=236 ctermfg=39   guibg=#303030 guifg=#00afff
" and *.diff files
hi link diffAdded DiffAdd
hi link diffRemoved DiffDelete
hi link diffChanged DiffChange
