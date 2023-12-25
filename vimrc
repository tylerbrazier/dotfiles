" include default settings
source $VIMRUNTIME/defaults.vim

set autoread
set autowriteall
set autoindent
set smarttab
set hlsearch
set notimeout
set errorformat+=%m\ %f " for git status :cexpr
set formatoptions+=j    " delete comment characters when joining comment lines
set colorcolumn=+0      " show colorcolumn at textwidth
set wildcharm=<Tab>     " <Tab> starts completion in mappings
set wildmode=list:longest:lastused,full
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

" capital Y should behave like capital C and D (use yy to yank whole line)
nnoremap Y y$

" k/j over wrapped lines
noremap k gk
noremap j gj

" put over visual selection won't overwrite register with the replaced text
vnoremap p pgvy

" make * work on visual selection (doesn't work over multiple lines tho)
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>

" escape twice to get out of terminal mode
tnoremap <Esc><Esc> <C-\><C-N>

" use Tab to complete words (suggest recent words first)
inoremap <expr> <Tab> getline('.')[col('.')-2] =~ '\S' ? "\<C-P>" : "\<Tab>"

nnoremap <Space>w :w<CR>
nnoremap <Space>q :q<CR>
nnoremap <Space>e :e <Tab>
nnoremap <Space>b :b <Tab>
nnoremap <Space>d :bd<CR>
nnoremap <Space>h :help<Space>
nnoremap <Space>f :find<Space>
nnoremap <Space>g :grep<Space>
nnoremap <Space>s :set<Space>
nnoremap <Space>t :tabedit<CR>
nnoremap <Space>m :make<Space><Up>
nnoremap <Space>n :cn<CR>
nnoremap <Space>p :cp<CR>
nnoremap <Space>l :nohl<CR>
nnoremap <Space>x :new $HOME/.scratch<CR>
nnoremap <Space>r :registers abcdefghijklmnopqrstuvwxyz<CR>
nnoremap <Space>c :cexpr system("git status -s -uall \| sed '/^ D/d'")<CR>
nnoremap <Space>y i<C-R>=strftime("%F")<CR>
nnoremap <Space>z 1z=
nnoremap <Space><CR> :term<Space><Up>

augroup vimrc
	autocmd!

	autocmd FileType gitcommit setlocal spell
	autocmd FileType qf setlocal nowrap colorcolumn=0 scrolloff=0
	autocmd FileType sh setlocal mp=shellcheck\ -f\ gcc kp=man

	" auto open the quickfix window for commands that use it
	autocmd QuickFixCmdPost * botright cwindow

	" auto close the quickfix window if it's the last one open
	autocmd QuitPre * if winnr('$') == 2 | cclose | endif

	" highlight trailing whitespace in normal mode
	autocmd InsertLeave * match Error /\s\+$/
	autocmd InsertEnter * match none

	autocmd DirChanged * call s:oncd()
augroup END

function s:oncd()
	" :find and :grep in tracked dirs/files if cwd is in a git project
	let pathcmd = 'git ls-tree -rd --name-only HEAD'
	let &path = systemlist(pathcmd)->join(',').',,'
	if v:shell_error
		" not in a git dir
		let &path = ',,**' "cwd and all subdirs
		set grepprg=grep\ -n\ -r
		set grepformat=%f:%l:%m
	else
		set grepprg=git\ grep\ -I\ -n\ --column
		set grepformat=%f:%l:%c:%m
	endif
endfunction
call s:oncd()

"
" Plugins (:help packages)
"
command InstallPlugins :term sh -c "
	\ mkdir -p $HOME/.vim/pack/x/start; cd $HOME/.vim/pack/x/start; pwd;
	\ echo -n
	\ 'tpope/vim-commentary'
	\ 'tpope/vim-surround'
	\ 'tpope/vim-repeat'
	\ 'tylerbrazier/vim-flintstone'
	\ 'airblade/vim-gitgutter'
	\ 'pangloss/vim-javascript'
	\ 'editorconfig/editorconfig-vim'
	\ | xargs -t -d' ' -I{}
	\ git clone -q --depth 1 https://github.com/{}"

command UpdatePlugins :term sh -c "
	\ find $HOME/.vim/pack/x/start/* -maxdepth 0 -type d
	\ | xargs -t -I{} git -C {} pull"

" update gitgutter more frequently
set updatetime=800
nnoremap <silent> <C-Z> <C-Z>:silent! GitGutterAll<CR>

silent! colorscheme flintstone
