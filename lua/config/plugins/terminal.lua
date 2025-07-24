return {
  {
    "numToStr/FTerm.nvim",
    config = function()
      require("FTerm").setup({
        blend = 10,
        dimensions = {
          height = 0.85,
          width = 0.85,
          x = 0.5,
          y = 0.5
        },
        border = 'rounded',
      })
    end,
    keys = {
      { "<A-i>", function() require("FTerm").toggle() end, desc = "Toggle FTerm" },
    },
  },
}

