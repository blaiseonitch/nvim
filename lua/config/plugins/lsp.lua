return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"marksman",
					"ts_ls",
					"cmake",
					"html",
					"cssls",
					"omnisharp",
					"jdtls",
				},
				automatic_installation = true,
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = vim.lsp.config

			-- Lua LSP Setup
			lspconfig("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			-- VCPKG  setup
			local function get_vcpkg_includes()
				local vcpkg_root = os.getenv("VCPKG_ROOT") or os.getenv("HOME") .. "/vcpkg"
				local triplet = os.getenv("VCPKG_DEFAULT_TRIPLET") or "x64-linux"
				return {
					"-I" .. vcpkg_root .. "/installed/" .. triplet .. "/include",
				}
			end

			-- C/C++ LSP Setup
			lspconfig("clangd", {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--enable-config",
				},
				init_options = {
					fallbackFlags = get_vcpkg_includes(),
				},
				capabilities = capabilities,
				on_attach = function(client, bufnr) end,
			})

			-- Python LSP Setup
			lspconfig("pyright", {
				capabilities = capabilities,
				settings = {
					python = {
						pythonPath = vim.fn.exepath("python3"),
					},
				},
			})

			lspconfig("emmet_ls", {
				capabilities = capabilities,
				filetypes = {
					"html",
					"css",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
				init_options = {
					html = {
						options = {
							["bem.enabled"] = true,
							["jsx.enabled"] = true,
						},
					},
				},
			})

			lspconfig("jsonls", { capabilities = capabilities })
			lspconfig("eslint", { capabilities = capabilities })
			lspconfig("marksman", { capabilities = capabilities })
			lspconfig("ts_ls", { capabilities = capabilities })
			lspconfig("cmake", { capabilities = capabilities })
			lspconfig("html", { capabilities = capabilities })
			lspconfig("cssls", { capabilities = capabilities })
			lspconfig("glsl_analyzer", { capabilities = capabilities })
		end,
	},
}
