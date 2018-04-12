" Simple plugin management and settings script using vim 8's packages feature.
" :help packages
"
" The script defines a :Plugs command that clones (or updates) repos listed
" in s:plugins below. These will be kept in opt/ so that disabling or
" removing them doesn't require deleting the whole plugin from the file
" system. This also means they will need to be enabled manually with :packadd.
"
" Some lines in here are preceded with :silent! so vim doesn't startup with
" errors if plugins haven't been installed.
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
" enable plugins (not necessary for colorschemes) :help pack-add
silent! packadd ctrlp.vim
silent! packadd vim-dirvish
silent! packadd vim-surround
silent! packadd vim-commentary
silent! packadd vim-repeat
silent! packadd vim-gitgutter
silent! packadd vim-bracepair
silent! packadd vim-tagpair
silent! packadd vim-javascript
silent! packadd taboo.vim

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
set updatetime=100

let g:ctrlp_switch_buffer = 0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

"shortcuts to add/diff/undo changes (faster typing than the default \h maps)
nnoremap <space>a :GitGutterStageHunk<cr>
nnoremap <space>d :GitGutterPreviewHunk<cr>
nnoremap <space>u :GitGutterUndoHunk<cr>

silent! colorscheme flintstone
