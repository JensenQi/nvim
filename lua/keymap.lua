
local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true }

map("n", "<Space>", "", opt) -- 关闭空格键的移动, 仅作为 Leader 键

map("n", "gh", "0", opt)
map("n", "ge", "$", opt)

map("v", "v", "<Plug>(expand_region_expand)", opt)
map("v", "V", "<Plug>(expand_region_shrink)", opt)

map("n", "<C-e>", "<C-w>w", opt)
