set wildignorecase " case insensitive filename completion
set infercase      " and insert mode completion
set ignorecase     " and search
set smartcase      " unless search contains a capital letter
set colorcolumn=+0 " show colorcolumn at textwidth
set grepprg=git\ grep\ -I\ -n\ --column
set grepformat=%f:%l:%c:%m
let &path = systemlist("git ls-tree -rd --name-only HEAD")
			\->join(",").",,"

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
