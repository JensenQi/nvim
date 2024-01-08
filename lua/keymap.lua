
local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true }

map("n", "<Space>", "", opt) -- 关闭空格键的移动, 仅作为 Leader 键

map("n", "gh", "0", opt)
map("n", "ge", "$", opt)

map("v", "v", "<Plug>(expand_region_expand)", opt) -- 扩大选择块
map("v", "V", "<Plug>(expand_region_shrink)", opt) -- 缩小s选择块

map("n", "<C-e>", "<C-w>w", opt) -- File Explorer 与 Editor 切换 

map("n", "<A-f>", "/", opt) -- 页面内关键词查找
map("n", "<C-F>", ":Telescope live_grep<CR>", opt) -- 全局关键词查找
map("n", "<C-o>", ":Telescope find_files<CR>", opt) -- 全局文件查找

map("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)j", opt) -- 快速注释当前行并移动到下一行
map("v", "<C-_>", "<Plug>(comment_toggle_linewise_visual)", opt) -- 快速注释选中块
