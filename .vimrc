" ~/.vimrc

set nocompatible             " vim, not vi. should be first in vimrc
set encoding=utf-8           " set the encoding displayed by vim
set expandtab                " spaces instead of tabs
set tabstop=2                " number of spaces to use for tab
set shiftwidth=2             " number of spaces used for indentation
set softtabstop=2            " backspace correctly over tab distance
set list                     " show listchars
set listchars=tab:>-,trail:_ " what to show when :set list is on
set wildmode=longest,list    " bash-like command completion
set numberwidth=3            " number of spaces occupied by line numbers
set backspace=2              " backspace works over indent, eol, and start
set background=dark          " lighter-color text to contrast a dark background
set colorcolumn=80           " show a red line at column
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
set autochdir                " automatically cd to dir of file in current buffer
set showcmd                  " show incomplete commands
set showmode                 " show current mode
set laststatus=2             " always show the statusline
set statusline=%!GetStl()    " set the statusline as defined below
filetype plugin indent on    " detect filetype and automatically indent
syntax on                    " syntax highlighting

" going back into normal mode also saves (if you're editing a file)
inoremap <expr> <esc> empty(expand('%')) ? "\<esc>" : "\<esc>:w<cr>"

" faster way to enter commands
noremap <cr> :

" ! is faster than :! for entering shell commands
noremap ! :!

" q is more annoying than useful
noremap q :q

" make j and k able to move up and down wrapped lines
noremap j gj
noremap k gk

" quit shortcut
noremap <c-q> :q<cr>

" faster buffer movement
noremap <c-n> :bnext<cr>
noremap <c-p> :bprevious<cr>

" emacs-style bindings for beginning and end of line
noremap <c-a> ^
noremap <c-e> $

" faster window movement
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>K
noremap <c-l> <c-w>l

" [d]elete the current buffer
noremap <c-d> :bdelete<cr>

" toggle [s]pell check
noremap <c-s> :set invspell<cr>

" fix misspelled [w]ord
noremap <c-w> ea<c-x>s

" toggle showing line n[u]mbers
noremap <c-u> :set invnumber<cr>

" toggle showing h[i]ghlighted stuff
noremap <c-h> :set invhlsearch<cr>

" toggle using [t]abs or spaces
noremap <c-t> :set invexpandtab<cr>

" line and multiline [c]ommenting
" ctrl-/ triggers <c-_> in some terminals but not in gvim :(
" To uncomment, block select comment chars with c-v then x or d.
noremap <expr> <c-_> Comment()
noremap <expr> <c-c> Comment()

" tab completion
" tab/ctrl-n to move down, shift-tab/ctrl-p to move up
inoremap <expr> <tab> TabComplete()
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<tab>"

" pressing enter selects the highlighted completion option and escapes
inoremap <expr> <cr> pumvisible() ? "\<c-y><esc>" : "\<cr>"

" convert file to uft-8, unix line ending, and convert tabs to spaces
noremap <c-f> :call Fix()<cr>

function! TabComplete()
  let char = getline('.')[col('.')-2]  " get the char behind cursor
  if empty(char) || char =~ '\s'       " if there isn't one or it's white space
    return "\<tab>"                    " tab as usual
  else
    return "\<c-n>"                    " completion
  endif
endfunction

function! Comment()
  let type = &filetype
  if type =~ '\vc(pp)?$' || type =~ '\vjava(script)?$'  " c(pp) or java(script)
    let comment = '//'
  elseif type == 'tex'
    let comment = '%'
  elseif type == 'vim'
    let comment = '"'
  else
    let comment = '#'
  endif
  return substitute(":s!^!com!\|nohlsearch\<cr>", 'com', comment, '')
endfunction

" convert file to uft-8, unix line ending, and convert tabs to spaces
function! Fix()
  let msg = 'Convert file?'
  let choices = "&yes\n&no"
  let default = 1  " yes
  if confirm(msg, choices, default) == 1
    write                " save
    edit ++ff=dos        " reload the file in dos format
    setlocal ff=unix     " set file format
    setlocal fenc=utf-8  " set file encoding
    retab                " convert tabs to spaces
    write                " save
  endif
endfunction

" build the status line; %N* is for UserN highlighting, %0* resets
function! GetStl()
  let stl  = BufferList()                    " show buffer numbers
  let stl .= '%1*%='                         " divide left/right alignment
  let stl .= '%2*%M '                        " modified flag
  let stl .= '%7*%t '                        " file name
  let stl .= '%8*%{&fenc!=""?&fenc." ":""}'  " the file's encoding
  let stl .= '%8*%{&ff} '                    " file format (line ending)
  let stl .= GitBranch()                     " current git branch
  return stl
