" include default settings
source $VIMRUNTIME/defaults.vim

set autoread
set autowriteall
set autoindent
set smarttab
set hlsearch
set notimeout
set laststatus=2      " always show status line
set formatoptions+=j  " delete comment characters when joining comment lines
set ttymouse=xterm2   " mouse dragging in tmux doesn't work without this
set bg=dark           " background color detection doesn't work very well
set colorcolumn=+0    " show colorcolumn at textwidth
set wildmode=list:longest  " show all completion suggestions, like bash
set nowildmenu  " <Up> after completion cycles thru history, not suggestions
set clipboard=unnamed,unnamedplus

" case insensitive search and completion
set ignorecase
set wildignorecase
set infercase
set smartcase "case sensitive if search contains a capital letter

" don't make backup~ and .swp files
set nobackup
set noswapfile

" window splitting from left to right, top to bottom
set splitright
set splitbelow

" wrap lines at word boundaries and show > on wrapped lines
set linebreak
set showbreak=>

" fold code by indentation
set foldmethod=indent
set foldlevelstart=99 " all folds start open

" capital Y should behave like capital C and D (use yy to yank whole line)
nnoremap Y y$

" put over visual selection won't overwrite register with the replaced text
vnoremap p pgvy

" use Tab to complete words (suggest recent words first)
inoremap <expr> <Tab> getline('.')[col('.')-2] =~ '\S' ? "\<C-P>" : "\<Tab>"

nnoremap <Space>w :w<CR>
nnoremap <Space>q :q<CR>
nnoremap <Space>e :e <C-D>
nnoremap <Space>b :ls<CR>:b<Space>
nnoremap <Space>s :set<Space>
nnoremap <Space>t :tabedit<CR>
nnoremap <Space>n :cn<CR>
nnoremap <Space>p :cp<CR>
nnoremap <Space>h :nohl<CR>
nnoremap <Space>x :new $HOME/.scratch<CR>
nnoremap <Space><CR> :term<Space>

" find files in directories tracked by git
let &path = join(systemlist('git ls-tree -rd --name-only HEAD'), ',') . ',,'
nnoremap <Space>f :find<Space>

" see changed files since the last git commit
set errorformat+=%m\ %f
nnoremap <Space>c :cexpr system('git status --porcelain')<CR>

" grep files tracked by git (relative to :pwd)
set grepprg=git\ --no-pager\ grep\ --no-color\ -I\ -n\ --column
set grepformat=%f:%l:%c:%m
nnoremap <Space>g :grep<Space>

augroup vimrc
	autocmd!

	autocmd FileType gitcommit setlocal spell
	autocmd FileType qf setlocal nowrap colorcolumn=0

	" auto open the quickfix window for commands that use it
	autocmd QuickFixCmdPost * botright cwindow

	" auto close the quickfix window if it is the last one open
	autocmd WinEnter * if &ft == 'qf' && winnr('$') == 1 | quit | endif

	" highlight trailing whitespace in normal mode
	autocmd InsertLeave * match Error /\s\+$/
	autocmd InsertEnter * match none
augroup END
