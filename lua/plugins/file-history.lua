-- 文件本地历史保存插件
local keymap = require("keymap")
keymap.map2cmd("n", keymap.find_file_hisotry, "<CMD>Telescope file_history history initial_mode=normal<CR>")

return {
    {
        os.getenv("ghproxy") .. "https://github.com/JensenQi/telescope-file-history.nvim.git",
        version = "*",
        dependencies = {
            os.getenv("ghproxy") .. "https://github.com/nvim-telescope/telescope.nvim.git",
        },
        config = function()
            local workspace_home = os.getenv("WORKSPACE_HOME")
            if workspace_home ~= nil then
                require('file_history').setup {
                    backup_dir = workspace_home .. "/.vim/local-history",
                    git_cmd = "git"
                }

                require("telescope").load_extension('file_history')

                -- HACK: 默认 CR 行为是 open_selected, 重定向到  revert_selected
                local fh_actions = require("file_history.actions")
                fh_actions.open_selected_hash = fh_actions.revert_to_selected
            end
        end
    }
}
