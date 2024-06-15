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
            os.getenv("ghproxy") .. "https://github.com/JensenQi/cmp-luasnip-choice.git",
            os.getenv("ghproxy") .. "https://github.com/rafamadriz/friendly-snippets.git",
            os.getenv("ghproxy") .. "https://github.com/onsails/lspkind.nvim",
        },
        config = function()
            local luasnip = require("luasnip")
            require("snippets.loader").setup()
            require('cmp_luasnip_choice').setup({ auto_open = true })

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
                            -- 如果可以调到下一个 slot, 则执行跳转
                            -- bugfix: 当输入一个 snip, 然后删除这个 snip, 此时 locally_jumpable 依然为 true
                            -- 因此这里先把 deleted 的 snip unlink 掉再二次判断一次
                            -- 之所以把 unlink 放在这里是为了更好的性能，先简单判断 jumpable 再仔细判断 jumpable
                            -- 避免按 tab 频繁调用 unlink
                            luasnip.unlink_current_if_deleted()
                            if luasnip.locally_jumpable(1) then
                                luasnip.jump(1)
                            else
                                fallback()
                            end
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
                    { name = 'luasnip_choice' },
                    {
                        name = "codeium",
                        entry_filter = function(entry, ctx)
                            local insert_text = entry:get_insert_text()
                            if vim.g.cmp_trigger_first_char ~= string.sub(insert_text, 1, 1) or vim.g.cmp_trigger_word == insert_text then
                                -- 如果首字符不匹配或者已经输入完毕则不展示该补全项
                                return false
                            else
                                return true
                            end
                        end
                    },
                    {
                        name = 'nvim_lsp',
                        entry_filter = function(entry, ctx)
                            if vim.g.cmp_trigger_last_char == "." then
                                return true
                            end

                            local insert_text = entry:get_insert_text()
                            if vim.g.cmp_trigger_first_char ~= string.sub(insert_text, 1, 1) or vim.g.cmp_trigger_word == insert_text then
                                -- 如果首字符不匹配或者已经输入完毕则不展示该补全项
                                return false
                            else
                                return true
                            end
                        end
                    },
                    { name = 'path', },
                    {
                        name = 'buffer',
                        entry_filter = function(entry, ctx)
                            local insert_text = entry:get_insert_text()
                            if vim.g.cmp_trigger_first_char ~= string.sub(insert_text, 1, 1) or vim.g.cmp_trigger_word == insert_text then
                                -- 如果首字符不匹配或者已经输入完毕则不展示该补全项
                                return false
                            else
                                return true
                            end
                        end
                    },
                    {
                        name = 'luasnip',
                        entry_filter = function(entry, ctx)
                            local snip_abbr = entry:get_completion_item().label
                            local is_postfix_snip = string.sub(snip_abbr, 1, 1) == "."

                            if vim.g.cmp_trigger_contain_dot then
                                -- postfix 补全则只展示 postfix 候选
                                return is_postfix_snip
                            else
                                -- 否则只展示非 postfix 候选
                                return not is_postfix_snip
                            end
                        end
                    },
                })
            })

            -- 手动打开补全
            keymap.map2fun("i", keymap.code_complete, function() cmp.complete() end)

            -- 自动打开补全
            local complete_delay = 200
            vim.api.nvim_create_autocmd("TextChangedI", {
                callback = function()
                    vim.g.last_text_change_timestamp = vim.loop.now()
                    vim.loop.new_timer():start(complete_delay, 0, vim.schedule_wrap(function()
                        -- 如果距离最后一次输入在 complete_delay 之内，则不触发
                        -- 避免频繁调用导致卡顿
                        local clock = vim.loop.now()
                        local timediff = clock - (vim.g.last_text_change_timestamp or 0)
                        if timediff < complete_delay then
                            return
                        end

                        local line_num, col_num = unpack(vim.api.nvim_win_get_cursor(0))
                        if col_num == 0 then
                            return  -- 输入少于 1 个字符不发起补全
                        end

                        local current_line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, true)[1]
                        local last_char = current_line:sub(col_num, col_num)

                        if last_char == ' ' then
                            -- 最后一个字符如果是空格，则标示补全结束
                            if cmp.visible() then
                                -- 如果此时补全菜单打开，则关闭补全
                                cmp.close()
                            else
                                -- 否则直接结束
                                return
                            end
                        end


                        -- 最后一个字符不是空格，且没有打开补全，则准备准备打开补全
                        vim.g.cmp_trigger_last_char = current_line:sub(-1, -1)
                        vim.g.cmp_trigger_word = current_line:match('([%w_]+)$') or ''
                        if vim.g.cmp_trigger_word == '' then
                            vim.g.cmp_trigger_first_char = vim.g.cmp_trigger_last_char
                        else
                            vim.g.cmp_trigger_first_char = vim.g.cmp_trigger_word:sub(1, 1)
                        end
                        vim.g.cmp_trigger_contain_dot = (current_line:match("%.(%w+)$") ~= nil) or
                            (current_line:sub(-1, -1) == ".")

                        cmp.complete()
                    end))
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
