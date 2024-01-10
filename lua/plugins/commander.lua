return {
    {
        os.getenv("ghproxy") .. "https://github.com/FeiyouG/commander.nvim.git",
        version = "*",
        dependencies = { os.getenv("ghproxy") .. "https://github.com/nvim-telescope/telescope.nvim.git" },
        config = function()
            local map = vim.api.nvim_set_keymap
            local opt = { noremap = true, silent = true }
            map("n", "<esc>p", "<CMD>Telescope commander<CR>", opt) -- 打开终端

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
