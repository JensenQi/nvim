--
local keymap = require('keymap')

keymap.map2fun('n', keymap.goto_next_problem, vim.diagnostic.goto_next)
keymap.map2cmd('n', keymap.goto_definition, '<CMD>Lspsaga goto_definition<CR>')
keymap.map2cmd('n', keymap.go_back, "<C-t>")
keymap.map2cmd('n', keymap.goto_class_definition, '<CMD>Lspsaga goto_type_definition<CR>')
keymap.map2cmd('n', keymap.goto_preview, '<CMD>Lspsaga peek_definition<CR>')
keymap.map2cmd('n', keymap.find_usage, '<CMD>Lspsaga finder<CR>')
keymap.map2cmd('n', keymap.find_implement, '<CMD>Lspsaga finder imp<CR>')
keymap.map2cmd('n', keymap.code_action, "<CMD>Lspsaga code_action<CR>")
keymap.map2cmd('n', keymap.refactor_name, "<CMD>Lspsaga rename<CR>")
keymap.map2fun('n', keymap.format_file, function() vim.lsp.buf.format({ async = true }) end)

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
                        quit = keymap.close_find_usage,
                        edit = keymap.usage_jump,
                        shuttle = keymap.usage_edit
                    }
                },
                definition = { -- 定义跳转 & 快速预览
                    keys = {
                        close = keymap.close_preview
                    }
                },
                implement = { -- 继承数 hint
                    enable = true,
                    virtual_text = true,
                    sign = true,
                },
                code_action = { -- 修复建议
                    keys = {
                        quit = keymap.close_code_action,
                        exec = keymap.code_action_confirm
                    }
                },
                rename = { -- 名称重构
                    keys = {
                        quit = keymap.close_refactor,
                        exec = keymap.refactor_confirm
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

