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
nnoremap <Space>r :e %:h/<C-D>
nnoremap <Space>a :e #<CR>
nnoremap <Space>b :b <C-D>
nnoremap <Space>d :ls<CR>:bd<Space>
nnoremap <Space>f :find<Space>
nnoremap <Space>g :grep<Space>
nnoremap <Space>co :below copen<Bar>setl nowrap<CR>
nnoremap <Space>cc :cclose<CR>
nnoremap <Space>cd :lcd<Space>
nnoremap <Space>x :new $HOME/.scratch.txt<CR>
nnoremap <Space>z :set foldcolumn=auto<CR>zfi{

nnoremap <Space><CR> :below term <Up>
tnoremap <Esc><Esc> <C-\><C-N>

nnoremap <Space>in :setl invnumber number?<CR>
nnoremap <Space>is :setl invspell spell?<CR>
nnoremap <Space>iw :setl invwrap wrap?<CR>
nnoremap <Space>ic :let &l:cc = (&cc > 0) ? 0 : <Up>

nnoremap <Space>s <C-W>s
nnoremap <Space>v <C-W>v
nnoremap <Space>h <C-W>h
nnoremap <Space>j <C-W>j
nnoremap <Space>k <C-W>k
nnoremap <Space>l <C-W>l
nnoremap <Space>H <C-W>H
nnoremap <Space>J <C-W>J
nnoremap <Space>K <C-W>K
nnoremap <Space>L <C-W>L

nnoremap <Space>t :tab split<CR>
nnoremap <Space>1 1gt
nnoremap <Space>2 2gt
nnoremap <Space>3 3gt
nnoremap <Space>4 4gt
nnoremap <Space>5 5gt
nnoremap <Space>6 6gt
nnoremap <Space>7 7gt
nnoremap <Space>8 8gt
nnoremap <Space>9 9gt
nnoremap <Space>0 :tablast<CR>
