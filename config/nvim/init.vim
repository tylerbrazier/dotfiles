set wildignorecase " case insensitive filename completion
set infercase      " and insert mode completion
set ignorecase     " and search
set smartcase      " unless search contains a capital letter
set colorcolumn=+0 " show colorcolumn at textwidth

nnoremap <Space>w :w<CR>
nnoremap <Space>q :q<CR>
nnoremap <Space>e :e <C-D>
nnoremap <Space>b :b <C-D>
nnoremap <Space>t :tabnew<CR>
nnoremap <Space>f :find<Space>
nnoremap <Space>g :grep<Space>
nnoremap <Space>m :make <Up>
nnoremap <Space>o :copen<CR>
nnoremap <Space>c :cclose<CR>
nnoremap <Space>n :cnext<CR>
nnoremap <Space>p :cprev<CR>
nnoremap <Space>x :new $HOME/.scratch<CR>
