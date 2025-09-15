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
				ensure_installed = {
					"lua_ls", "pyright", "clangd",
					"marksman", "ts_ls", "cmake", "html", "cssls", "omnisharp", "jdtls"
				},
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
							version = 'LuaJIT',
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
					}
				}
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
				capabilities = capabilities,
				on_attach = function(client, bufnr)
				end,
			})

			-- Python LSP Setup
			lspconfig.pyright.setup({
				capabilities = capabilities,
				settings = {
					python = {
						pythonPath = vim.fn.exepath("python3"),
					}
				}
			})

			lspconfig.emmet_ls.setup({
				capabilities = capabilities,
				filetypes = {
					"html", "css", "javascript", "javascriptreact", "typescript", 'typescriptreact'
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

			lspconfig.jsonls.setup({ capabilities = capabilities })
			lspconfig.eslint.setup({ capabilities = capabilities })
			lspconfig.marksman.setup({ capabilities = capabilities })
			lspconfig.ts_ls.setup({ capabilities = capabilities })
			lspconfig.cmake.setup({ capabilities = capabilities })
			lspconfig.html.setup({ capabilities = capabilities })
			lspconfig.cssls.setup({ capabilities = capabilities })
			lspconfig.glsl_analyzer.setup({ capabilities = capabilities })
		end
	}
}
