set notimeout
set wildmode=full:lastused

nnoremap j gj
nnoremap k gk
nnoremap / /\c
nnoremap ? ?\c
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

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
nnoremap <Space>z :set foldcolumn=auto<CR>zfi{

nnoremap <Space><CR> :below term <Up>
tnoremap <Esc><Esc> <C-\><C-N>

nnoremap <Space>in :set invnumber number?<CR>
nnoremap <Space>is :set invspell spell?<CR>
nnoremap <Space>iw :set invwrap wrap?<CR>
nnoremap <Space>ic :let &cc = (&cc > 0) ? 0 : <Up>

nnoremap <Space>h <C-W>h
nnoremap <Space>j <C-W>j
nnoremap <Space>k <C-W>k
nnoremap <Space>l <C-W>l

nnoremap <Space>D :ls h<CR>:bd <C-R>=getbufinfo()
			\->filter('v:val.hidden')
			\->map('v:val.bufnr')
			\->join(' ')<CR>