endfunction

" buffer list for the status line
function! BufferList()
  let cur = bufnr('%')
  let last = bufnr('$')
  let i = 1
  let ret = ''
  while i <= last
    if i == cur
      if (getbufvar(i, "&mod"))  " if current buffer is modified
        let ret .= '%2* '.i.' '  " color it red
      else
        let ret .= '%7* '.i.' '  " otherwise color it cyan
      endif
    elseif buflisted(i)
      if (getbufvar(i, "&mod"))  " if other buffer is modified
        let ret .= '%2* '.i.' '  " color it red
      else
        let ret .= '%9* '.i.' '  " otherwise color it gray
      endif
    endif
    let i += 1
  endwhile
  return ret
endfunction

" get current git branch for statusline
function! GitBranch()
  if has('win32')
    return ''
  else
    let ret = system("git branch 2>/dev/null | grep ^*")
    let ret = substitute(ret, '* ', '(', '')
    let ret = substitute(ret, "\n", ') ', '')
    return '%3*'.ret
  endif
endfunction

" can be used instead of a colorscheme
function! ApplyCustomTheme()
  " boilerplate for applying a theme
  hi clear
  set background=dark
  if exists('syntax_on')
    syntax reset
  endif

  " Main hightlight (hi) groups (from :help group-name):
  " comment      any comment
  " constant     stings, numbers, boolean
  " identifier   variable nams
  " statement    keywords like if, else, for, white, case, try, catch, ...
  " preproc      preprocessors like import, include, ...
  " type         keywords like int, long, char, ...
  " special      special symbols like '\n'
  " underlined   text that stands out, HTML links
  " error        synta errors
  " todo         mostly keywords TODO, FIXME, and XXX
  "
  " Some additional groups that you might want to specfically color:
  " function     function and method names; links to identifier by default
  " string       links to constant by default
  " number       links to constant by default
  " boolean      links to constant by default
  " conditional  if, then, else, switch, ...; links to statement by default
  " repeat       for, do, wle, ...; links to statement by default
  " operator     +, -, *, /, ...; links to statement by default
  " keyword      any otherkeyword; links to statement by default
  " pmenu        completion menu nonselected
  " pmenusel     completion menu selected
  " userN        where N is 1..9; usedin statusline (:h hl-User1..9)
  "
  " There are more groups; ':help group-name' for more info.

  " Colors: black, red, green, yellow, blue, magenta, cyan, white, gray
  " There are others but these work in all 8 color terminals.

  hi normal                                      guibg=black   guifg=white
  hi comment                     ctermfg=grey                  guifg=grey
  hi constant                    ctermfg=blue                  guifg=blue
  hi special                     ctermfg=cyan                  guifg=cyan
  hi pmenu       ctermbg=black   ctermfg=gray    guibg=black   guifg=gray
  hi pmenusel    ctermbg=black   ctermfg=cyan    guibg=black   guifg=cyan
  hi user1       ctermbg=black   ctermfg=black   guibg=black   guifg=black
  hi user2       ctermbg=black   ctermfg=red     guibg=black   guifg=red
  hi user3       ctermbg=black   ctermfg=green   guibg=black   guifg=green
  hi user4       ctermbg=black   ctermfg=yellow  guibg=black   guifg=yellow
  hi user5       ctermbg=black   ctermfg=blue    guibg=black   guifg=blue
  hi user6       ctermbg=black   ctermfg=magenta guibg=black   guifg=magenta
  hi user7       ctermbg=black   ctermfg=cyan    guibg=black   guifg=cyan
  hi user8       ctermbg=black   ctermfg=white   guibg=black   guifg=white
  hi user9       ctermbg=black   ctermfg=gray    guibg=black   guifg=gray
endfunction

call ApplyCustomTheme()

" Colorschemes included with vim - will override custom theme
"colorscheme default
"colorscheme blue
"colorscheme darkblue
"colorscheme delek
"colorscheme desert
"colorscheme elflord
"colorscheme evening
"colorscheme koehler
"colorscheme morning
"colorscheme murphy
"colorscheme pablo
"colorscheme peachpuff
"colorscheme ron
"colorscheme shine
"colorscheme slate
"colorscheme torte
"colorscheme zellner
