" ~/.vimrc

set nocompatible             " vim, not vi. should be first in vimrc
set encoding=utf-8           " set the encoding displayed by vim
set expandtab                " spaces instead of tabs
set tabstop=2                " number of spaces to use for tab
set shiftwidth=2             " number of spaces used for indentation
set softtabstop=2            " backspace correctly over tab distance
set listchars=tab:>-,trail:_ " what to show when :set list is on
set wildmode=longest,list    " bash-like command completion
set numberwidth=3            " number of spaces occupied by line numbers
set backspace=2              " backspace works over indent, eol, and start
set mouse=n                  " enable mouse in normal mode
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
set foldmethod=expr          " use a custom foldmethod
set foldexpr=GetFold(v:lnum) " defined below
set foldlevelstart=99        " initially open all folds
set foldtext=GetFoldText()   " the text to show on folded lines
set fillchars=fold:-         " trailing chars to be used on folded lines
set laststatus=2             " always show the statusline
set statusline=%!GetStl()    " set the statusline as defined below
set clipboard=unnamedplus    " use the X11 system clipboard
" Note about clipboards: the * register is used to access the system clipboard
" in X11 when using X's select-to-copy and middle click to paste.
" The + register is used to access the clipboard of graphical environments like
" gnome and kde when doing copy and paste with c-c and c-v and such.
" When clipboard=unnamed, vim will use the * register when yanking, deleting,
" putting, etc. When clipboard=unnamedplus, vim uses the + register instead.

if &modifiable
  set list                   " show listchars
  set colorcolumn=80         " show a line at column
endif

" reset autocmds so that sourcing vimrc again doesn't run autocmds twice
autocmd!

filetype plugin indent on    " detect filetype and automatically indent
syntax on                    " syntax highlighting

" set git branch for statusline on buffer read
let g:git_branch = ''
autocmd bufread * call SetGitBranch()

" set syntax highlighting for *.md files
autocmd bufread *.md set syntax=markdown

" write (if changed) every updatetime millis if editing a modifiable file
set updatetime=500
autocmd cursorhold ?\+ if &modifiable | update | endif

" faster way to enter commands
noremap <cr> :

" ! is faster than :! for entering shell commands (!! to repeat prev command)
noremap ! :!

" triple bang to execute current file (it must be executable)
noremap !!! :!%:p<cr>

" q is more annoying than useful
noremap q :q

" capital Y should behave like capital C and D
noremap Y y$

" make j and k able to move up and down wrapped lines
noremap j gj
noremap k gk

" [n]ext and [p]revious buffer
noremap <c-n> :bnext<cr>
noremap <c-p> :bprevious<cr>

" [d]elete the current buffer
noremap <c-d> :bdelete<cr>

" [q]uit
noremap <c-q> :quit<cr>

" move to next [w]indow
noremap <c-w> <c-w>w

" toggle using [t]abs or spaces
noremap <c-t> :set invexpandtab<cr>

" toggle showing [h]ighlighted stuff
noremap <c-h> :set invhlsearch<cr>

" toggle [s]pell check
noremap <c-s> :set invspell<cr>

" [f]ix misspelled word under cursor
noremap <c-f> ea<c-x>s

" [c]onvert file to uft-8, unix line ending, tabs to spaces, trim trailing ws
noremap <c-c> :call ConvertFile()<cr>

" toggle showing line n[u]mbers
noremap <c-u> :set invnumber<cr>

" line and multiline c[o]mmenting
" ctrl-/ triggers <c-_> in some terminals but not in gvim :(
noremap <expr> <c-_> ToggleComment()
noremap <expr> <c-o> ToggleComment()

" toggle fo[l]d
noremap <c-l> za

" emacs-style bindings for st[a]rt and [e]nd of line
noremap <c-a> ^
noremap <c-e> $

" standard copy and cut using c-c and c-x in visual mode
vnoremap <c-c> y
vnoremap <c-x> d
" standard paste and undo using c-v and c-z in insert mode
inoremap <expr> <c-v> has('clipboard') ? "\<c-r>+" : "\<c-r>\""
inoremap <c-z> <c-o>u

" tab completion
" tab/ctrl-n to move down, shift-tab/ctrl-p to move up
inoremap <expr> <tab> TabComplete()
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<tab>"
" pressing enter selects the highlighted completion option
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<cr>"

" edit a scratch file
noremap <c-x> :edit /tmp/scratch<cr>

" Don't rebind these keys:
" c-r because that's for redo
" c-v because that's for visual block selection
" c-m because pressing enter will trigger this (:help key-notation)


function! TabComplete()
  let char = getline('.')[col('.')-2]  " get the char behind cursor
  if empty(char) || char =~ '\s'       " if there isn't one or it's white space
    return "\<tab>"                    " tab as usual
  else
    return "\<c-n>"                    " otherwise do completion
  endif
endfunction

function! IsCommented(comment)
  let v = line("v")
  let cur = line(".")
  let i = v < cur ? v : cur
  let end = v < cur ? cur : v
  while i <= end
    let line = getline(i)
    if line !~ '^\s*'.a:comment  " if line doesn't start with comment char
      return 0                   " return false
    endif
    let i+=1
  endwhile
  return 1                       " return true
endfunction

function! ToggleComment()
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
  if IsCommented(comment)
    return substitute(":normal ^lenx\<cr>", 'len', len(comment), '')
  else
    return substitute(":normal Icom\<cr>", 'com', comment, '')
  endif
