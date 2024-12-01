set wildignorecase " case insensitive filename completion
set infercase      " and insert mode completion
set ignorecase     " and search
set smartcase      " unless search contains a capital letter
set colorcolumn=+0      " show colorcolumn at textwidth
set errorformat+=%m\ %f " for git status :cexpr
set grepprg=git\ grep\ -I\ -n\ --column
set grepformat=%f:%l:%c:%m
let &path = systemlist("git ls-tree -rd --name-only HEAD")
			\->join(",").",,"

" tab-completion in Insert mode (shift-tab to insert a tab)
inoremap <Tab> <C-P>

nnoremap <Space>w :w<CR>
nnoremap <Space>q :q<CR>
nnoremap <Space>e :e <C-D>
nnoremap <Space>b :b <C-D>
nnoremap <Space>d :bd<CR>
nnoremap <Space>s :set<Space>
nnoremap <Space>t :tabnew<CR>
nnoremap <Space>f :find<Space>
nnoremap <Space>g :grep<Space>
nnoremap <Space>m :make<Space><Up>
nnoremap <Space>o :copen<CR>
nnoremap <Space>c :cclose<CR>
nnoremap <Space>n :cnext<CR>
nnoremap <Space>p :cprevious<CR>
nnoremap <Space>x :new $HOME/.scratch<CR>
nnoremap <Space><CR> :!<Up>

nnoremap <Space>S :cexpr system("git status -s -uall
			\ \| sed '/^ D/d'")<CR>
nnoremap <Space>D :vnew +set\ bt=nofile<CR>
			\:r !git show HEAD:#<CR>
			\:1d _<CR>:diffthis<CR>
			\<C-W>p:diffthis<CR>
