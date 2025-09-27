return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				lua = { "stylua" },
				go = { "gofmt" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				elixir = { "mix" },
				python = { "black" },
				rust = { "rustfmt" },
				sh = { "shfmt" },
				markdown = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				svelte = { "prettier" },
				vue = { "prettier" },
				sv = { "prettier" },
				php = { "prettier" },
				luau = { "stylua" },
				sql = { "sqlformat" },
			},
			formatters = {
				["clang-format"] = {
					prepend_args = { "-style=file", "-fallback-style=LLVM" },
				},
			},
		})

		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({ bufnr = 0 })
		end)
	end,
}
