-- 自动会话恢复插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/rmagatti/auto-session.git",
        version = "*",
        config = function()
            local workspace_home = os.getenv("WORKSPACE_HOME")
            if workspace_home == nil then
                return
            end
            require("auto-session").setup {
                log_level = "error",
                auto_session_suppress_dirs = { "~/" },
                auto_session_root_dir = workspace_home .. "/.vim/session",
                cwd_change_handling = {
                    post_cwd_changed_hook = function() -- refreshing the lualine status line after the cwd changes
                        require("lualine").refresh()   -- refresh lualine so the new session name is displayed in the status bar
                    end,
                },
                post_restore_cmds = {
                    function()
                        local status_ok, api = pcall(require, "nvim-tree.api")
                        if not status_ok then
                            return
                        end
                        api.tree.toggle { focus = false, find_file = true }
                    end,
                },
            }
        end
    }
}

