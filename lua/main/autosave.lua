-- Auto-save on certain events, ignoring specific filetypes
vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost" }, {
	pattern = "*",
	callback = function()
		-- Only save if the buffer is modifiable and not a harpoon buffer
		if vim.bo.modifiable and vim.bo.filetype ~= 'harpoon' then
            -- Using a slightly longer delay to avoid saving too aggressively
			vim.defer_fn(function()
				vim.cmd("silent! w")
			end, 500) -- Delay of 500ms (half a second)
		end
	end,
})
