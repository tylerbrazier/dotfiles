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
" ctrl-c    [c]onvert file to uft8, unix line ending, tabs to spaces, trim ws
" ctrl-i    fix [i]ndentation on whole file or visual selection
" ctrl-u    toggle showing line n[u]mbers
" ctrl-l    toggle code fo[l]d
" ctrl-a    emacs-style go to st[a]rt of line
" ctrl-e    emacs-style go to [e]nd of line
" ctrl-x    edit scratch file ~/.scratch
" ctrl-/    (or ctrl-o) toggle c[o]mment on line or visual selection
"
" Note: ctrl-/ for toggle comment works on some terminals but on in gvim :(
" If it doesn't work, just use ctrl-o instead.

" Insert mode key binding reference
" ---------------------------------
" ctrl-c    (in visual insert) copy to system clipboard
" ctrl-x    (in visual insert) cut into system clipboard
" ctrl-v    paste from system clipboard
" ctrl-z    undo
" [tab]     if cursor follows a nonwhitespace character, do word completion
"
" When tab completion menu is up, use [tab] or ctrl-n to move to the next
" suggestion, shift-tab or ctrl-p for previous suggestion, and
" [enter] to select.

set nocompatible             " vim, not vi. should be first in vimrc
set encoding=utf-8           " set the encoding displayed by vim
set expandtab                " spaces instead of tabs
set tabstop=2                " number of spaces to use for tab
set shiftwidth=2             " number of spaces used for indentation
set softtabstop=2            " backspace correctly over tab distance
set listchars=tab:__,trail:_ " what to show when :set list is on
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
set foldmethod=expr          " use a custom foldmethod
set foldexpr=GetFold(v:lnum) " defined below
set foldlevelstart=99        " initially open all folds
set foldtext=GetFoldText()   " the text to show on folded lines
set fillchars=fold:-         " trailing chars to be used on folded lines
set laststatus=2             " always show the statusline
set statusline=%!GetStl()    " set the statusline as defined below
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
nnoremap <c-c> :call ConvertFile()<cr>
nnoremap <c-i> mxgg=G'x
vnoremap <c-i> =
nnoremap <c-u> :set invnumber<cr>
nnoremap <c-l> za
nnoremap <c-a> ^
nnoremap <c-e> $
nnoremap <c-x> :edit $HOME/.scratch<cr>
noremap <expr> <c-o> ToggleComment()
noremap <expr> <c-_> ToggleComment()
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
inoremap <expr> <tab> TabComplete()
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<tab>"
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<cr>"

" Don't rebind these keys:
" c-r because that's for redo
" c-v because that's for visual block selection
" c-m because pressing enter will trigger this (:help key-notation)

" can be used instead of a colorscheme
function! ApplyCustomTheme()
  " boilerplate for applying a theme
  hi clear
  set background=dark
  if exists('syntax_on')
    syntax reset
  endif

  set guifont=Monospace\ 9

  " Hightlight (hi) groups (from :help group-name):
  "   comment        any comment
  "   constant       stings, numbers, booleans, etc.
  "     string       "example"
  "     character    character constants like 'c'
  "     number       123, 0xff
  "     boolean      TRUE, false
  "     float        2.3e10
  "   identifier     functions, brackets, variable names
  "     function     and methods
  "   statement      if, else, for, while, case, try, catch, etc.
  "     conditional  if, then, else, endif, switch, etc.
  "     repeat       for, do, while, etc.
  "     label        case, default, etc.
  "     operator     +, *, sizeof, etc.
  "     exception    try, catch, throw, etc.
  "     keyword      any other keyword
  "   preproc        preprocessors like import, include, #if, #define, etc.
  "   type           keywords like int, long, char, etc.
  "   special        special symbols like '\n' (affects diffs and patches)
  "   underlined     text that stands out, HTML links
  "   error          synta errors
  "   todo           mostly keywords TODO, FIXME, and XXX
  "
  " Some additional groups that you might want to specfically color for:
  "   title        section headers, html <title>, etc
  "   linenr       line numbers
  "   search       highlighted search terms
  "   pmenu        completion menu nonselected
  "   pmenusel     completion menu selected
  "   folded       colors of closed fold
  "   colorcolumn  the 80 character mark
  "   matchparen   matching brackets/parens
  "   diffadd      vimdiff added line
  "   diffdelete   vimdiff removed line
  "   diffchange   vimdiff changed line
  "   difftext     vimdiff actual text that changed
  "   userN        where N is 1..9; used in statusline (:h hl-User1..9)
  "
  " There are more groups; ':help group-name' for more info.
  "
  " Colors: black, red, green, yellow, blue, magenta, cyan, white, gray
  " There are others but these work in all 8 color terminals.
  hi normal                                   guibg=#242424 guifg=white
  hi comment                   ctermfg=grey                 guifg=grey
  hi constant                  ctermfg=green                guifg=#66ff66
  hi identifier                ctermfg=cyan                 guifg=#00ccff
  hi statement                 ctermfg=red                  guifg=#ff8855
  hi preproc                   ctermfg=blue                 guifg=#0066ff
  hi type                      ctermfg=cyan                 guifg=#00ccff
  hi todo        ctermbg=none  ctermfg=yellow guibg=bg      guifg=yellow
  hi todo        cterm=underline,bold         gui=underline,bold
  hi title       cterm=bold    ctermfg=white  gui=bold      guifg=white
  hi linenr                    ctermfg=grey                 guifg=grey
  hi search      ctermbg=none  ctermfg=none   guibg=bg      guifg=NONE
  hi search      cterm=underline,bold         gui=underline,bold
  hi pmenu       ctermbg=black ctermfg=gray   guibg=black   guifg=gray
  hi pmenusel    ctermbg=black ctermfg=cyan   guibg=black   guifg=#00ccff
  hi folded                    ctermfg=white  guibg=bg      guifg=white
  hi colorcolumn ctermbg=gray  ctermfg=black  guibg=grey    guifg=black
  hi matchparen  ctermbg=none  ctermfg=white  guibg=bg      guifg=white
  hi matchparen  cterm=underline,bold         gui=underline,bold
  hi diffadd     ctermbg=green ctermfg=white  guibg=green   guifg=white
  hi diffdelete  ctermbg=red   ctermfg=white  guibg=red     guifg=white
  hi diffchange  ctermbg=cyan  ctermfg=white  guibg=cyan    guifg=white
  hi difftext    ctermbg=blue  ctermfg=white  guibg=blue    guifg=white
  hi user1                     ctermfg=black                guifg=black
  hi user2                     ctermfg=red                  guifg=red
  hi user3                     ctermfg=green                guifg=green
  hi user4                     ctermfg=yellow               guifg=yellow
  hi user5                     ctermfg=blue                 guifg=blue
  hi user6                     ctermfg=magenta              guifg=magenta
  hi user7                     ctermfg=cyan                 guifg=cyan
  hi user8                     ctermfg=white                guifg=white
  hi user9                     ctermfg=gray                 guifg=gray
