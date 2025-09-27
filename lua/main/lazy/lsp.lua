-- lua/plugins/lsp.lua

local root_files = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" }

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		-- All your original setup code remains unchanged
		require("conform").setup({ formatters_by_ft = {} })
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())
		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "rust_analyzer", "gopls", "tailwindcss" },
			handlers = {
				function(server_name) require("lspconfig")[server_name].setup({ capabilities = capabilities }) end,
				-- Your other custom handlers...
				zls = function()
					local lspconfig = require("lspconfig")
					lspconfig.zls.setup({
						root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
						settings = { zls = { enable_inlay_hints = true, enable_snippets = true, warn_style = true } },
					})
				end,
				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = { Lua = { format = { enable = true, defaultConfig = { indent_style = "space", indent_size = "2" } } } },
					})
				end,
				["tailwindcss"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.tailwindcss.setup({
						capabilities = capabilities,
						filetypes = { "html", "css", "scss", "javascript", "typescript", "vue", "svelte", "heex" },
					})
				end,
			},
		})
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			-- THIS IS THE CRITICAL CHANGE TO KEEP THEM SEPARATE --
			experimental = {
				ghost_text = false,
			},
			-----------------------------------------------------
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
			}),
		})

		-- Your diagnostic config remains unchanged
		vim.diagnostic.config({
			float = { focusable = false, style = "minimal", border = "rounded", source = "always", header = "", prefix = "" },
		})
	end,
}
