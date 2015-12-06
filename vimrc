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
set updatetime=1000          " millis until CursorHold autocmd
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
  Plugin 'dkprice/vim-easygrep'     " grep for text in project
  Plugin 'Raimondi/delimitMate'     " auto close parens, brackets, etc
  Plugin 'ervandew/supertab'        " tab completion
  Plugin 'pangloss/vim-javascript'  " better indent, syntax, etc for js
  Plugin 'fatih/vim-go'             " excellent go support
  Plugin 'tylerbrazier/HTML-AutoCloseTag'
  call vundle#end()
endif
filetype plugin indent on
syntax on


" Key bindings
" ------------
" All are normal mode mappings unless specified.
" [enter]   mapped to : for quickly entering commands
" [tab]     next buffer
" [s-tab]   previous buffer
" !         execute shell command
" !!        repeat previous shell command
" !!!       execute current file (if executable); useful for scripts
" q         mapped to :q because recording is more annoying than useful
" Y         capital Y behaves like capital C and D (same as y$)
" j         able to move down over wrapped lines (same as gj)
" k         able to move up over wrapped lines (same as gk)
" gb        [g]o [b]ack after gd, gD, etc (same as default ctrl-o)
" ctrl-p    search for [p]roject file
" ctrl-f    [f]ind/grep for text in project; also works on visual selection
" ctrl-d    [d]elete current buffer; deleting the last will quit vim
" ctrl-q    [q]uit vim
" ctrl-w    focus next [w]indow
" ctrl-t    toggle nerd[t]ree
" ctrl-h    toggle showing [h]ighlighted stuff
" ctrl-s    toggle [s]pell check
" ctrl-c    [c]orrect misspelled word under cursor
" ctrl-n    fix i[n]dentation on whole file or visual selection
" ctrl-u    toggle showing line n[u]mbers
" ctrl-l    toggle code fo[l]d
" ctrl-a    emacs-style go to st[a]rt of line
" ctrl-e    emacs-style go to [e]nd of line
" ctrl-x    edit scratch file ~/.scratch
" ctrl-g b  [g]it [b]lame
" ctrl-g d  [g]it [d]iff of hunk at cursor
" ctrl-g r  [g]it [r]evert hunk at cursor
" ctrl-o    toggle c[o]mment on line or visual selection
" ctrl-/    toggle comment; works in some terminals but not gvim :(
"
" If the clipboard is available, ctrl-c/ctrl-x can be used to copy/cut in
" visual mode and ctrl-v/ctrl-z can be used to paste/undo in insert mode.
"
" These keys are not rebound:
" ctrl-r because that's for redo
" ctrl-v because that's for visual block selection
" ctrl-m because pressing [enter] will trigger this (:help key-notation)
" ctrl-i because it's the same as tab
nnoremap <expr> <cr>  &buftype == 'quickfix' ? "\<cr>:cclose\<cr>" : ':'
nnoremap <tab>        :bnext<cr>
nnoremap <s-tab>      :bprevious<cr>
nnoremap !            :!
nnoremap !!!          :!%:p<cr>
nnoremap q            :q
nnoremap Y            y$
nnoremap j            gj
nnoremap k            gk
nnoremap gb           <c-o>
nnoremap <c-f>        :Grep -r -i -F<space>
vnoremap <c-f>        y:Grep -r -i -F<space><c-r>"
nnoremap <expr> <c-d> ':Sayonara'.(&buftype != 'nofile' ? '!' : '')."\<cr>"
nnoremap <c-q>        :qall<cr>
nnoremap <c-w>        <c-w>w
nnoremap <c-t>        :NERDTreeToggle<cr>
nnoremap <c-h>        :set invhlsearch<cr>
nnoremap <c-s>        :set invspell<cr>
nnoremap <c-c>        a<c-x>s
nnoremap <c-n>        mxgg=G`x
vnoremap <c-n>        =
nnoremap <c-u>        :set invnumber<cr>
nnoremap <c-l>        za
nnoremap <c-a>        ^
nnoremap <c-e>        $
nnoremap <c-x>        :edit $HOME/.scratch<cr>
nnoremap <c-g>b       :Gblame<cr>
nmap     <c-g>d       <Plug>GitGutterPreviewHunk<c-w>p
nmap     <c-g>r       <Plug>GitGutterRevertHunk
map      <c-o>        <Plug>NERDCommenterToggle
map      <c-_>        <Plug>NERDCommenterToggle
imap     <expr> <cr>  pumvisible() ? "\<c-y>" :
                    \ exists('b:loaded_autoclosetag') ? '<Plug>HtmlExpandCR' :
                    \ exists('b:delimitMate_enabled') ? '<Plug>delimitMateCR' :
                    \ "\<cr>"
if has('clipboard')
  vnoremap <c-c> "+y
  vnoremap <c-x> "+d
  inoremap <c-v> <c-r>+
  inoremap <c-z> <c-o>u
endif


" Supertab
" --------
" try to use smarter completion after '.', '::', and '->'
let g:SuperTabDefaultCompletionType = 'context'
" preview creates a useless window and causes the screen to blink
set completeopt-=preview


" EasyGrep
" --------
" use external grep command instead of vimgrep (needed for FilesToExclude)
let g:EasyGrepCommand = 1
" grep from project root
let g:EasyGrepRoot = 'search:.git'
" don't grep in these files and dirs
let g:EasyGrepFilesToExclude = '.git,node_modules'
" don't jump to first match right away
let g:EasyGrepJumpToMatch = 0


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
