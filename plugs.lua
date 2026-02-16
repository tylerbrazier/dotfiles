vim.cmd('colorscheme flintstone')

vim.lsp.enable('ts_ls')

require('gitsigns').setup {
	signs = {
		add		= { text = '┃' },
		change		= { text = '┃' },
		changedelete	= { text = '┃' },
		delete		= { text = '_' },
		topdelete	= { text = '‾' },
		untracked	= { text = '┆' },
	},
	signs_staged = {
		add		= { text = '┃' },
		change		= { text = '┃' },
		changedelete	= { text = '┃' },
		delete		= { text = '_' },
		topdelete	= { text = '‾' },
		untracked	= { text = '┆' },
	},
	-- https://github.com/lewis6991/gitsigns.nvim/issues/1344
	diff_opts = { linematch = 0 },
}

vim.keymap.set('n', 'gsb', ':Gitsigns blame<CR>')
vim.keymap.set('n', 'gsq', ':Gitsigns setqflist all<CR>')
vim.keymap.set('n', 'gsd', ':Gitsigns diffthis <Up>')
vim.keymap.set('n', 'gsp', ':Gitsigns preview_hunk<CR>')
vim.keymap.set('n', 'gss', ':Gitsigns stage_hunk<CR>')
vim.keymap.set('n', 'gsu', ':Gitsigns undo_stage_hunk<CR>')
vim.keymap.set('n', 'gsr', ':Gitsigns reset_hunk<CR>')
vim.keymap.set('n', ']g',  ':Gitsigns nav_hunk next<CR>')
vim.keymap.set('n', '[g',  ':Gitsigns nav_hunk prev<CR>')

-- TODO contribute to gitsigns and add functionality like this
-- but without using term:
vim.api.nvim_create_user_command('GitLog',
	'exec "vert term git -P log" '
	..'(<count> > 0 ? "-L"..<line1>..","..<line2>..":%" : "") '
	..'<q-args>',
	{ nargs = '*', range = true, })
-- Because term has limited scrollback you usually want to
-- include something like `-n 100` in the args:
vim.keymap.set({'n','v'}, 'gsl', ':GitLog <Up>')
vim.keymap.set('n', 'gso', ':above term git -P show <Up>')
