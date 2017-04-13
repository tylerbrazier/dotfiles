" no right and left scrollbars
set guioptions-=r
set guioptions-=L

" taboo styled tabs in gvim
if exists("g:loaded_taboo")
  set guioptions-=e
endif
