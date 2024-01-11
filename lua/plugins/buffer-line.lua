-- tab 页插件
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
                    diagnostics = "coc",
                    numbers = function(opts)
                        return string.format('%s', opts.raise(opts.ordinal))
                    end,
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        local icon = level:match("error") and " " or " "
                        return " " .. icon .. count
                    end,
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
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
