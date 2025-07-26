return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup {
			renderer = {
				icons = {
					show = {
						file = true,
						folder = false,
						folder_arrow = true,
						git = false,
					},
				},
			},
			view = {
				width = 25,
				side = 'left',
			},
			sync_root_with_cwd = true, --fix to open cwd with tree
			respect_buf_cwd = true,
			update_cwd = true,
			update_focused_file = {
				enable = true,
				update_cwd = true,
				update_root = true,
			},
		}
	end,

}
