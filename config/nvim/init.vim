" :help nvim-from-vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

augroup nvimrc
  autocmd!
  autocmd BufEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
augroup end

nnoremap <space><cr> :split term://<up>
tnoremap <esc> <c-\><c-n>
" can use <c-o> to escape from insert mode if stuck in a nested vim
