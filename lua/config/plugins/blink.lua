return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",
	opts = {
		keymap = {
			["<CR>"] = { "accept", "fallback" }, -- Enter confirms suggestion
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<C-e>"] = { "hide", "fallback" }, -- Escape
		},

		appearance = {
			nerd_font_variant = "mono",
		},
		completion = { documentation = { auto_show = true } },

		sources = {
			-- default = { 'lsp', 'path', 'snippets', 'buffer' },
			default = { "lsp", "path", "buffer" },
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
