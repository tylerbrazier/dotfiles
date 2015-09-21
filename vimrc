" Normal mode key binding reference
" ---------------------------------
" [enter]   :     (faster way to enter vim commands)
" !         :!    (faster way to enter shell commands)
" !!        :!!   (repeat previous shell command)
" !!!       :!%:p (execute current file (if executable); useful for scripts)
" q         :q    (recording is more annoying than useful)
" j         gj    (able to move down over wrapped lines)
" k         gk    (able to move up over wrapped lines)
" Y         y$    (capital Y behaves like capital C and D)
" ctrl-n    [n]ext buffer
" ctrl-p    [p]revious buffer
" ctrl-d    [d]elete current buffer
" ctrl-q    [q]uit all buffers
" ctrl-w    toggle [w]rap
" ctrl-t    toggle using [t]abs or spaces for tab key
" ctrl-h    toggle showing [h]ighlighted stuff
" ctrl-s    toggle [s]pell check
" ctrl-f    [f]ix misspelled word under cursor
" ctrl-c    toggle tab & auto [c]ompletion (see Completion note below)
" ctrl-i    fix [i]ndentation on whole file or visual selection
" ctrl-u    toggle showing line n[u]mbers
" ctrl-l    toggle code fo[l]d
" ctrl-a    emacs-style go to st[a]rt of line
" ctrl-e    emacs-style go to [e]nd of line
" ctrl-x    edit scratch file ~/.scratch
" ctrl-g d  [g]it [d]iff of hunk at cursor
" ctrl-g r  [g]it [r]evert hunk at cursor
" ctrl-/    (or ctrl-o) toggle c[o]mment on line or visual selection
"
" Note: ctrl-/ for toggle comment works on some terminals but on in gvim :(
" If it doesn't work, just use ctrl-o instead.

" Insert/visual mode key binding reference
" ---------------------------------
" ctrl-c    (visual) copy to system clipboard
" ctrl-x    (visual) cut into system clipboard
" ctrl-v    (insert) paste from system clipboard
" ctrl-z    (insert) undo

" Completion
" ----------
" If completion is enabled (toggle with ctrl-c), pressing some keys in insert
" mode can auto complete common sequences.
" >           if editing xml/html, complete end tag and move between them
" (,{,[       complete closing bracket and move the cursor between them
" ),},]       step over closing bracket if it's to the right of the cursor
" [backspace] if between two matching brackets, delete them both
" [enter]     if between two matching brackets or tags, open them below
" [tab]       do word completion if cursor follows a nonwhitespace character
"
" When word completion menu is up, use [tab] or ctrl-n to move to the next
" suggestion, shift-tab or ctrl-p for previous suggestion, [enter] to select.
"
" NOTE: most of these completion mappings will interrupt the undo/redo/repeat
" sequence since they move the cursor in insert mode or include an [esc] in
" the mapping.
" See http://vim.wikia.com/wiki/Automatically_append_closing_characters
" If you need to repeat a sequence (using .) that includes typing an auto
" complete character, just disable completion beforehand.


" Plugin stuff
" ============
set nocompatible  " vim, not vi. should be first in vimrc
filetype off      " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" statusline
Plugin 'bling/vim-airline'

" git integration (needed for showing branch on airline)
Plugin 'tpope/vim-fugitive'

" shows git modifications on each line at the left
Plugin 'airblade/vim-gitgutter'

" colorscheme
Plugin 'tomasir/molokai'

" for commenting lines of code
Plugin 'scrooloose/nerdcommenter'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - append `!` to update or just :PluginUpdate
" :PluginSearch foo - append `!` to refresh local cache
" :PluginClean      - remove unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ


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
set foldmethod=indent        " fold indented text
set foldlevelstart=99        " initially open all folds
set laststatus=2             " always show the statusline
set updatetime=200           " millis until cursorhold; used for autosave
set list                     " show listchars
set listchars=tab:»·,trail:· " what to show when :set list is on
set colorcolumn=80           " show a line at column
set expandtab                " spaces instead of tabs
set ts=2 sts=2 sw=2          " number of spaces to use for tab/indent
set guifont=Monospace\ 10

let g:enableComplete = 1     " [true] auto complete brackets and html/xml tags

" reset autocmds so that sourcing vimrc again doesn't run autocmds twice
autocmd!

" syntax highlighting
syntax on

" autosave; write (if changed) every updatetime millis if editing a file
autocmd cursorhold ?\+ if &modifiable | update | endif

" don't split the window when looking at help pages
autocmd bufenter *.txt if &filetype == 'help' | only | endif

