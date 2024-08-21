-- LSP UI 美化
local keymap = require('keymap')

local function remapKeySaga()
    -- 部分语言建立 LSP 后在索引完成前, 调用 lspsaga 的命令会因没有结果返回而导致后续命令无法调度
    -- 这里提供 remap key sega 用于 LSP 建立索引后回调设置键位
    keymap.map2cmd('n', keymap.goto_definition, '<CMD>Lspsaga goto_definition<CR>')
    keymap.map2cmd('n', keymap.goto_class_definition, '<CMD>Lspsaga goto_type_definition<CR>')
    keymap.map2cmd('n', keymap.goto_preview, '<CMD>Lspsaga peek_definition<CR>')
    keymap.map2cmd('n', keymap.find_usage, '<CMD>Lspsaga finder ref<CR>')
    keymap.map2cmd('n', keymap.find_implement, '<CMD>Lspsaga finder imp<CR>')
    keymap.map2cmd('n', keymap.code_action, "<cmd>Lspsaga code_action<cr>")
    keymap.map2fun('n', keymap.refactor_name, function()
        -- lspsaga 会触发 cmp 导致冲突, 因此这里用原生的 lsp rename
        -- 短期内 rename 两次会因缓冲区没有 flush 导致 rename 失败
        -- 所以这里先将缓冲区 flush 后在发起 rename 操作
        vim.cmd("silent! write")
        vim.lsp.buf.rename()
    end)
    keymap.map2fun('n', keymap.goto_next_problem, vim.diagnostic.goto_next)
    keymap.map2cmd('n', keymap.go_back, "<C-t>")
    keymap.map2fun('n', keymap.format_file, function() vim.lsp.buf.format({ async = true }) end)

    vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format({ async = true }) end, {})
end

return {
    {
        os.getenv("ghproxy") .. "https://github.com/nvimdev/lspsaga.nvim.git",
        version = "*",
        dependencies = {
            os.getenv("ghproxy") .. "https://github.com/nvim-treesitter/nvim-treesitter.git",
            os.getenv("ghproxy") .. "https://github.com/nvim-tree/nvim-web-devicons.git",
            os.getenv("ghproxy") .. "https://github.com/neovim/nvim-lspconfig.git",
            os.getenv("ghproxy") .. "https://github.com/j-hui/fidget.nvim.git",
        },
        config = function()
            if _G.PROJECT_TYPE == nil then -- 非项目工程则不启动 lspsaga
                return
            end

            vim.diagnostic.config({ virtual_text = false })
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

            -- 下面这几类项目的 LSP 启动后需要建立索引后才能执行后续操作
            -- 因此需要监控 LSP 的索引 progress 状态，所以完毕后再 remap 快捷键
            local ready_signal = {
                scala = "Indexing",
                rust = "Roots Scanned",
                java = "Publish Diagnostics",
                lua = "Loading workspace",
                typescript = "Initializing JS/TS language features…",
            }
            require("fidget").setup({
                progress = {
                    display = {
                        format_annote = function(msg)
                            if msg.done and msg.title == ready_signal[_G.PROJECT_TYPE] and not _G.LSP_READY then
                                vim.notify("LSP of " .. _G.PROJECT_TYPE .. " Ready")
                                _G.LSP_READY = true
                                remapKeySaga()
                            end
                            return msg.title
                        end
                    }
                },
                notification = {
                    override_vim_notify = true,
                }
            })

            -- 剩余的语言不依赖索引，可以直接 remap 快捷键
            if ready_signal[_G.PROJECT_TYPE] == nil then
                vim.notify("LSP of " .. _G.PROJECT_TYPE .. " Ready")
                remapKeySaga()
            end
        end
    }
}
