" Simple plugin management and settings script using vim 8's packages feature.
" :help packages
"
" The script defines a :Plugs command that clones (or updates) repos listed
" in s:plugins below. These will be kept in opt/ so that disabling or
" removing them doesn't require deleting the whole plugin from the file
" system. This means that each plugin will need to be enabled manually with
" :packadd.

let s:plugins = [
      \ 'ctrlpvim/ctrlp.vim',
      \ 'justinmk/vim-dirvish',
      \ 'tpope/vim-surround',
      \ 'tpope/vim-commentary',
      \ 'tpope/vim-repeat',
      \ 'airblade/vim-gitgutter',
      \ 'tylerbrazier/vim-flintstone',
      \ 'tylerbrazier/vim-bracepair',
      \ 'tylerbrazier/vim-tagpair',
      \ 'pangloss/vim-javascript',
      \ 'gcmt/taboo.vim',
      \]
" enable plugins with :packadd (not necessary for colorschemes)
" :help pack-add
packadd ctrlp.vim
packadd vim-dirvish
packadd vim-surround
packadd vim-commentary
packadd vim-repeat
packadd vim-gitgutter
packadd vim-bracepair
packadd vim-tagpair
packadd vim-javascript
packadd taboo.vim

command! Plugs call <sid>plugs()

function! s:plugs()
  for repo in s:plugins
    let url = 'https://github.com/'.repo
    let plugin = split(repo, '/')[1]
    let path = $HOME.'/.vim/pack/plugs/opt/'.plugin
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
