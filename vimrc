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
set grepprg=git\ grep\ -I\ -n\ --column
set grepformat=%f:%l:%c:%m
let &path = systemlist("git ls-tree -rd --name-only HEAD")
			\->join(",").",,"

" make capital Y behave like capital C and D (use yy to yank whole line)
nnoremap Y y$

" make * and # work on visual selection
vnoremap * y/\V<C-R>=substitute(escape(@",'/\'), '\n', '\\n', 'g')<CR><CR>
vnoremap # y/\V<C-R>=substitute(escape(@",'/\'), '\n', '\\n', 'g')<CR><CR>

" ctrl-l clears highlighting and syncs diff
nnoremap <C-L> :nohl<CR>:diffupdate<CR><C-L>

nnoremap <Space>w :w<CR>
nnoremap <Space>q :q<CR>
nnoremap <Space>e :e <C-D>
nnoremap <Space>b :b <C-D>
nnoremap <Space>d :bd<CR>
nnoremap <Space>t :tabnew<CR>
nnoremap <Space>s :set<Space>
nnoremap <Space>f :find<Space>
nnoremap <Space>g :grep<Space>
nnoremap <Space>m :make <Up>
nnoremap <Space>o :copen<CR>
nnoremap <Space>c :cclose<CR>
nnoremap <Space>n :cnext<CR>
nnoremap <Space>p :cprev<CR>
nnoremap <Space>x :new $HOME/.scratch<CR>

runtime! ftplugin/man.vim
packadd! editorconfig
colorscheme slate
