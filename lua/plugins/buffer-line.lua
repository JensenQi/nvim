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
            local map = vim.api.nvim_set_keymap
            local opt = { noremap = true, silent = true }
            map("n", "<Leader>q", ":Bdelete<CR>", opt) -- 关闭 tab
            require("bufferline").setup({
                options = {
                    close_if_last_window = false,
                    separator_style = "slant",
                    modified_icon = '●',
                    buffer_close_icon = '',
                    close_icon = '',
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_align = "left",
                            separator = true,
                        }
                    },
                    background = {
                        fg = '#FFFFFF',
                        bg = '#000000'
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
