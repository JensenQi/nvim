-- 页面内快速跳转插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/ggandor/leap.nvim.git",
        version = "*",
        config = function()
            local leap = require("leap")
            -- 默认会映射 gs 为 leap-from-window 操作
            -- 这个快捷键与 alternate 插件的跳转源码操作冲突
            -- 导致每次启动都警告 ... found conflicting mapping for ...
            -- 因此不能使用 leap.create_default_mappings()
            -- 而应该手动设置 s 和 S 命令，忽略默认的 gs 命令
            vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
            vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')

            vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
            vim.api.nvim_set_hl(0, 'LeapMatch', { fg = 'white', bold = true, nocombine = true, })
            leap.opts.highlight_unlabeled_phase_one_targets = true

            -- Hide the (real) cursor when leaping, and restore it afterwards.
            vim.api.nvim_create_autocmd('User', {
                pattern = 'LeapEnter',
                callback = function()
                    vim.cmd.hi('Cursor', 'blend=100')
                    vim.opt.guicursor:append { 'a:Cursor/lCursor' }
                end,
            })

            vim.api.nvim_create_autocmd('User', {
                pattern = 'LeapLeave',
                callback = function()
                    vim.cmd.hi('Cursor', 'blend=0')
                    vim.opt.guicursor:remove { 'a:Cursor/lCursor' }
                end,
            })

            -- highlight 2 chars of phase2 text
            function highlight_second_char(targets, first_idx, last_idx)
                local hl = require('leap.highlight')
                for i = first_idx or 1, last_idx or #targets do
                    local target = targets[i]
                    if target.chars then
                        local bufnr = target.wininfo.bufnr
                        local id = vim.api.nvim_buf_set_extmark(
                            bufnr, hl.ns, target.pos[1] - 1, target.pos[2] - 1,
                            {
                                virt_text = { { table.concat(target.chars), "LeapMatch" } },
                                virt_text_pos = "overlay",
                                hl_mode = "combine",
                                priority = hl.priority.label,
                            }
                        )
                        -- This way Leap automatically cleans up your stuff together with its own.
                        table.insert(hl.extmarks, { bufnr, id })
                    end
                end
                -- Continue with Leap's native function body.
                return true
            end

            leap.opts.on_beacons = highlight_second_char
        end
    }
}