endfunction
call ApplyCustomTheme()

"
" Function definitions
" --------------------
function! TabComplete()
  let char = getline('.')[col('.')-2]  " get the char behind cursor
  if empty(char) || char =~ '\s'       " if there isn't one or it's white space
    return "\<tab>"                    " tab as usual
  elseif (&filetype == 'html' || &filetype == 'xml') && char == '/'
    return "\<c-x>\<c-o>"              " complete end tag; e.g. <p>...</[Tab]
  else
    return "\<c-n>"                    " otherwise do completion
  endif
endfunction

function! ToggleComment()
  let type = &filetype
  if type =~ '\vc(pp)?$' || type =~ '\vjava(script)?$'  " c(pp) or java(script)
    let pattern = '//'
  elseif type == 'tex'
    let pattern = '%'
  elseif type == 'vim'
    let pattern = '"'
  else
    let pattern = '#'
  endif
  if IsSelectionCommented(pattern)
    return DoUncomment(pattern)
  else
    return DoComment(pattern)
  endif
endfunction
function! IsSelectionCommented(pattern)
  let v = line("v")
  let cur = line(".")
  let i = v < cur ? v : cur
  let end = v < cur ? cur : v
  while i <= end
    let line = getline(i)
    if !IsLineCommented(line, a:pattern)
      return 0  " false
    endif
    let i+=1
  endwhile
  return 1      " true
endfunction
function! IsLineCommented(line, pattern)
  if &filetype == 'html' || &filetype == 'xml'
    return a:line =~ '^\s*<!--.*-->\s*$' " starts with <!-- and ends with -->
  else
    return a:line =~ '^\s*'.a:pattern  " starts with comment pattern
  endif
endfunction
function! DoComment(pattern)
  if &filetype == 'html' || &filetype == 'xml'
    return ":normal I<!--\<c-o>A-->\<cr>"
  else
    return substitute(":normal Ipattern\<cr>", 'pattern', a:pattern, '')
  endif
endfunction
function! DoUncomment(pattern)
  if &filetype == 'html' || &filetype == 'xml'
    return ":normal ^4xg_d$xx\<cr>"
  else
    return substitute(":normal ^lenx\<cr>", 'len', len(a:pattern), '')
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
  let stl .= '%8*%{&fenc!=""?&fenc." ":""}'  " the file's encoding
  let stl .= '%8*%{&ff} '                    " file format (line ending)
  let stl .= '%2*%{g:git_branch}'            " current git branch
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
  let b = system('git branch --no-color 2>/dev/null | grep ^*')
  let b = strpart(b, 2)                  " remove the '* ' part
  let b = substitute(b, "\n", ' ', '')   " tailing space instead of newline
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
