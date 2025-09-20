return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = function(term)
				if term.direction == "horizontal" then
					return 5
				elseif term.direction == "vertical" then
					return 5
				end
				-- elseif term.direction == "vertical" then
					-- return math.floor(vim.o.columns * 0.5)
				-- end
			end,
			open_mapping = false,
			hide_numbers = true,
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			persist_mode = true,
			direction = "horizontal",
			close_on_exit = true,
			shell = vim.o.shell,
			auto_scroll = true,
		})

		-- keep track of terminal count for splitting
		local terminal_count = 0

		-- function to create/toggle terminals with splitting behavior
		function _G.smart_toggle_term(direction, size)
			direction = direction or "horizontal"
			size = size or (direction == "horizontal" and 5 or 5)

			-- check if we're currently in a terminal
			if vim.bo.buftype == "terminal" then
				-- we're in a terminal, create a new one (this will split)
				terminal_count = terminal_count + 1
				vim.cmd(string.format("ToggleTerm %d size=%d direction=%s", terminal_count, size, direction))
			else
				-- Not in terminal, check if any terminal is open
				local term_wins = {}
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					if vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
						table.insert(term_wins, win)
					end
				end

				if #term_wins > 0 then
					-- Terminal exists, create new one (will split)
					terminal_count = terminal_count + 1
					vim.cmd(string.format("ToggleTerm %d size=%d direction=%s", terminal_count, size, direction))
				else
					-- No terminal open, create first one
					terminal_count = 1
					vim.cmd(string.format("ToggleTerm %d size=%d direction=%s", terminal_count, size, direction))
				end
			end
		end

	end,
	keys = {
		-- Smart toggle (creates new if in terminal, toggles if not)
		{ "<A-h>",      "<cmd>lua smart_toggle_term('horizontal', 5)<cr>", desc = "Smart Horizontal Terminal" },
		{ "<A-v>",      "<cmd>lua smart_toggle_term('vertical', 25)<cr>",   desc = "Smart Vertical Terminal" },
		{ "<A-f>",      "<cmd>lua smart_toggle_term('float')<cr>",         desc = "Smart Float Terminal" },

		-- Toggle specific terminals
		{ "<leader>t1", "<cmd>1ToggleTerm<cr>",                            desc = "Toggle Terminal 1" },
		{ "<leader>t2", "<cmd>2ToggleTerm<cr>",                            desc = "Toggle Terminal 2" },
	},
}
