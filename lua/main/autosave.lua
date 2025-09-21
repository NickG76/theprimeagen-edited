-- Create a dedicated group to prevent duplicating the autocommand on reload
local auto_save_group = vim.api.nvim_create_augroup("MyAutoSave", { clear = true })

vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost" }, {
	group = auto_save_group,
	pattern = "*",
	desc = "Auto save buffer, ignoring certain filetypes",
	callback = function(event)
		-- List of filetypes to ignore for auto-saving
		local ignored_filetypes = { "harpoon", "gitcommit", "TelescopePrompt", "help" }

		local bufnr = event.buf
		local filetype = vim.bo[bufnr].filetype

		-- Conditions for saving:
		-- 1. The buffer is modifiable.
		-- 2. It has a file name (i.e., it's not a new, unnamed buffer).
		-- 3. Its filetype is NOT in our ignored list.
		if
			vim.bo[bufnr].modifiable
			and vim.api.nvim_buf_get_name(bufnr) ~= ""
			and not vim.tbl_contains(ignored_filetypes, filetype)
		then
			-- Using a delay to prevent saving too aggressively
			-- (Inside your callback function)

            vim.defer_fn(function()
                -- Final check that the buffer is still valid before writing
                if vim.api.nvim_buf_is_valid(bufnr) then
                    -- Execute the write command in the context of the correct buffer
                    vim.api.nvim_buf_call(bufnr, function()
                        -- CORRECTED LINE: Use the command string for simplicity and correctness.
                        vim.cmd('silent! w')
                    end)
                end
            end, 500)
		end
	end,
})
