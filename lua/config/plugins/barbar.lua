return {
	'romgrk/barbar.nvim',
	version = '^1.0.0',            -- Only update for 1.x releases
	dependencies = {
		'lewis6991/gitsigns.nvim',   -- Optional: for git status
		'nvim-tree/nvim-web-devicons', -- Optional: for file icons
	},
	opts = {
		animation = false,
		tabpages = true,
		focus_on_close = 'left',
		hide = {
			extensions = false,
			inactive = false
		},
		icons = {
			buffer_index = false,
			buffer_number = false,
			button = '',
			diagnostics = {
				[vim.diagnostic.severity.ERROR] = { enabled = false, icon = ' ' },
			},
			gitsigns = {
				added = { enabled = false, icon = ' ' },
				changed = { enabled = false, icon = ' ' },
				deleted = { enabled = false, icon = ' ' },
			},
			separator = { left = '▎', right = ' ' },
			separator_at_end = true,
			modified = { button = '●' },
			pinned = { button = '', filename = true },
			alternate = { filetype = { enabled = false } },
			current = { buffer_index = true },
			inactive = { button = '×' },
			visible = { modified = { buffer_number = false } },
		},
		sidebar_filetypes = {
			NvimTree = true,
			undotree = {
				text = 'undotree',
				align = 'left',
			},
			['neo-tree'] = { event = 'BufWipeout' },
			Outline = {
				event = 'BufWinLeave',
				text = 'symbols-outline',
				align = 'right'
			},
		},
		maximum_length = 15,
	},
	config = function(_, opts)
		require('barbar').setup(opts)
	end,
}

-- return {
-- 	'romgrk/barbar.nvim',
-- 	dependencies = {
-- 		'lewis6991/gitsigns.nvim',   -- OPTIONAL: for git status
-- 		'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
-- 	},
-- 	init = function() vim.g.barbar_auto_setup = false end,
-- 	opts = {
-- 		animation = false,
-- 		tabpages = true,
-- 		focus_on_close = 'left',
--
-- 		icons = {
-- 			buffer_index = false,
-- 			buffer_number = false,
-- 			button = '×',
-- 			separator = { left = '▎', right = '' },
-- 			modified = { button = '●' },
-- 			pinned = { button = '📌' },
-- 		},
--
-- 		sidebar_filetypes = {
-- 			NvimTree = true,
-- 			['neo-tree'] = true,
-- 		},
--
-- 		maximum_length = 20,
-- 	},
-- 	version = '^1.0.0',
-- }
