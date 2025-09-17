return {
	"folke/twilight.nvim",
	keys = { -- Lazy-load only when the key is pressed
		{ "<leader>l", "<cmd>Twilight<cr>", desc = "Toggle Twilight (focus mode)" },
	},
	opts = {
		-- Default configuration
		dimming = {
			alpha = 0.25, -- Amount of dimming (0-1 where 1 is fully opaque)
			color = { "Normal", "#ffffff" }, -- Dimming color
			term_bg = "#000000", -- Terminal background for dimming
			inactive = false, -- Dim inactive windows
		},
		context = 19,       -- Number of lines to keep above/below visible
		treesitter = true,  -- Use treesitter when available
		expand = {          -- Filetypes where Twilight expands
			"function",
			"method",
			"table",
			"if_statement",
		},
		exclude = {}, -- exclude these filetypes
	},
}
