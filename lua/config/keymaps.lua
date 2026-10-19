-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

---@param modes string|string[]
---@param lhs string
---@param rhs string
---@param desc string
---@param opts vim.keymap.set.Opts?
local map = function (modes, lhs, rhs, desc, opts)
  ---@type vim.keymap.set.Opts
  local options = opts or {}
  options.desc = desc
  vim.keymap.set(modes, lhs, rhs, options)
end

-- INSERT enter SELECT using Shift
vim.keymap.set("i", "<S-Left>",  "<Esc>gh",             { desc = "Select Left" })
vim.keymap.set("i", "<S-Right>", "<C-o>gh",             { desc = "Select Right" })
vim.keymap.set("i", "<S-Up>",    "<Esc>gh<Up><Right>",  { desc = "Select Up" })
vim.keymap.set("i", "<S-Down>",  "<C-o>gh<Down><Left>", { desc = "Select Down" })
vim.keymap.set("i", "<S-Home>",  "<Esc>gh<Home>",       { desc = "Select Home" })
vim.keymap.set("i", "<S-End>",   "<C-o>gh<End>",        { desc = "Select End" })
-- SELECT extend select with Shift
vim.keymap.set("s", "<S-Left>",  "<Left>",              { desc = "Extend Selection Left" })
vim.keymap.set("s", "<S-Right>", "<Right>",             { desc = "Extend Selection Right" })
vim.keymap.set("s", "<S-Up>",    "<Up>",                { desc = "Extend Selection Up" })
vim.keymap.set("s", "<S-Down>",  "<Down>",              { desc = "Extend Selection Down" })
vim.keymap.set("s", "<S-Home>",  "<Home>",              { desc = "Extend Selection Home" })
vim.keymap.set("s", "<S-End>",   "<End>",               { desc = "Extend Selection End" })
--- Unselect when no Shift
vim.keymap.set("s", "<Left>",    "<Esc>i<Left>",        { desc = "Unselect Move Left" })
vim.keymap.set("s", "<Right>",   "<Esc>i<Right>",       { desc = "Unselect Move Right" })
vim.keymap.set("s", "<Up>",      "<Esc>i<Up>",          { desc = "Unselect Move Up" })
vim.keymap.set("s", "<Down>",    "<Esc>i<Down>",        { desc = "Unselect Move Down" })
vim.keymap.set("s", "<Home>",    "<Esc>i<Home>",        { desc = "Unselect Move Home" })
vim.keymap.set("s", "<End>",     "<Esc>i<End>",         { desc = "Unselect Move End" })
--- SELECT patct for deletion
vim.keymap.set("s", "<BS>", "<C-o>\"_c",                   { desc = "Delete Selection to Insert" })
vim.keymap.set("s", "<Del>", "<C-o>\"_c",                  { desc = "Delete Selection to Insert" })

-- Save File
map("i", "<C-s>", "<Esc>:w<CR>a", "Save file")

-- Undo
map("i", "<C-z>", "<C-o>u", "Undo")
-- Redo
map("i", "<C-S-z>", "<C-o><C-r>", "Redo")
map("i", "<C-y>",   "<C-o><C-r>", "Redo")

-- Cut
map("s", "<C-x>", "<C-o>\"+di", "Cut Selection")
-- Copy
map("s", "<C-c>", "<C-o>\"+ygv<C-g>", "Copy Selection")
-- Paste
map("s", "<C-v>", "<C-o>\"_c<C-r>+", "Paste Replace Selection")
map("i", "<C-v>", "<C-r>+", "Paste Clipboard")


-- Move Line Down
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", "Move line down")
map("i", "<C-Down>", "<Esc>:m .+1<CR>==gi", "Move line down")
-- Move Line Up
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", "Move line up")
map("i", "<C-Up>", "<Esc>:m .-2<CR>==gi", "Move line up")

-- Copy Line Down
map("i", "<A-S-Down>", "<Esc>yypgi<Down>", "Duplicate line down")
-- Copy Line Up
map("i", "<A-S-Up>", "<Esc>yykpgi<Up>", "Duplicate line up")
-- Delete Line
map("i", "<C-S-k>", "<C-o>dd", "Delete line")

---=== Comment ===---

map({"n","i"}, "<C-/>", "<cmd>normal gcc<CR><Down>", "Toggle Comment")
map({"n","i"}, "<C-_>", "<cmd>normal gcc<CR><Down>", "Toggle Comment")
map("i",       "<A-/>", "<cmd>normal gcc<CR><Down>", "Toggle Comment")
map("v",       "<C-/>", "gc",                        "Toggle Comment", { remap = true })
map("v",       "<C-_>", "gc",                        "Toggle Comment", { remap = true })
map("s",       "<C-/>", "<C-o>gc",                   "Toggle Comment", { remap = true })
map("s",       "<C-_>", "<C-o>gc",                   "Toggle Comment", { remap = true })
map("s",       "<A-/>", "<C-o>gc",                   "Toggle Comment", { remap = true })

---=== Symbol Rename ===---

vim.keymap.set({ "n" }, "<F2>", " cr",      { remap = true, desc = "Rename Symbol (inc-rename)" })
vim.keymap.set({ "i" }, "<F2>", "<C-o> cr", { remap = true, desc = "Rename Symbol (inc-rename)" })

---=== Auto Fill Patch ===---

--- for vim vanilla only
-- vim.keymap.set("i", "<Esc>", function()
--   if vim.fn.pumvisible() == 1 then
--     return "<C-e>" -- Close auto fill without exit INSERT mode
--   else
--     return "<Esc>"
--   end
-- end, { expr = true, silent = true, desc = "Close cmp menu or exit insert mode" })