endfunction

" convert file to uft-8, unix line ending, tabs to spaces, trim trailing ws
function! ConvertFile()
  let msg = "Convert file?\n
        \This will set encoding to utf8, convert cr/lf to lf,
        \ convert tabs to spaces, and trim all trailing whitespace."
  let choices = "&yes\n&no"
  let default = 2  " 1=yes, 2=no
  if confirm(msg, choices, default) == 1
    write                " save
    edit ++ff=dos        " reload the file in dos format
    setlocal ff=unix     " set file format
    setlocal fenc=utf-8  " set file encoding
    set expandtab        " make sure we're using expandtab
    retab                " convert tabs to spaces
    %s/\s\+$//e          " trim trailing ws (e means don't fail if not found)
    write                " save
  endif
endfunction

" build the status line; %N* is for UserN highlighting, %0* resets
function! GetStl()
  let stl  = BufferList()                    " show buffer numbers
  let stl .= '%1*%='                         " divide left/right alignment
  let stl .= '%2*%M '                        " modified flag
  "let stl .= '%7*%t '                       " file name
  let stl .= '%8*%{&fenc!=""?&fenc." ":""}'  " the file's encoding
  let stl .= '%8*%{&ff} '                    " file format (line ending)
  let stl .= '%3*%{g:git_branch}'            " current git branch
  return stl
endfunction

" buffer list for the status line
function! BufferList()
  let cur = bufnr('%')
  let last = bufnr('$')
  let i = 1
  let ret = ''
  while i <= last
    let name = fnamemodify(bufname(i), ':t')  " basename of file in buffer i
    if i == cur
      if (getbufvar(i, "&mod"))     " if current buffer is modified
        let ret .= '%2* '.name.' '  " color it red
      else
        let ret .= '%7* '.name.' '  " otherwise color it cyan
      endif
    elseif buflisted(i)
      if (getbufvar(i, "&mod"))     " if other buffer is modified
        let ret .= '%2* '.name.' '  " color it red
      else
        let ret .= '%9* '.name.' '  " otherwise color it gray
      endif
    endif
    let i += 1
  endwhile
  return ret
endfunction

" set current git branch for statusline
function! SetGitBranch()
  let b = system('git branch 2>/dev/null | grep ^*')
  let b = substitute(b, '* ', '(', '')
  let b = substitute(b, "\n", ') ', '')
  let g:git_branch = b
endfunction

" Vim's indent foldmethod doesn't do exactly what I'd like it to do.
" The next three functions are used to define a better foldmethod.
" Toggling fold on a line will fold everthing below it with greater indent.
" It stops folding before it reaches a line with indent equal to or less
" than the current line or before whitespace (empty) line(s) preceding a
" line with equal or less indent.
" The functions were taken verbatim from this awesome site:
" http://learnvimscriptthehardway.stevelosh.com/chapters/49.html
function! GetFold(lnum)
  if getline(a:lnum) =~ '\v^\s*$'
    return '-1'
  endif

  let this_indent = IndentLevel(a:lnum)
  let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

  if next_indent == this_indent
    return this_indent
  elseif next_indent < this_indent
    return this_indent
  elseif next_indent > this_indent
    return '>' . next_indent
  endif
endfunction
function! IndentLevel(lnum)
  return indent(a:lnum) / &shiftwidth
endfunction
function! NextNonBlankLine(lnum)
  let numlines = line('$')
  let current = a:lnum + 1
  while current <= numlines
    if getline(current) =~ '\v\S'
      return current
    endif
    let current += 1
  endwhile
  return -2
endfunction

" custom text to be shown for folded lines
function! GetFoldText()
  let line = getline(v:foldstart)
  "let prefix = repeat('-', indent(v:foldstart)-1).' '     " -----
  let prefix = '+'.repeat('-', indent(v:foldstart)-2).' '  " +----
  let postfix = ' '

  let line = substitute(line, '\v^\s+', prefix, '')  " sub leading whitespace
  let line = substitute(line, '\v$', postfix, '')    " sub the ending
  return line
endfunction

" mostly just for debugging - if file doesn't exist it will be created
function! AppendToFile(file, lines)
  if filewritable(a:file)
    call writefile(readfile(a:file)+a:lines, a:file)
  else
    call writefile(a:lines, a:file)
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
  " search       highlighted search terms
  " pmenu        completion menu nonselected
  " pmenusel     completion menu selected
  " folded       colors of closed fold
  " colorcolumn  the 80 character mark
  " userN        where N is 1..9; usedin statusline (:h hl-User1..9)
  "
  " There are more groups; ':help group-name' for more info.

  " Colors: black, red, green, yellow, blue, magenta, cyan, white, gray
  " There are others but these work in all 8 color terminals.

  hi normal                                      guibg=black   guifg=white
  hi comment                     ctermfg=grey                  guifg=grey
  hi constant                    ctermfg=blue                  guifg=green
  hi special                     ctermfg=cyan                  guifg=cyan
  hi folded      ctermbg=black   ctermfg=white   guibg=black   guifg=white
  hi pmenu       ctermbg=black   ctermfg=gray    guibg=black   guifg=gray
  hi pmenusel    ctermbg=black   ctermfg=cyan    guibg=black   guifg=cyan
  hi colorcolumn ctermbg=gray    ctermfg=black   guibg=gray    guifg=black
  hi search      ctermbg=cyan    ctermfg=black   guibg=cyan    guifg=black
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
