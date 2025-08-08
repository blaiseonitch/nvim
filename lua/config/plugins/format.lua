return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local none_ls = require("null-ls")
		local formatting = none_ls.builtins.formatting

		none_ls.setup({
			sources = {
				formatting.prettier.with({
					filetypes = { "html", "css", "javascript", "typescript", "json", "markdown" },
				}),

				formatting.clang_format.with({
					filetypes = { "c", "cpp", "objc", "objcpp" },
				}),

				formatting.csharpier.with({
					filetypes = { "cs" },
					command = "csharpier",
				}),
			},
		})
	end,
}