" go uses tabs and vim already highlights bad whitespace for go files
autocmd bufread *.go set noexpandtab nolist

" *.md are markdown files
autocmd bufenter *.md set filetype=markdown syntax=markdown

" git commits should be <= 72 chars wide; http://git-scm.com/book/ch5-2.html
autocmd bufread COMMIT_EDITMSG set colorcolumn=72

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
nnoremap <c-w> :set invwrap<cr>
nnoremap <c-t> :set invexpandtab<cr>
nnoremap <c-h> :set invhlsearch<cr>
nnoremap <c-s> :set invspell<cr>
nnoremap <c-f> ea<c-x>s
nnoremap <c-c> :call ToggleComplete()<cr>
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
" ctrl-/ triggers <c-_> in some terminals (not in gvim)

" Note about clipboards: The * register is used to access the system clipboard
" in X11 when using X's select-to-copy and middle click to paste.
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

inoremap <expr> <tab> Complete("\<tab>")
inoremap <expr> <s-tab> Complete("\<s-tab>")
inoremap <expr> <cr> Complete("\<cr>")
inoremap <expr> <bs> Complete("\<bs>")
inoremap <expr> ( Complete('(')
inoremap <expr> { Complete('{')
inoremap <expr> [ Complete('[')
inoremap <expr> ) Complete(')')
inoremap <expr> } Complete('}')
inoremap <expr> ] Complete(']')
inoremap <expr> > Complete('>')

" NOTE: don't rebind these keys:
" c-r because that's for redo
" c-v because that's for visual block selection
" c-m because pressing enter will trigger this (:help key-notation)


function! ToggleComplete()
  if g:enableComplete
    let g:enableComplete = 0
    echo 'Completion is off'
  else
    let g:enableComplete = 1
    echo 'Completion is on'
  endif
endfunction

function! Complete(c)
  if !g:enableComplete
    return a:c
  endif

  let l = getline('.')[col('.')-2]  " char to left of the cursor
  let r = getline('.')[col('.')-1]  " char to right of the cursor
  let isMarkup = (&filetype == 'html' || &filetype == 'xml') ? 1 : 0

  " enter can open below if between brackets or tags
  if a:c == "\<cr>"
    if (l=='(' && r==')') || (l=='{' && r=='}') || (l=='[' && r==']')
          \ || (isMarkup && l == '>' && r == '<')
      " open below tags or brackets
      return "\<cr>\<esc>O"
    elseif pumvisible()
      " select current entry in tab completion menu
      return "\<c-y>"
    else
      return a:c
    endif
  endif

  " backspace can delete matching brackets if you're between them
  if a:c == "\<bs>"
    if (l=='(' && r==')') || (l=='{' && r=='}') || (l=='[' && r==']')
      return "\<right>\<bs>\<bs>"  " delete them both
    else
      return "\<bs>"
    endif
  endif

  " tab to do word completion
  if a:c == "\<tab>"
    if empty(l) || l =~ '\s' " if char to the left is empty or it's white space
      return "\<tab>"        " tab as usual
    else
      return "\<c-n>"        " otherwise do word completion
    endif
  endif

  " shift-tab can move up on the completion menu
  if a:c == "\<s-tab>"
    return pumvisible() ? "\<c-p>" : "\<tab>"
  endif

  " complete matching brackets
  if a:c == '('
    return "()\<left>"
  elseif a:c == '{'
    return "{}\<left>"
  elseif a:c == '['
    return "[]\<left>"
  endif

  " step over closing brackets
  if a:c == ')' || a:c == '}' || a:c == ']'
    return r == a:c ? "\<right>" : a:c
  endif

  " complete html tag
  if a:c == '>' && isMarkup
    if getline('.')[col('.')-3] == '-'  " if char to left of > is -
      return a:c                        " don't complete on comment -->
    endif
    " void elements; these should not have an end tag
    " http://www.w3.org/TR/html5/syntax.html#void-elements
    let ve = ['area', 'base', 'br', 'col', 'embed', 'hr', 'img', 'input',
          \ 'keygen', 'link', 'meta', 'param', 'source', 'track', 'wbr']
    " GetLastOpenTag is conveniently defined in xmlcomplete.vim
    let b:empty = ""
    let e = xmlcomplete#GetLastOpenTag("b:empty")
    if index(ve, e) != -1  " if last open tag is a void element
      return a:c           " don't complete end tag
    else
      return "></\<c-x>\<c-o>\<esc>F<i"  " complete end tag and go between them
    endif
  endif

  " otherwise just return the typed char
  return a:c
endfunction


" Airline conf
" ============
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
" ===========
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

" by default, strings look the color of chewed gum
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
