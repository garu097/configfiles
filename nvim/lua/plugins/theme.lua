return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato", -- Hoặc một flavor hợp lệ: latte, frappe, macchiato, mocha
        transparent_background = true,
        styles = {
            comments = { "italic" },
            keywords = { "bold" },
        },
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}

