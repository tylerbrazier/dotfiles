" Plugin management and settings script.
" Each key in s:plugins is a plugin repo from github and
" each value is either 'start' (load on starup) or 'opt' (load with :packadd).
" See :help packages
"
" The :Plugs command clones missing repos and pulls out of date repos.
let s:plugins = {
      \ 'ctrlpvim/ctrlp.vim': 'start',
      \ 'justinmk/vim-dirvish': 'start',
      \ 'tpope/vim-surround': 'start',
      \ 'tpope/vim-commentary': 'start',
      \ 'tpope/vim-repeat': 'start',
      \ 'airblade/vim-gitgutter': 'start',
      \ 'tylerbrazier/vim-flintstone': 'start',
      \ 'tylerbrazier/vim-bracepair': 'start',
      \ 'tylerbrazier/vim-tagpair': 'start',
      \ 'pangloss/vim-javascript': 'start',
      \ 'gcmt/taboo.vim': 'start',
      \}

command! Plugs call <sid>plugs()
function! s:plugs()
  for [repo, packdir] in items(s:plugins)
    let url = 'https://github.com/'.repo
    let plugin = split(repo, '/')[1]
    let path = $HOME.'/.vim/pack/plugs/'.packdir.'/'.plugin
    if isdirectory(path)
      let cmd = join(['git -C', path, 'pull'])
    else
      let cmd = join(['git clone --depth 1', url, path])
    endif
    echo plugin.': '.system(cmd)
  endfor
endfunction


" Settings

" idle delay before firing CursorHold, updating gitgutter
set updatetime=1000

let g:ctrlp_switch_buffer = 0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

"shortcuts to add/diff/undo changes (faster typing than the default \h maps)
nnoremap <space>a :GitGutterStageHunk<cr>
nnoremap <space>d :GitGutterPreviewHunk<cr>
nnoremap <space>u :GitGutterUndoHunk<cr>

nnoremap <space>n :TabooRename<space>

" silent in case the plugin hasn't been installed yet
silent! colorscheme flintstone
