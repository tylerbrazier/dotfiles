" Plugin management and settings script.
" This leverages the packages feature of vim 8 (:help packages).
" Each key in s:plugins is a plugin repo from Github and
" each value is either 'start' (load on startup) or 'opt' (load with :packadd)
"
" The :Plugs command clones missing repos and pulls out of date repos.
" All of these plugins will be kept in the "plugs" package.
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

" silent in case the plugin hasn't been installed yet
silent! colorscheme flintstone
