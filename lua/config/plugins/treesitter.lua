return {
	"nvim-treesitter/nvim-treesitter",
	version = false,                           -- Use latest stable version (recommended)
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },   -- Lazy-load on file open
	cmd = { "TSUpdate", "TSInstall", "TSBufToggle" }, -- Important commands
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects", -- Optional but recommended
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			-- Essential parsers
			ensure_installed = {
				"lua",
				"python",
				"javascript",
				"html",
				"css",
				"bash",
				"markdown",
				"json",
				"c",
				"cpp"
			},

			-- Core features
			highlight = {
				enable = true,
				disable = function(_, buf)
					-- Disable for large files
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
				additional_vim_regex_highlighting = false,
			},

			indent = { enable = true },
			incremental_selection = { enable = true },

			-- Recommended textobjects
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
			},
		})
	end
}
