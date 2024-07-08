" include default settings
source $VIMRUNTIME/defaults.vim

" press K on an option for help
set autoindent
set autoread
set hlsearch
set smarttab
set scrolloff&
set wildignorecase " case insensitive filename completion
set infercase      " and insert mode completion
set ignorecase     " and search
set smartcase      " unless search contains a capital letter
set display=lastline
set listchars=tab:>\ ,trail:-,nbsp:+
set wildoptions=pum,tagfile
set formatoptions+=j    " delete comment characters when joining comment lines
set colorcolumn=+0      " show colorcolumn at textwidth
set errorformat+=%m\ %f " for git status :cexpr
set grepprg=git\ grep\ -I\ -n\ --column
set grepformat=%f:%l:%c:%m
let &path = systemlist('git ls-tree -rd --name-only HEAD')->join(',').",,"

" make capital Y behave like capital C and D (use yy to yank whole line)
nnoremap Y y$

" make * and # work on visual selection
vnoremap * y/\V<C-R>=substitute(escape(@",'/\'), '\n', '\\n', 'g')<CR><CR>
vnoremap # y/\V<C-R>=substitute(escape(@",'/\'), '\n', '\\n', 'g')<CR><CR>

" ctrl-l clears highlighting and syncs diff
nnoremap <C-L> :nohl<CR>:diffupdate<CR><C-L>

" use Tab to complete words in Insert mode (shift-tab to insert a Tab)
inoremap <expr> <Tab> getline('.')[col('.')-2] =~ '\w' ? "\<C-P>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-N>" : "\<S-Tab>"

nnoremap <Space>w :w<CR>
nnoremap <Space>q :q<CR>
nnoremap <Space>e :e <C-D>
nnoremap <Space>b :b <C-D>
nnoremap <Space>d :bd<CR>
nnoremap <Space>s :set<Space>
nnoremap <Space>t :tabedit<CR>
nnoremap <Space>f :find<Space>
nnoremap <Space>g :grep<Space>
nnoremap <Space>m :make<Space><Up>
nnoremap <Space>o :copen<CR>
nnoremap <Space>c :cclose<CR>
nnoremap <Space>n :cnext<CR>
nnoremap <Space>p :cprevious<CR>
nnoremap <Space>x :new $HOME/.scratch<CR>
nnoremap <Space><CR> :!<Up>

nnoremap <Space>S :cexpr system("git status -s -uall \| sed '/^ D/d'")<CR>
nnoremap <Space>D :vnew +set\ bt=nofile<CR>
			\:r !git show HEAD:#<CR>:1d _<CR>:diffthis<CR>
			\<C-W>p:diffthis<CR>

runtime! ftplugin/man.vim
packadd! editorconfig
colorscheme slate
