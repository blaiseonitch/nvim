return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",  -- Required by Telescope
			"nvim-telescope/telescope-fzf-native.nvim", -- Faster sorting (optional but recommended)
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					-- Better default previewers (disable for large files)
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				},
			})

			-- Load optional fzf-native for speed (if installed)
			pcall(telescope.load_extension, "fzf")
		end,
	},
}
