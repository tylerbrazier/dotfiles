" include default settings
source $VIMRUNTIME/defaults.vim

" press K on an option for help
set autoindent
set autoread
set hlsearch
set smarttab
set wildignorecase " case insensitive filename completion
set infercase      " and insert mode completion
set ignorecase     " and search
set smartcase      " unless search contains a capital letter
set wildoptions=pum,tagfile
set formatoptions+=j    " delete comment characters when joining comment lines
set colorcolumn=+0      " show colorcolumn at textwidth
set errorformat+=%m\ %f " for git status :cexpr
set grepprg=git\ grep\ -I\ -n\ --column
set grepformat=%f:%l:%c:%m
let &path = systemlist('git ls-tree -rd --name-only HEAD')->join(',').",,"

" make capital Y behave like capital C and D (use yy to yank whole line)
nnoremap Y y$

" make * and # work on visual selection
vnoremap * y/\V<C-R>=substitute(escape(@",'/\'), '\n', '\\n', 'g')<CR><CR>
vnoremap # y/\V<C-R>=substitute(escape(@",'/\'), '\n', '\\n', 'g')<CR><CR>

" ctrl-l clears highlighting and syncs diff
nnoremap <C-L> :nohl<CR>:diffupdate<CR><C-L>

" use Tab to complete words in Insert mode (shift-tab to insert a Tab)
inoremap <expr> <Tab> getline('.')[col('.')-2] =~ '\w' ? "\<C-P>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-N>" : "\<S-Tab>"

nnoremap <Space>w :w<CR>
nnoremap <Space>q :q<CR>
nnoremap <Space>e :e <C-D>
nnoremap <Space>b :b <C-D>
nnoremap <Space>d :bd<CR>
nnoremap <Space>s :set<Space>
nnoremap <Space>t :tabedit<CR>
nnoremap <Space>f :find<Space>
nnoremap <Space>g :grep<Space>
nnoremap <Space>m :make<Space><Up>
nnoremap <Space>n :cn<CR>
nnoremap <Space>p :cp<CR>
nnoremap <Space>x :new $HOME/.scratch<CR>
nnoremap <Space><CR> :!<Up>

nnoremap <Space>S :cexpr system("git status -s -uall \| sed '/^ D/d'")<CR>
nnoremap <Space>D :vnew +set\ bt=nofile<CR>
			\:r !git show HEAD:#<CR>:1d _<CR>:diffthis<CR>
			\<C-W>p:diffthis<CR>

augroup vimrc
	autocmd!

	autocmd FileType gitcommit setlocal spell
	autocmd FileType qf setlocal nowrap colorcolumn=0 scrolloff=0
	autocmd FileType sh setlocal mp=shellcheck\ -f\ gcc kp=man

	" auto open the quickfix window for commands that use it
	autocmd QuickFixCmdPost * botright cwindow

	" auto close the quickfix window if it's the last one open
	autocmd QuitPre * if winnr('$') == 2 | cclose | endif

	" highlight trailing whitespace in normal mode
	autocmd InsertLeave * match Error /\s\+$/
	autocmd InsertEnter * match none
augroup END

packadd! editorconfig

" $VIMRUNTIME/colors/README.txt
" Use color names instead of numbers for cterms because vim can choose the
" correct number based on what the terminal supports (:help cterm-colors)
" :help group-name
set background=dark
hi clear
hi Normal	ctermfg=White
hi Comment	ctermfg=Gray
hi Constant	ctermfg=Blue
hi Identifier	ctermfg=Red
hi Statement	ctermfg=Green
hi PreProc	ctermfg=Magenta
hi Type		ctermfg=Cyan
hi Special	ctermfg=Yellow
" :help highlight-groups
hi DiffAdd	ctermbg=Green	ctermfg=Black
hi DiffDelete	ctermbg=Red	ctermfg=White
hi DiffChange	ctermbg=Blue	ctermfg=White
hi DiffText	ctermbg=Cyan	ctermfg=Black
hi Visual	ctermbg=Gray
hi! link ColorColumn	Visual
hi! link MatchParen	Visual
hi! link QuickFixLine	Visual
hi! link Search		Visual
hi! link IncSearch	Search
hi! link SpecialKey	Special
hi! link Question	Type
hi! link MoreMsg	Statement
hi! link Title		Identifier
hi! link Directory	Constant
hi! link LineNr		Comment
hi! link WarningMsg	Todo
hi! link Pmenu		Normal
hi! link PmenuSel	DiffChange
hi! link PmenuSbar	Pmenu
hi! link TabLine	TabLineFill
hi! link WildMenu	TabLineSel
