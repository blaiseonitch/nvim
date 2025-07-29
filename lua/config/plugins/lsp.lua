return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = true
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" }, -- auto install
			})
		end
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")

			-- Lua LSP Setup
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = 'LuaJIT', },
						diagnostics = {
							globals = { 'vim' }, -- stops "vim is undefined" errors
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					}
				}
			})

			local function get_vcpkg_includes()
				local vcpkg_root = os.getenv("VCPKG_ROOT") or os.getenv("HOME") .. "/vcpkg"
				local triplet = os.getenv("VCPKG_DEFAULT_TRIPLET") or "x64-linux"
				return {
					"-I" .. vcpkg_root .. "/installed/" .. triplet .. "/include",
				}
			end

			lspconfig.clangd.setup({
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--enable-config",
				},
				init_options = {
					fallbackFlags = get_vcpkg_includes(),
				},
				capabilities = require("blink.cmp").get_lsp_capabilities(),
				on_attach = function(client, bufnr)
					-- optional keybinds
				end,
			})
		end

	}
}
