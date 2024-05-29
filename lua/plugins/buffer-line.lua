-- tab 页插件
local keymap = require("keymap")

keymap.map2cmd("n", keymap.close_current_tab, "<cmd>Bdelete<CR>")
keymap.map2cmd("n", keymap.goto_file_explorer, "<cmd>NvimTreeFocus<CR>")
keymap.map2cmd("n", keymap.goto_tab1, "<cmd>BufferLineGoToBuffer 1<CR>")
keymap.map2cmd("n", keymap.goto_tab2, "<cmd>BufferLineGoToBuffer 2<CR>")
keymap.map2cmd("n", keymap.goto_tab3, "<cmd>BufferLineGoToBuffer 3<CR>")
keymap.map2cmd("n", keymap.goto_tab4, "<cmd>BufferLineGoToBuffer 4<CR>")
keymap.map2cmd("n", keymap.goto_tab5, "<cmd>BufferLineGoToBuffer 5<CR>")
keymap.map2cmd("n", keymap.goto_tab6, "<cmd>BufferLineGoToBuffer 6<CR>")
keymap.map2cmd("n", keymap.goto_left_tab, "<cmd>BufferLineCyclePrev<CR>")
keymap.map2cmd("n", keymap.goto_right_tab, "<cmd>BufferLineCycleNext<CR>")

local function active_all_tab()
    local init = vim.api.nvim_get_current_buf()
    local not_finish = true
    while not_finish do
        vim.cmd("BufferLineCycleNext")
        local next = vim.api.nvim_get_current_buf()
        if next == init then
            not_finish = false
        end
    end
end

-- auto-session 恢复后, 之前打开过的 buffer 不会进入活跃状态
-- 导致 BufferLineCloseOthers 无法清理
-- 因此这里手动遍历激活后再执行 Close 操作
-- BufferLineCloseLeft 和 BufferLineCloseRight 同理
keymap.map2fun("n", keymap.close_other_tab, function()
    active_all_tab()
    vim.cmd('BufferLineCloseOthers')
end)

keymap.map2fun("n", keymap.close_left_tab, function()
    active_all_tab()
    vim.cmd('BufferLineCloseLeft')
end)

keymap.map2fun("n", keymap.close_right_tab, function()
    active_all_tab()
    vim.cmd('BufferLineCloseRight')
end)


return {
    {
        os.getenv("ghproxy") .. "https://github.com/akinsho/bufferline.nvim.git",
        version = "*",
        dependencies = {
            { os.getenv("ghproxy") .. "https://github.com/nvim-tree/nvim-web-devicons.git" },
            { os.getenv("ghproxy") .. "https://github.com/famiu/bufdelete.nvim.git" },
        },
        config = function()
            local buf_del = require("bufdelete")
            require("bufferline").setup({
                options = {
                    close_if_last_window = false,
                    separator_style = "slant",
                    buffer_close_icon = '',
                    diagnostics = "nvim_lsp",
                    numbers = function(opts)
                        local state = require("bufferline.state")
                        for i, buf in ipairs(state.visible_components) do
                            if buf.id == opts.id then
                                return string.format('%s', i)
                            end
                        end
                        return string.format('%s', opts.raise(opts.ordinal))
                    end,
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        local icon = level:match("error") and " " or " "
                        return " " .. icon .. count
                    end,
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = " File Explorer",
                            text_align = "left",
                            separator = true,
                        }
                    },
                    right_mouse_command = "",
                    close_command = function(buf_num)
                        buf_del.bufdelete(buf_num, true)
                    end
                },
            })
        end
    }
}
