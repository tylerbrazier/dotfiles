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
set foldmethod=expr          " use a custom foldmethod
set foldexpr=GetFold(v:lnum) " defined below
set foldlevelstart=99        " initially open all folds
set foldtext=GetFoldText()   " the text to show on folded lines
set fillchars=fold:-         " trailing chars to be used on folded lines
set laststatus=2             " always show the statusline
set statusline=%!GetStl()    " set the statusline as defined below
set updatetime=200           " millis until cursorhold; used for autosave
if &modifiable
  set list                   " show listchars
  set colorcolumn=80         " show a line at column
endif

let g:gitBranch = ''         " current git branch; changed by SetGitBranch()
let g:enableComplete = 1     " [true] auto complete brackets and html/xml tags

" reset autocmds so that sourcing vimrc again doesn't run autocmds twice
autocmd!

filetype plugin indent on    " detect filetype and automatically indent
syntax on                    " syntax highlighting

" set git branch for statusline on buffer read
autocmd bufenter * call SetGitBranch()

" default to using spaces instead of tabs
autocmd bufenter * call SetWhitespaceStyle('spaces')

" go uses tabs instead of spaces
autocmd bufenter *.go call SetWhitespaceStyle('tabs')

" set syntax highlighting for *.md files
autocmd bufenter *.md set syntax=markdown

" don't split the window when looking at help pages
autocmd bufenter *.txt if &filetype == 'help' | only | endif

" autosave; write (if changed) every updatetime millis if editing a file
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
nnoremap <c-t> :call ToggleWhitespaceStyle()<cr>
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

" --------------------
" Function definitions
" --------------------

function! ToggleComplete()
  if g:enableComplete
    let g:enableComplete = 0
    echo 'Completion is off'
  else
    let g:enableComplete = 1
    echo 'Completion is on'
  endif
endfunction

" auto complete things like brackets and html/xml tags
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

function! ToggleComment()
  let t = &filetype
  let lhs = '#'  " left hand side default
  let rhs = ''   " right hand side default
  if t == 'c' || t == 'java' || t == 'javascript' || t == 'go'
    let lhs = '//'
  elseif t == 'tex'
    let lhs = '%'
  elseif t == 'vim'
    let lhs = '"'
  elseif t == 'html' || t == 'xml'
    let lhs = '<!--'
    let rhs = '-->'
  elseif t == 'css' || t == 'less'
    let lhs = '/*'
    let rhs = '*/'
  endif
  if IsSelectionCommented(lhs, rhs)
    return DoUncomment(lhs, rhs)
  else
    return DoComment(lhs, rhs)
  endif
endfunction

function! IsSelectionCommented(lhs, rhs)
  let v = line("v")
  let cur = line(".")
  let i = v < cur ? v : cur
  let end = v < cur ? cur : v
  while i <= end
    let line = getline(i)
    if !IsLineCommented(line, a:lhs, a:rhs)
      return 0  " false
    endif
    let i+=1
  endwhile
  return 1      " true
endfunction

function! IsLineCommented(line, lhs, rhs)
  let l = escape(a:lhs, '*')      " needed for comment chars like /* ... */
  let r = escape(a:rhs, '*')
  return a:line =~ '^\s*'.l.'.*'.r.'\s*$' " starts with lhs and ends with rhs
endfunction

function! DoComment(lhs, rhs)
  let c = ":normal! I".a:lhs
  if len(a:rhs) > 0
    let c = c."\<c-o>A".a:rhs
  endif
  return c."\<cr>"
endfunction

function! DoUncomment(lhs, rhs)
  let c = ":normal! ^".len(a:lhs)."x"
  if len(a:rhs) > 0
    let c = c.'g_d$'  " delete last non-whitespace char and all trailing space
  endif
  let i = 2
  while i <= len(a:rhs)
    let c = c.'x'
    let i += 1
  endwhile
  return c."\<cr>"
endfunction

" build the status line; %N* is for UserN highlighting, %0* resets
function! GetStl()
  let stl  = BufferList()                    " show buffer numbers
  let stl .= '%1*%='                         " divide left/right alignment
  let stl .= '%8*%l,%c '                     " line,column number
  let stl .= '%8*%{&fenc!=""?&fenc." ":""}'  " the file's encoding
  let stl .= '%8*%{&ff} '                    " file format (line ending)
  let stl .= '%2*%{g:gitBranch}'             " current git branch
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
      if (getbufvar(i, "&mod"))               " if current buffer is modified
        let ret .= '%2* '.name.' '            " color it red
      else
        let ret .= '%7* '.name.' '            " otherwise color it cyan
      endif
    elseif buflisted(i)
      if (getbufvar(i, "&mod"))               " if other buffer is modified
        let ret .= '%2* '.name.' '            " color it red
      else
        let ret .= '%9* '.name.' '            " otherwise color it gray
      endif
    endif
    let i += 1
  endwhile
  return ret
endfunction

" set current git branch for statusline
function! SetGitBranch()
  " lcd to ensure we're in the right dir when running git branch.
  " autochdir doesn't seem to kick in on bufread when this function is called.
  " See http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
  lcd %:p:h  " cd to directory of current file
  let b = system('git branch --no-color 2>/dev/null | grep ^*')
  let b = strpart(b, 2)                  " remove the '* ' part
  let b = substitute(b, "\n", ' ', '')   " tailing space instead of newline
  let g:gitBranch = b
endfunction

function! ToggleWhitespaceStyle()
  if &expandtab
    call SetWhitespaceStyle('tabs')
    echo 'Using tabs'
  else
    call SetWhitespaceStyle('spaces')
    echo 'Using spaces'
  endif
endfunction

" ws arg should be either 'tabs' or 'spaces'
function! SetWhitespaceStyle(ws)
  set tabstop=2                     " number of spaces to use for tab
  set shiftwidth=2                  " auto indent distance
  set softtabstop=2                 " backspace over shiftwidth distance
  if a:ws == 'tabs'
    set noexpandtab
    set listchars=tab:\ \ ,trail:·  " only show trailing whitespace
  elseif a:ws == 'spaces'
    set expandtab
    set listchars=tab:»»,trail:·    " show tabs and trailing whitespace
  endif
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

" ---------------------------------------
" Custom theme (instead of a colorscheme)
" ---------------------------------------

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
hi visual   ctermbg=darkblue ctermfg=white  cterm=bold
hi visual      gui=bold                     guibg=#0066ff guifg=white
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
hi folded      ctermbg=none  ctermfg=white  guibg=bg      guifg=white
hi colorcolumn ctermbg=grey  ctermfg=none   guibg=grey    guifg=NONE
hi matchparen  ctermbg=none  ctermfg=none   guibg=bg      guifg=NONE
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

