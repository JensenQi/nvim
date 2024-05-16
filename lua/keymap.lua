local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

map("n", "<Space>", "", opt) -- 关闭空格键的移动, 仅作为 Leader 键
map("n", "j", "gj", opt)
map("n", "k", "gk", opt)
map("n", "$", "g$", opt)
map("n", "0", "g0", opt)

-- tab 切换
map("n", "<Leader><backspace>", "<cmd>Bdelete<CR>", opt)                               -- 关闭 Tab
map("n", "<Leader>`", "<cmd>NvimTreeFocus<CR>", opt)                                   -- 切换到文件管理 Tab
map("n", "<Leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", opt)                          -- 切换到第一个 Tab
map("n", "<Leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", opt)                          -- 切换到第二个 Tab
map("n", "<Leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", opt)                          -- 切换到第三个 Tab
map("n", "<Leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", opt)                          -- 切换到第四个 Tab
map("n", "<Leader>5", "<cmd>BufferLineGoToBuffer 5<CR>", opt)                          -- 切换到第五个 Tab
map("n", "<Leader>6", "<cmd>BufferLineGoToBuffer 6<CR>", opt)                          -- 切换到第六个 Tab
map("n", "<Leader>h", "<cmd>BufferLineCyclePrev<CR>", opt)                             -- 切换到上一个 Tab
map("n", "<Leader>l", "<cmd>BufferLineCycleNext<CR>", opt)                             -- 切换到下一个 Tab
map("n", "<Leader><left>", "<cmd>BufferLineCloseLeft<CR>", opt)                        -- 关闭左边的所有 Tab
map("n", "<Leader><right>", "<cmd>BufferLineCloseRight<CR>", opt)                      -- 关闭右边的所有 Tab
map("n", "<Leader><down>", "<cmd>BufferLineCloseOthers<CR>", opt)                      -- 关闭其他所有 Tab
map("n", "<leader>v", "<CMD>BlameToggle<CR>", opt)                                     -- 打开 git blame 侧栏

map("n", "<esc>p", "<CMD>Telescope commander<CR>", opt)                                -- 打开命令面板
map("n", "<esc>o", "<CMD>Telescope find_files<CR>", opt)                               -- 打开文件
map("n", "<esc>h", "<CMD>Telescope file_history history initial_mode=normal<CR>", opt) -- 打开文件历史

vim.keymap.set('n', '<A-n>', vim.diagnostic.goto_next, opt)
map('n', 'gd', '<CMD>Lspsaga goto_definition<CR>', opt)
map("n", "gb", "<C-t>", opt)
map('n', 'gc', '<CMD>Lspsaga goto_type_definition<CR>', opt)
map('n', 'gp', '<CMD>Lspsaga peek_definition<CR>', opt)
map('n', 'gu', '<CMD>Lspsaga finder<CR>', opt)
map('n', 'gi', '<CMD>Lspsaga finder imp<CR>', opt)
map('n', '<A-Enter>', "<CMD>Lspsaga code_action<CR>", opt)
map('n', '<s-F6>', "<CMD>Lspsaga rename<CR>", opt)

vim.keymap.set("n", "<C-A-L>", function() vim.lsp.buf.format({ async = true }) end, opt)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opt)
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opt)

map("n", "gv", '<CMD>Gitsigns preview_hunk_inline<CR>', { silent = true })                 -- git 变更预览

map("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)j", opt) -- 快速注释当前行并移动到下一行
map("v", "<C-_>", "<Plug>(comment_toggle_linewise_visual)", opt)   -- 快速注释选中块

map("v", "v", "<Plug>(expand_region_expand)", opt)                 -- 扩大选择块
map("v", "V", "<Plug>(expand_region_shrink)", opt)                 -- 缩小s选择块

map('n', '<C-e>', '<C-w>w', opt)                                   -- File Explorer 与 Editor 切换
map("n", "<A-f>", "/", opt)                                        -- 页面内关键词查找
map("n", "<C-F>", ":Telescope live_grep<CR>", opt)                 -- 全局关键词查找

map("n", "qq", '<CMD>wqall<CR>', opt)

