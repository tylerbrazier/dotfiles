" load default settings (see also sensible.vim and other installed plugins)
source $VIMRUNTIME/defaults.vim

" use the system clipboard for yank, delete, change, and put operations
set clipboard=unnamed,unnamedplus

" mouse dragging in tmux doesn't work without this
set ttymouse=xterm2

" background color detection doesn't work very well so set it manually
set bg=dark

" highlight search matches (sensible.vim binds ctrl-l to clear them)
set hlsearch

" write unsaved changes when leaving a file
set autowriteall

" case insensitive search and completion
set ignorecase wildignorecase infercase
set smartcase "case sensitive if search contains a capital letter

" don't make backup~ and .swp files
set nobackup noswapfile

" right to left, top to bottom window splitting; consistent with tmux
set splitbelow splitright

" wrap lines at word boundaries and show > on wrapped lines
set linebreak showbreak=>

" fold code by indentation; all folds start open
set foldmethod=indent foldlevelstart=99

" show colorcolumn at textwidth
set colorcolumn=+0

" show all completion suggestions, like bash
set wildmode=list:longest

" don't time out while typing a mapping
set notimeout

" idle delay before firing CursorHold (updating gitgutter)
set updatetime=1000

" refresh gitgutter when resuming from suspend
nnoremap <silent> <C-Z> <C-Z>:silent! GitGutterAll<CR>

" capital Y should behave like capital C and D (use yy to yank whole line)
nnoremap Y y$

" put over visual selection won't overwrite register with the replaced text
vnoremap p pgvy

" use Tab to complete words (suggest recent words first)
inoremap <expr> <Tab> getline('.')[col('.')-2] =~ '\S' ? "\<C-P>" : "\<Tab>"

nnoremap <Space>w :w<CR>
nnoremap <Space>q :q<CR>
nnoremap <Space>e :e <C-D>
nnoremap <Space>b :ls<CR>:b
nnoremap <Space>t :tabedit<CR>
nnoremap <Space>x :new $HOME/.scratch<CR>
nnoremap <Space>; :<Up><CR>
nnoremap <Space><CR> :term<Space>

" git log (% refers to the current file)
nnoremap <Space>l :term git --no-pager log --stat -p --full-diff %

" find files in git tracked directories
let &path = ',,' . join(systemlist('git ls-tree -rd --name-only HEAD'), ',')
nnoremap <Space>f :find<Space>

" git status of changed files in the quickfix list
set errorformat+=%m\ %f
nnoremap <Space>s :cexpr system('git status --porcelain')<CR>

" git grep tracked files (relative to :pwd)
set grepprg=git\ --no-pager\ grep\ --no-color\ -I\ -n\ --column
set grepformat=%f:%l:%c:%m
nnoremap <Space>g :grep<Space>

augroup vimrc
	autocmd!

	autocmd FileType gitcommit setlocal spell
	autocmd FileType text setlocal spell textwidth=80
	autocmd FileType qf setlocal nowrap colorcolumn=0

	" don't insert comment chars when using o or O from a commented line
	autocmd FileType * setlocal formatoptions-=o

	" auto open the quickfix window for commands that use it
	autocmd QuickFixCmdPost * botright cwindow

	" auto close the quickfix window if it is the last one open
	autocmd WinEnter * if &ft == 'qf' && winnr('$') == 1 | quit | endif

	" highlight trailing whitespace in normal mode
	autocmd InsertLeave * match Error /\s\+$/
	autocmd InsertEnter * match none
augroup END

try
	colorscheme flintstone
catch
	colorscheme slate
endtry
