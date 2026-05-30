-- :help vim.pack
-- These are cloned into ~/.local/share/nvim/site/pack/core/opt
-- To work on these, manually clone into ~/.config/nvim/pack/whatever/start
-- and nvim should load them first as long as 'packpath' has
-- ~/.config/nvim before ~/.local/share/nvim/site (:set packpath?)
local plugins = {
	'https://github.com/tylerbrazier/vim-forgit',
	'https://github.com/tylerbrazier/vim-marcos',
	'https://github.com/tylerbrazier/vim-rwx',
	'https://github.com/tylerbrazier/vim-y',
	'https://github.com/tylerbrazier/vim-renegade',
	'https://github.com/tylerbrazier/vim-flintstone',
	'https://github.com/tylerbrazier/nvim-gh',
	'https://github.com/tylerbrazier/nvim-gx',
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/lewis6991/gitsigns.nvim',
	'https://github.com/tpope/vim-surround',
	'https://github.com/tpope/vim-repeat',
}

-- nvim-lspconfig requires language servers installed
local function sync_lsp(ev_kind)
	-- avoid sudo; consider first running
	-- 	npm config set prefix "$HOME"
	-- so executables go to ~/bin (and scripts to ~/lib/node_modules)
	-- https://docs.npmjs.com/cli/v11/configuring-npm/folders
	local cmd = {
		'npm',
		(ev_kind == 'delete') and 'uninstall' or ev_kind,
		'-g',
		'typescript', 'typescript-language-server'
	}
	print(table.concat(cmd, ' '))

	local obj = vim.system(cmd):wait()
	print(obj.stdout)
	print(obj.stderr)
	print('(exited '..obj.code..')')
	-- if you don't see output run :messages
end

-- :help vim.pack-events
vim.api.nvim_create_augroup('plugs', { clear = true })
vim.api.nvim_create_autocmd('PackChanged', {
	group = 'plugs',
	callback = function(ev)
		if ev.data.spec.name == 'nvim-lspconfig' then
			sync_lsp(ev.data.kind)
		end
	end
})

vim.pack.add(plugins)

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
