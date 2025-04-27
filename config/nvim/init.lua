vim.o.clipboard = 'unnamedplus'
vim.o.wildmode = 'full:lastused'

vim.keymap.set('n', '<Space>w', ':w<CR>')
vim.keymap.set('n', '<Space>q', ':q<CR>')
vim.keymap.set('n', '<Space>e', ':e <C-D>')
vim.keymap.set('n', '<Space>b', ':b <C-D>')
vim.keymap.set('n', '<Space>t', ':tabnew<CR>')
vim.keymap.set('n', '<Space>f', ':find ')
vim.keymap.set('n', '<Space>g', ':grep ')
vim.keymap.set('n', '<Space>o', ':copen<CR>')
vim.keymap.set('n', '<Space>c', ':cclose<CR>')
vim.keymap.set('n', '<Space>x', ':new $HOME/.scratch.txt<CR>')
vim.keymap.set('n', '<Space><CR>', ':below term <Up>')

vim.keymap.set({'t','n','i'}, '<A-h>', '<C-\\><C-N><C-W>h')
vim.keymap.set({'t','n','i'}, '<A-j>', '<C-\\><C-N><C-W>j')
vim.keymap.set({'t','n','i'}, '<A-k>', '<C-\\><C-N><C-W>k')
vim.keymap.set({'t','n','i'}, '<A-l>', '<C-\\><C-N><C-W>l')
