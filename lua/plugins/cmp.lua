-- 自动补全插件
local keymap = require("keymap")

return {
    {
        os.getenv("ghproxy") .. "https://github.com/hrsh7th/nvim-cmp.git",
        branch = "main",
        dependencies = {
            os.getenv("ghproxy") .. "https://github.com/hrsh7th/cmp-nvim-lsp.git",
            os.getenv("ghproxy") .. "https://github.com/hrsh7th/cmp-buffer.git",
            os.getenv("ghproxy") .. "https://github.com/hrsh7th/cmp-path.git",
            os.getenv("ghproxy") .. "https://github.com/saadparwaiz1/cmp_luasnip.git",
            os.getenv("ghproxy") .. "https://github.com/L3MON4D3/LuaSnip.git",
            os.getenv("ghproxy") .. "https://github.com/rafamadriz/friendly-snippets.git",
            os.getenv("ghproxy") .. "https://github.com/onsails/lspkind.nvim",
        },
        config = function()
            local luasnip = require("luasnip")
            require("snippets.loader").setup()

            vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
            vim.api.nvim_set_hl(0, 'CmpItemKindCodeium', { bg = 'NONE', fg = '#60D5C4' })


            local cmp = require("cmp")
            local lspkind = require('lspkind')
            cmp.setup({
                completion = { autocomplete = false }, -- 关闭 cmp 的自动打开菜单，由后面的 TextChangedI 事件触发
                matching = {
                    disallow_prefix_unmatching = false,
                    disallow_symbol_nonprefix_matching = true
                },
                snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
                mapping = cmp.mapping.preset.insert({
                    [keymap.complete_confirm_or_jump_next_slot] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.confirm({ select = true })
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    [keymap.focus_code_complete] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    [keymap.next_code_complete] = cmp.mapping(function(fallback)
                        if cmp.get_selected_entry() ~= nil then
                            cmp.select_next_item()
                            if cmp.get_selected_entry() == nil then -- 越界之后会退出 focus，此时再往下跳一行
                                cmp.select_next_item()
                            end
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    [keymap.pre_code_complete] = cmp.mapping(function(fallback)
                        if cmp.get_selected_entry() ~= nil then
                            cmp.select_prev_item()
                            if cmp.get_selected_entry() == nil then -- 越界之后会退出 focus，此时再往上跳一行
                                cmp.select_prev_item()
                            end
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    [keymap.complete_confirm] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.confirm({ select = true })
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = lspkind.cmp_format({
                        mode = 'symbol_text',
                        maxwidth = 50,
                        ellipsis_char = '...',
                        show_labelDetails = true,
                        symbol_map = { Codeium = "", },
                        before = function(entry, vim_item)
                            local name = entry.source.name
                            vim_item.menu = ({
                                buffer = '[BUF]',
                                path = '[PATH]',
                                nvim_lsp = '[LSP]',
                                luasnip = '[SNIP]',
                                codeium = '[CDM]',
                            })[name] or ("[" .. string.upper(name) .. "]")
                            vim_item.dup = 0
                            return vim_item
                        end
                    })
                },

                sources = cmp.config.sources({
                    {
                        name = "codeium",
                        entry_filter = function(entry, ctx)
                            local trigger = ctx.cursor_before_line:match('(%w+)$')
                            if trigger == nil then -- 非单词结尾则返回 true
                                return true
                            end


                            local insert_text = entry:get_insert_text()

                            -- 如果已经输入完毕则不展示该补全项
                            if trigger == insert_text then
                                return false
                            end

                            -- 首字符不匹配则不展示该补全项
                            if string.sub(trigger, 1, 1) ~= string.sub(insert_text, 1, 1) then
                                return false
                            end

                            return true
                        end
                    },
                    {
                        name = 'nvim_lsp',
                        entry_filter = function(entry, ctx)
                            local trigger = ctx.cursor_before_line:match('(%w+)$')
                            if trigger == nil then -- 非单词结尾则返回 true
                                return true
                            end

                            local insert_text = entry:get_insert_text()

                            -- 如果已经输入完毕则不展示该补全项
                            if trigger == insert_text then
                                return false
                            end

                            -- 首字符不匹配则不展示该补全项
                            if string.sub(trigger, 1, 1) ~= string.sub(insert_text, 1, 1) then
                                return false
                            end

                            return true
                        end
                    },
                    { name = 'path', },
                    {
                        name = 'buffer',
                        entry_filter = function(entry, ctx)
                            local trigger = ctx.cursor_before_line:match('(%w+)$')
                            if trigger == nil then -- 非单词结尾则返回 false
                                return false
                            end

                            local insert_text = entry:get_insert_text()

                            -- 如果已经输入完毕则不展示该补全项
                            if trigger == insert_text then
                                return false
                            end

                            -- 首字符不匹配则不展示该补全项
                            if string.sub(trigger, 1, 1) ~= string.sub(insert_text, 1, 1) then
                                return false
                            end

                            return true
                        end
                    },
                    {
                        name = 'luasnip',
                        entry_filter = function(entry, ctx)
                            local snip_abbr = entry:get_completion_item().label
                            local is_postfix_snip = string.sub(snip_abbr, 1, 1) == "."

                            local cursor_before_line = ctx.cursor_before_line
                            local attemp_postfix_snip = ctx.cursor_before_line:match("%.(%w+)$") or
                            ctx.cursor_before_line:sub(-1) == "."

                            -- postfix 补全
                            if attemp_postfix_snip then
                                return is_postfix_snip
                            end

                            -- 非 postfix 补全
                            if is_postfix_snip then
                                return false
                            end

                            return true
                        end
                    },
                })
            })

            -- 手动打开补全
            keymap.map2fun("i", keymap.code_complete, function() cmp.complete() end)

            -- 自动打开补全
            vim.api.nvim_create_autocmd("TextChangedI", {
                callback = function()
                    local line_num, col_num = unpack(vim.api.nvim_win_get_cursor(0))
                    if col_num == 0 then
                        return -- 输入少于 1 个字符不发起补全
                    end

                    local current_line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, true)[1]
                    local pre_char = current_line:sub(col_num, col_num)

                    if cmp.visible() and pre_char == ' ' then
                        -- 如果已经打开自动补全, 并且前一个字符为空格，则关闭补全
                        cmp.close()
                    end

                    -- 如果没有打开补全，字符不是空格，则打开补全
                    if pre_char ~= ' ' then
                        cmp.complete()
                    end
                end
            })

            -- 补全后自动补全括号
            local cmp_autopairs = require('nvim-autopairs.completion.cmp').on_confirm_done()
            cmp.event:on(
                'confirm_done',
                function(event)
                    cmp_autopairs(event)
                end
            )
        end
    }
}
