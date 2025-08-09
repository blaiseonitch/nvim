return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,                 -- Load immediately (not lazy-loaded)
		priority = 1000,              -- Load before other plugins
		opts = {
			flavour = "macchiato",      -- "latte", "frappe", "macchiato", or "mocha"
			transparent_background = true, -- Set to true for transparency
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				telescope = true,
				lsp_trouble = true,
				-- Enable more integrations as needed (see docs)
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin") -- Apply the theme
		end,
	}
}

-- return {
-- 	'dasupradyumna/midnight.nvim',
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme 'midnight'
-- 	end
-- }
--
-- return {
-- 	"vague2k/vague.nvim",
-- 	lazy = false,   -- make sure we load this during startup if it is your main colorscheme
-- 	priority = 1000, -- make sure to load this before all the other plugins
-- 	config = function()
-- 		-- NOTE: you do not need to call setup if you don't want to.
-- 		require("vague").setup({
-- 			-- optional configuration here
-- 		})
-- 		vim.cmd("colorscheme vague")
-- 	end
-- }
--
-- return {
-- 	"ellisonleao/gruvbox.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		-- Default options:
-- 		require("gruvbox").setup({
-- 			terminal_colors = true, -- add neovim terminal colors
-- 			undercurl = true,
-- 			underline = true,
-- 			bold = true,
-- 			italic = {
-- 				strings = true,
-- 				emphasis = true,
-- 				comments = true,
-- 				operators = false,
-- 				folds = true,
-- 			},
-- 			strikethrough = true,
-- 			invert_selection = false,
-- 			invert_signs = false,
-- 			invert_tabline = false,
-- 			inverse = true, -- invert background for search, diffs, statuslines and errors
-- 			contrast = "", -- can be "hard", "soft" or empty string
-- 			palette_overrides = {},
-- 			overrides = {},
-- 			dim_inactive = false,
-- 			transparent_mode = false,
-- 		})
-- 		vim.o.background = "dark"
-- 		vim.cmd("colorscheme gruvbox")
-- 	end
-- }
