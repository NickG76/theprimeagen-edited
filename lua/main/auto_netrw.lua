--[[
  This script sets up an autocommand to enable line numbers
  and automatically open netrw under certain conditions.
--]]

-- Create a dedicated autocommand group to keep our config organized.
-- The `clear = true` option ensures that the autocommands are not duplicated
-- if you reload your configuration multiple times.
-- local netrw_augroup = vim.api.nvim_create_augroup('NetrwCustomizations', { clear = true })
--
-- Create an autocommand that triggers whenever a file of type 'netrw' is opened.
vim.api.nvim_create_autocmd('FileType', {
  group = netrw_augroup,
  pattern = 'netrw',
  desc = 'Enable relative line numbers in netrw',
  callback = function()
    -- Set window-local options for the netrw buffer.
    -- Using `vim.wo` ensures this only affects the current window.
    vim.wo.relativenumber = true
  end,
})

-- Automatically open netrw when Neovim is opened in a directory.
vim.api.nvim_create_autocmd('VimEnter', {
  group = netrw_augroup,
  pattern = '*',
  nested = true,
  desc = 'Open netrw if nvim is opened in a directory',
  callback = function()
    -- Check if no file was opened as an argument
    if vim.fn.argc() == 0 then
      -- Check if the current buffer is empty and unmodified
      if vim.fn.bufname() == '' and not vim.bo.modified then
        -- Open the file explorer
        vim.cmd.Explore()
      end
    end
  end,
})



