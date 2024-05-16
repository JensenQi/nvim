--
return {
    {
        os.getenv("ghproxy") .. "https://github.com/nvimdev/lspsaga.nvim.git",
        version = "*",
        dependencies = {
            os.getenv("ghproxy") .. "https://github.com/nvim-treesitter/nvim-treesitter.git",
            os.getenv("ghproxy") .. "https://github.com/nvim-tree/nvim-web-devicons.git",
            os.getenv("ghproxy") .. "https://github.com/neovim/nvim-lspconfig.git",
        },
        config = function()
            vim.diagnostic.config({ virtual_text = false })
            -- require('lspconfig').setup({})

            require('lspsaga').setup({
                symbol_in_winbar = { -- 头部路径
                    enable = true,
                    hide_keyword = true,
                    folder_level = 3
                },
                finder = { -- 查找引用
                    keys = {
                        quit = '<esc><esc>',
                        edit = '<CR>',
                        shuttle = '<Tab>'
                    }
                },
                definition = { -- 定义跳转 & 快速预览
                    keys = {
                        close = '<esc><esc>',
                    }
                },
                implement = { -- 继承数 hint
                    enable = true,
                    virtual_text = true,
                },
                code_action = { -- 修复建议
                    keys = {
                        quit = '<esc><esc>',
                        exec = '<CR>'
                    }
                },
                rename = { -- 名称重构
                    keys = {
                        quit = '<esc><esc>',
                        exec = '<CR>'
                    }
                },
                lightbulb = { -- 关闭灯泡
                    enable = false,
                    enable_in_insert = false,
                    sign = false,
                    sign_priority = 40,
                    virtual_text = false,
                },
            })
        end
    }
}

