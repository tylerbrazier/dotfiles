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
nnoremap <Space>d :bd<CR>
nnoremap <Space>t :tabnew<CR>
nnoremap <Space>s :belowright split<CR>
nnoremap <Space>v :belowright vsplit<CR>
nnoremap <Space>f :find<Space>
nnoremap <Space>g :grep<Space>
nnoremap <Space>co :below copen<CR>
nnoremap <Space>cc :cclose<CR>
nnoremap <Space>cd :lcd<Space>
nnoremap <Space>x :new $HOME/.scratch.txt<CR>
nnoremap <Space>z :set foldcolumn=auto<CR>zfi{

nnoremap <Space>in :set invnumber number?<CR>
nnoremap <Space>is :set invspell spell?<CR>
nnoremap <Space>iw :set invwrap wrap?<CR>
nnoremap <Space>ic :let &cc = (&cc > 0) ? 0 : <Up>

nnoremap <Space>h <C-W>h
nnoremap <Space>j <C-W>j
nnoremap <Space>k <C-W>k
nnoremap <Space>l <C-W>l
nnoremap <Space>H <C-W>H
nnoremap <Space>J <C-W>J
nnoremap <Space>K <C-W>K
nnoremap <Space>L <C-W>L

nnoremap <Space><CR> :below term <Up>
tnoremap <Esc><Esc> <C-\><C-N>
