return {
  "norcalli/nvim-colorizer.lua", -- Note: Correct repo is "norcalli/nvim-colorizer.lua"
  event = "BufReadPre",
  config = function()
    require("colorizer").setup({ "*" }, {
      RGB = true,        -- #RGB hex codes
      RRGGBB = true,     -- #RRGGBB hex codes
      names = false,     -- "Name" codes like Blue
      RRGGBBAA = true,   -- #RRGGBBAA hex codes
      rgb_fn = true,     -- CSS rgb() and rgba() functions
      hsl_fn = true,     -- CSS hsl() and hsla() functions
      css = true,        -- Enable all CSS features
      css_fn = true,     -- Enable all CSS *functions*
      -- Additional options:
      mode = "background", -- Set display mode (foreground/background)
      virtualtext = "■",  -- Show color preview in virtualtext
    })
  end
}
