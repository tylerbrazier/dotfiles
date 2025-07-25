set ignorecase
set notimeout
set wildmode=full:lastused

nnoremap j gj
nnoremap k gk

nnoremap <Space>w :w<CR>
nnoremap <Space>q :q<CR>
nnoremap <Space>e :e <C-D>
nnoremap <Space>b :b <C-D>
nnoremap <Space>a :e #<CR>
nnoremap <Space>d :bp<Bar>bd #<CR>
nnoremap <Space>t :tabnew<CR>
nnoremap <Space>f :find<Space>
nnoremap <Space>g :grep<Space>
nnoremap <Space>o :copen<CR>
nnoremap <Space>c :cclose<CR>
nnoremap <Space>x :new $HOME/.scratch.txt<CR>

nnoremap <Space>s <C-W>s
nnoremap <Space>v <C-W>v
nnoremap <Space>h <C-W>h
nnoremap <Space>j <C-W>j
nnoremap <Space>k <C-W>k
nnoremap <Space>l <C-W>l

nnoremap <Space><CR> :below term <Up>
tnoremap <Esc><Space> <C-\><C-N><C-W>
