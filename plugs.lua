-- :help vim.pack (~/.local/share/nvim/site/pack/core/opt)
local plugins = {
	'git@github.com:tylerbrazier/vim-forgit',
	'git@github.com:tylerbrazier/vim-marcos',
	'git@github.com:tylerbrazier/vim-gh',
	'git@github.com:tylerbrazier/vim-rwx',
	'git@github.com:tylerbrazier/vim-y',
	'git@github.com:tylerbrazier/vim-renegade',
	'git@github.com:tylerbrazier/vim-flintstone',
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/lewis6991/gitsigns.nvim',
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
