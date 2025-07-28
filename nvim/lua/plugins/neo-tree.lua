return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- Optional image support for file preview: See `# Preview Mode` for more information.
    -- {"3rd/image.nvim", opts = {}},
    -- OR use snacks.nvim's image module:
    -- "folke/snacks.nvim",
    },
    lazy = false, -- neo-tree will lazily load itself
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
        close_if_last_window = false,
        enable_diagnostics = true,
        enable_git_status = true,
        popup_border_style = "rounded",
        sort_case_insensitive = false,
        filesystem = {
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignored =false,
            }
        }
    -- add options here
    },
    config = function()
		-- key map for neo tree
		vim.keymap.set("n", "<leader>v", ":Neotree filesystem reveal left<CR>", {})
		vim.keymap.set("n", "<leader>xx", ":Neotree filesystem close <CR>", {})
	end,
}
