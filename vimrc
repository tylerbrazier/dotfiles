set nocompatible             " vim, not vi. should be first in vimrc
set encoding=utf-8           " set the encoding displayed by vim
set wildmode=longest,list    " bash-like command completion
set numberwidth=3            " number of spaces occupied by line numbers
set backspace=2              " backspace works over indent, eol, and start
set mouse=a                  " enable mouse in all modes
set nobackup                 " don't make example.txt~ files
set noswapfile               " swap files are annoying
set hidden                   " can switch buffers w/out save
set notimeout                " combine with ttimeout to disable map timeouts
set ttimeout                 " combine with notimeout to disable map timeouts
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
set updatetime=200           " millis until CursorHold; used for autosave
set listchars=tab:»·,trail:· " what to show when :set list is on
set nolist                   " list off by default (airline warns of bad spaces)
set colorcolumn=80           " show a line at column
set expandtab                " spaces instead of tabs
set ts=2 sts=2 sw=2          " number of spaces to use for tab/indent
set guifont=Monospace\ 10    " gvim font
set foldmethod=indent        " fold indented lines
set foldlevelstart=99        " initially open all folds


" Autocommands
" ------------
" reset autocmds so sourcing vimrc again doesn't run them twice
autocmd!
" autosave; write (if changed) every updatetime millis if editing a file
autocmd CursorHold ?\+ if &modifiable | update | endif
" don't split the window when looking at help pages
autocmd FileType help only
" git commits should be <= 72 chars wide; http://git-scm.com/book/ch5-2.html
autocmd BufRead COMMIT_EDITMSG setlocal colorcolumn=72


" Vundle plugin stuff
" -------------------
" :PluginList       - lists configured plugins
" :PluginInstall    - append `!` to update or just :PluginUpdate
" :PluginSearch foo - append `!` to refresh local cache
" :PluginClean      - remove unused plugins; append `!` to auto-approve removal
" :help vundle      - or check the wiki
set runtimepath+=~/.vim/bundle/Vundle.vim
filetype off                      " required by vundle
call vundle#begin()               " define all plugins after this
Plugin 'VundleVim/Vundle.vim'     " let Vundle manage Vundle, required
Plugin 'bling/vim-airline'        " statusline
Plugin 'tomasir/molokai'          " colorscheme
Plugin 'tpope/vim-fugitive'       " git integration; need for branch on airline
Plugin 'airblade/vim-gitgutter'   " show git modifications at the left
Plugin 'scrooloose/nerdtree'      " project file explorer
Plugin 'scrooloose/nerdcommenter' " for commenting lines of code
Plugin 'pangloss/vim-javascript'  " better indent, syntax, etc for js
Plugin 'Raimondi/delimitMate'     " auto complete quotes, parens, brackets, etc
Plugin 'ervandew/supertab'        " tab to complete words
Plugin 'tylerbrazier/HTML-AutoCloseTag'
call vundle#end()                 " define all plugins before this
filetype plugin indent on         " required by vundle
syntax on                         " syntax highlighting


" Normal mode key bindings
" ------------------------
" [enter]   :     (faster way to enter vim commands)
" !         :!    (faster way to enter shell commands)
" !!        :!!   (repeat previous shell command)
" !!!       :!%:p (execute current file (if executable); useful for scripts)
" q         :q    (recording is more annoying than useful)
" Y         y$    (capital Y behaves like capital C and D)
" j         gj    (able to move down over wrapped lines)
" k         gk    (able to move up over wrapped lines)
" ctrl-n    [n]ext buffer
" ctrl-p    [p]revious buffer
" ctrl-d    [d]elete current buffer
" ctrl-q    [q]uit all buffers
" ctrl-w    focus next [w]indow
" ctrl-t    toggle NERD[T]ree
" ctrl-h    toggle showing [h]ighlighted stuff
" ctrl-s    toggle [s]pell check
" ctrl-f    [f]ix misspelled word under cursor
" ctrl-i    fix [i]ndentation on whole file or visual selection
" ctrl-u    toggle showing line n[u]mbers
" ctrl-l    toggle code fo[l]d
" ctrl-a    emacs-style go to st[a]rt of line
" ctrl-e    emacs-style go to [e]nd of line
" ctrl-x    edit scratch file ~/.scratch
" ctrl-g d  [g]it [d]iff of hunk at cursor
" ctrl-g r  [g]it [r]evert hunk at cursor
" ctrl-/    (or ctrl-o) toggle c[o]mment on line or visual selection
" Note: ctrl-/ works on some terminals but on in gvim :(
" If it doesn't work, just use ctrl-o instead.
"
" Don't rebind these keys:
" c-r because that's for redo
" c-v because that's for visual block selection
" c-m because pressing enter will trigger this (:help key-notation)
nnoremap <cr> :
nnoremap ! :!
nnoremap !!! :!%:p<cr>
nnoremap q :q
nnoremap Y y$
nnoremap j gj
nnoremap k gk
nnoremap <c-n> :bnext<cr>
nnoremap <c-p> :bprevious<cr>
nnoremap <c-d> :bdelete<cr>
nnoremap <c-q> :qall<cr>
nnoremap <c-w> <c-w>w
nnoremap <c-t> :NERDTreeToggle<cr>
nnoremap <c-h> :set invhlsearch<cr>
nnoremap <c-s> :set invspell<cr>
nnoremap <c-f> ea<c-x>s
nnoremap <c-i> mxgg=G'x
vnoremap <c-i> =
nnoremap <c-u> :set invnumber<cr>
nnoremap <c-l> za
nnoremap <c-a> ^
nnoremap <c-e> $
nnoremap <c-x> :edit $HOME/.scratch<cr>
nmap <c-g>d <Plug>GitGutterPreviewHunk
nmap <c-g>r <Plug>GitGutterRevertHunk
map <c-o> <Plug>NERDCommenterToggle
map <c-_> <Plug>NERDCommenterToggle


" Insert/visual mode key bindings
" -------------------------------
" ctrl-c    (visual) copy to system clipboard
" ctrl-x    (visual) cut into system clipboard
" ctrl-v    (insert) paste from system clipboard
" ctrl-z    (insert) undo
" [enter]   (insert) expand parens, brackets, and html tags if between them
"
" Note: The * register is used to access the system clipboard in X11 when using
" X's select-to-copy and middle click to paste.
" The + register is used to access the clipboard of graphical environments like
" gnome and kde when doing copy and paste with ctrl-c and ctrl-v and such.
" The * register can also be used to access the clipboard on windows os.
" When clipboard=unnamed, vim will use the * register when yanking, deleting,
" putting, etc. When clipboard=unnamedplus, vim uses the + register instead.
if has('clipboard')
  vnoremap <c-c> "+y
  vnoremap <c-x> "+d
  inoremap <c-v> <c-r>+
  inoremap <c-z> <c-o>u
endif
imap <expr> <cr> pumvisible() ? "\<c-y>" :
      \ exists('b:loaded_autoclosetag') ? "<Plug>HtmlExpandCR" :
      \ "<Plug>delimitMateCR"


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
colorscheme molokai
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
" easier to read git diff
hi DiffAdd    ctermbg=236 ctermfg=10   guibg=#303030 guifg=#00ff00
hi DiffDelete ctermbg=236 ctermfg=172  guibg=#303030 guifg=#d78700
hi DiffChange ctermbg=236 ctermfg=63   guibg=#303030 guifg=#5f5fff
hi DiffText   ctermbg=236 ctermfg=39   guibg=#303030 guifg=#00afff
" and *.diff files
hi link diffAdded DiffAdd
hi link diffRemoved DiffDelete
hi link diffChanged DiffChange
