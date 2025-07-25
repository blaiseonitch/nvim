return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" }, -- Lazy-load on file open
  config = function()
    require("lint").linters_by_ft = {
      python = { "flake8", "pylint" },
      javascript = { "eslint_d" },
      sh = { "shellcheck" },
      -- Add more filetypes as needed
    }

    -- Auto-trigger linting on save
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
