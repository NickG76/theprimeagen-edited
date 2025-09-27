vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<M-h>", "<cmd>silent !tmux-sessionizer -s 0 --vsplit<CR>")
vim.keymap.set("n", "<M-H>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set(
    "n",
    "<leader>ea",
    "oassert.NoError(err, \"\")<Esc>F\";a"
)

vim.keymap.set(
    "n",
    "<leader>ef",
    "oif err != nil {<CR>}<Esc>Olog.Fatalf(\"error: %s\\n\", err.Error())<Esc>jj"
)

vim.keymap.set(
    "n",
    "<leader>el",
    "oif err != nil {<CR>}<Esc>O.logger.Error(\"error\", \"error\", err)<Esc>F.;i"
)

vim.keymap.set("n", "<leader>ca", function()
    require("cellular-automaton").start_animation("make_it_rain")
end)

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- close windows
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Close window" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa<CR>", { desc = "Close all windows" })
vim.keymap.set("n", "<leader>QQ", "<cmd>q!<CR>", { desc = "Force quit all" })

vim.keymap.set("n", "<C-a>", "ggVG")
vim.keymap.set({"n","v"}, "<leader>w", function()
    vim.cmd(":w")
end)

-- cloak toggle
local cloak_enabled = true
vim.keymap.set("n", "<leader>cl", function()
    if cloak_enabled then
        vim.cmd("CloakDisable")
        vim.notify("Cloak Disabled", vim.log.levels.INFO)
    else
        vim.cmd("CloakEnable")
        vim.notify("Cloak Enabled", vim.log.levels.INFO)
    end
    cloak_enabled = not cloak_enabled
end, { desc = "Toggle Cloak", noremap = true, silent = true })

-- replace in file
vim.keymap.set("n", "<leader>r", ":%s/", { desc = "Replace in file", noremap = true, silent = false })

-- splits + explorer
vim.keymap.set("n", "<leader>sv", function()
    vim.cmd("vsplit")
    vim.cmd("wincmd l")
    vim.cmd("Ex")
end, { desc = "Vertical split + explorer" })

vim.keymap.set("n", "<leader>sh", function()
    vim.cmd("split")
    vim.cmd("wincmd j")
    vim.cmd("Ex")
end, { desc = "Horizontal split + explorer" })


-- exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- open terminal split
vim.keymap.set("n", "<leader>th", function()
    vim.cmd("belowright 15split")
    vim.cmd("terminal")
    vim.cmd("startinsert")
end, { desc = "Open terminal in horizontal split" })

