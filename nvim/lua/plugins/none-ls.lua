return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"jay-babu/mason-null-ls.nvim", -- cầu nối Mason <-> none-ls
            "nvimtools/none-ls-extras.nvim",
		},
		config = function()
			local null_ls = require("null-ls")

			require("mason-null-ls").setup({
				ensure_installed = {
					"eslint_d",
					"prettier",
					"stylua",
					"black",
					"isort",
					"mypy",
					--"gofumpt",
				},
				automatic_installation = true,
			})

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.isort,
					null_ls.builtins.diagnostics.mypy,
					require("none-ls.diagnostics.eslint"),
					--null_ls.builtins.formatting.gofumpt,
				},
			})

            vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
}
