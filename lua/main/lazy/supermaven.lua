-- lua/plugins/supermaven.lua

return {
	"supermaven-inc/supermaven-nvim",
	event = "VeryLazy",
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<C-y>",
				clear_suggestion = "<C-]>",
				accept_word = "<C-j>",
			},
			color = {
				suggestion_color = "#888888", -- The subtle grey for the "ghost" effect
				cterm = 245,
			},
		})

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			command = "highlight SupermavenSuggestion guifg=#888888 ctermfg=245",
		})

		local suggestion = require("supermaven-nvim.completion_preview")

		local function toggle_inline_ai()
			if suggestion.disable_inline_completion then
				suggestion.disable_inline_completion = false
				vim.notify("Inline AI Autocompletion: ENABLED", vim.log.levels.INFO)
			else
				suggestion.disable_inline_completion = true
				vim.notify("Inline AI Autocompletion: DISABLED", vim.log.levels.INFO)
			end
		end

		vim.keymap.set("n", "<leader>cp", toggle_inline_ai, { desc = "Toggle Inline Ai Autocompletion" })
		vim.keymap.set("i", "<C-t>c", toggle_inline_ai, { desc = "Toggle Inline Ai Autocompletion" })
	end,
}
