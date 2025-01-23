set wildignorecase " case insensitive filename completion
set infercase      " and insert mode completion
set ignorecase     " and search
set smartcase      " unless search contains a capital letter
set wildcharm=<Tab>     " let tab start wildmenu in mappings
set colorcolumn=+0      " show colorcolumn at textwidth
set errorformat+=%m\ %f " for git status :cexpr
set grepprg=git\ grep\ -I\ -n\ --column
set grepformat=%f:%l:%c:%m
let &path = systemlist("git ls-tree -rd --name-only HEAD")
			\->join(",").",,"

nnoremap <Space>w :w<CR>
nnoremap <Space>q :q<CR>
nnoremap <Space>e :e <C-D>
nnoremap <Space>b :b <Tab>
nnoremap <Space>d :bd<CR>
nnoremap <Space>t :tabnew<CR>
nnoremap <Space>s :set<Space>
nnoremap <Space>f :find <C-D>
nnoremap <Space>m :make <Up>
nnoremap <Space>g :grep<Space>
nnoremap <Space>o :copen<CR>
nnoremap <Space>c :cclose<CR>
nnoremap <Space>n :cnext<CR>
nnoremap <Space>p :cprev<CR>
nnoremap <Space>x :new $HOME/.scratch<CR>
nnoremap <Space><CR> :!<Up>

" git diff current file
nnoremap <Space>D :vnew<CR>
			\:setl bt=nofile bh=wipe<CR>
			\:r !git show HEAD:#<CR>:1d _<CR>
			\:diffthis<CR><C-W>p:diffthis<CR>
" git blame current file
nnoremap <Space>B zz:vnew<CR>
			\:setl bt=nofile bh=wipe nowrap<CR>
			\:r !git blame #<CR>:1d _<CR>
			\:exe line('.', bufwinid('#'))<CR>zz
" git log current file
nnoremap <Space>L :tabnew<CR>
			\:setl bt=nofile bh=wipe ft=gitcommit<CR>
			\:r !git log -p #<CR>:1d _<CR>
" git show object under cursor
nnoremap <Space>O "xyiw:tabnew<CR>
			\:setl bt=nofile bh=wipe ft=gitcommit<CR>
			\:r !git show <C-R>x<CR>:1d _<CR>
" git status in quickfix list
nnoremap <Space>S :cexpr system("git status -s -uall
			\ \| sed '/^ D/d'")<CR>
