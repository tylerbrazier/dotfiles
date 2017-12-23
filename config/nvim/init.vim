" :help nvim-from-vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

nnoremap <space><cr> :split<bar>term<space><up>
tnoremap <esc> <c-\><c-n>
" can use <c-o> to escape from insert mode if stuck in a nested vim
