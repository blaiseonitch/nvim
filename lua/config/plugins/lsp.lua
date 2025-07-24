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
      local lspconfig = require("lspconfig")

      -- 👇 Lua LSP Setup
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT', -- for Neovim
            },
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
    end
  }
}

