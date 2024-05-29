-- 书签插件
local keymap = require("keymap")

return {
    {
        os.getenv("ghproxy") .. "https://github.com/tomasky/bookmarks.nvim.git",
        branch = "main",
        dependencies = {
            os.getenv("ghproxy") .. "https://github.com/nvim-telescope/telescope.nvim.git",
        },
        config = function()
            local workspace_home = os.getenv("WORKSPACE_HOME")
            if workspace_home == nil then
                return
            end
            local bm = require('bookmarks')
            bm.setup {
                sign_priority = 8, --set bookmark sign priority to cover other sign
                save_file = workspace_home .. "/.vim/bookmarks", -- bookmarks save file path
                keywords = {
                    ["@t"] = " ", -- mark annotation startswith @t ,signs this icon as `Todo`
                    ["@w"] = " ", -- mark annotation startswith @w ,signs this icon as `Warn`
                    ["@e"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
                    ["@f"] = "󰣪 ", -- mark annotation startswith @f ,signs this icon as `Fix`
                },
                on_attach = function(_)
                    keymap.map2fun("n", keymap.add_or_remove_bookmark, bm.bookmark_toggle)  -- add or remove bookmark at current line
                    keymap.map2fun("n", keymap.edit_bookmark, bm.bookmark_ann)              -- add or edit mark annotation at current line
                    keymap.map2fun("n", keymap.remove_curr_buf_bookmark, bm.bookmark_clean) -- clean all marks in local buffer
                    keymap.map2fun("n", keymap.list_all_bookmarks,
                        '<CMD>Telescope bookmarks list initial_mode=normal<CR>')

                    -- 删除所有 bookmarks 不绑定快捷键，避免手滑导致删除, 而是新建一个 vim 命令
                    vim.api.nvim_create_user_command('CleanAllBookmark', function()
                        -- 默认情况下, 执行 clear all 操作不会更新 buffer 的 icon 信息
                        -- 这里遍历所有打开的 buffer 执行 clean 操作, 刷新 buffer 的 icon 信息
                        -- 最后再执行 clean all 操作
                        local init = vim.api.nvim_get_current_buf()
                        local not_finish = true
                        while not_finish do
                            bm.bookmark_clean()
                            vim.cmd("BufferLineCycleNext")
                            local next = vim.api.nvim_get_current_buf()
                            if next == init then
                                not_finish = false
                            end
                        end
                        bm.bookmark_clear_all()
                    end, {})

                    vim.loop.new_timer():start(100, 0, vim.schedule_wrap(function() -- 延迟 250ms 后执行 1 次
                        -- 与 autosession 不兼容, 导致退出后重新进入不渲染当前 buf 的 icon
                        -- 因此这里增加一个异步刷新 session 恢复的 buf 的 bookmarks
                        require('bookmarks.actions').refresh()
                    end))
                end
            }

            require("telescope").load_extension('bookmarks')
        end
    }
}
