return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional icon support
	event = "VeryLazy",                              -- Loads after UI starts (better performance)
	opts = function()
		-- local diagnostics = {
		-- 	"diagnostics",
		-- 	sources = { "nvim_diagnostic" },
		-- 	sections = { "error", "warn" },
		-- 	symbols = { error = " ", warn = " " },
		-- 	colored = true,
		-- 	update_in_insert = false,
		-- 	always_visible = true,
		-- 	cond = function()
		-- 		return vim.bo.filetype ~= "markdown"
		-- 	end,
		-- }

		local progress = function()
			local current_line = vim.fn.line(".")
			local total_lines = vim.fn.line("$")
			local line_ratio = current_line / total_lines
			return math.floor(line_ratio * 100) .. "%%"
		end

		return {
			options = {
				icons_enabled = true,
				-- theme = "tomorrow_night",
				-- theme = "16color",
				theme = "base16",
				component_separators = "",
				-- section_separators = { left = "", right = "" },
				-- section_separators = { left = "", right = "" },
				-- section_separators = { left = "", right = "" },
				section_separators = "",
				disabled_filetypes = {
					"alpha",
					"dashboard",
					"NvimTree",
					"toggleterm",
				},
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { { "branch", icon = "" } },
				lualine_b = { "mode" },
				-- lualine_c = { diagnostics },
				lualine_c = { { "filename", path = 0, file_status = true } },
				lualine_x = {
					-- { "diff",
					--   colored = true,
					--   symbols = { added = " ", modified = " ", removed = " " }
					-- },
					"fileformat",
					"filetype",
					"encoding"
				},
				lualine_y = { progress },
				-- lualine_z = { "location" },
				lualine_z = {
					"location"
					-- function()
					-- 	return string.format("%d|%d", vim.fn.line("."), vim.fn.line("$"))
					-- end
				}
			},
			extensions = { "nvim-tree" },
		}
	end,
	config = function(_, opts)
		require("lualine").setup(opts)
		-- Optional transparency fix (works better than per-component overrides)
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
	end
}
