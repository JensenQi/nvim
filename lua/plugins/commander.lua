-- 快捷命令插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/FeiyouG/commander.nvim.git",
        version = "*",
        dependencies = { os.getenv("ghproxy") .. "https://github.com/nvim-telescope/telescope.nvim.git" },
        config = function()
            local commander = require("commander")
            commander.setup({
                components = { "DESC", "KEYS", "CAT" },
                sort_by = { "DESC", "KEYS", "CAT", "CMD" },
                integration = {
                    telescope = { enable = true },
                    lazy = { enable = true, set_plugin_name_as_cat = true }
                }
            })
            commander.add({
                { desc = "Build Java", cmd = "<CMD>CocCommand java.project.build<CR>" },
            })
        end
    }
}
