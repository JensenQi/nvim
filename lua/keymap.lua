local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }
local coc_opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }

map("n", "<Space>", "", opt) -- 关闭空格键的移动, 仅作为 Leader 键


-- tab 切换
map("n", "<Leader><backspace>", "<cmd>Bdelete<CR>", opt)          -- 关闭 Tab
map("n", "<Leader>`", "<cmd>NvimTreeFocus<CR>", opt)              -- 切换到文件管理 Tab
map("n", "<Leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", opt)     -- 切换到第一个 Tab
map("n", "<Leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", opt)     -- 切换到第二个 Tab
map("n", "<Leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", opt)     -- 切换到第三个 Tab
map("n", "<Leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", opt)     -- 切换到第四个 Tab
map("n", "<Leader>5", "<cmd>BufferLineGoToBuffer 5<CR>", opt)     -- 切换到第五个 Tab
map("n", "<Leader>6", "<cmd>BufferLineGoToBuffer 6<CR>", opt)     -- 切换到第六个 Tab
map("n", "<Leader>h", "<cmd>BufferLineCyclePrev<CR>", opt)        -- 切换到上一个 Tab
map("n", "<Leader>l", "<cmd>BufferLineCycleNext<CR>", opt)        -- 切换到下一个 Tab
map("n", "<Leader><left>", "<cmd>BufferLineCloseLeft<CR>", opt)   -- 关闭左边的所有 Tab
map("n", "<Leader><right>", "<cmd>BufferLineCloseRight<CR>", opt) -- 关闭右边的所有 Tab
map("n", "<Leader><down>", "<cmd>BufferLineCloseOthers<CR>", opt) -- 关闭其他所有 Tab

map("n", "<esc>p", "<CMD>Telescope commander<CR>", opt)            -- 打开终端
map("n", "<esc>o", ":Telescope find_files<CR>", opt)             -- 打开文件

map("i", "<TAB>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], coc_opts)
map("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], coc_opts)
map("n", "gd", "<C-]>", { silent = true })                                                 -- 跳入定义 define
map("n", "gb", "<C-t>", {})                                                                -- 回退 back
map("n", "gu", "<Plug>(coc-references)", { silent = true })                                -- 查看引用(use)
map("n", "gi", "<Plug>(coc-implementation)", { silent = true })                            -- 查看实现(Implementation)
map("n", "gc", "<Plug>(coc-type-definition)", { silent = true })                           -- 查看类声明(class)
map("n", "gp", '<CMD>lua _G.show_docs()<CR>', { silent = true })                           -- 文档预览(preview)
map("n", "<A-n>", "<Plug>(coc-diagnostic-next)", { silent = true })                        -- 查看下一个异常(next)
map("n", "<C-A-L>", "<Plug>(coc-format)<CR>", { silent = true })                           --格式化
map("i", "<C-A-L>", "<cmd>CocCommand editor.action.formatDocument<CR>", { silent = true }) --格式化
map("n", "<A-Enter>", "<Plug>(coc-codeaction-cursor)", opt)                                -- 修复建议
map("i", "<A-Enter>", "<Plug>(coc-codeaction-cursor)", opt)


map("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)j", opt) -- 快速注释当前行并移动到下一行
map("v", "<C-_>", "<Plug>(comment_toggle_linewise_visual)", opt)   -- 快速注释选中块

map("v", "v", "<Plug>(expand_region_expand)", opt)                 -- 扩大选择块
map("v", "V", "<Plug>(expand_region_shrink)", opt)                 -- 缩小s选择块

map('n', '<C-e>', '<C-w>w', opt)     -- File Explorer 与 Editor 切换

map("n", "<A-f>", "/", opt)                                      -- 页面内关键词查找
map("n", "<C-F>", ":Telescope live_grep<CR>", opt)               -- 全局关键词查找
