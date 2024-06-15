-- 单词高亮插件
local keymap = require("keymap")

return {
    {
        os.getenv("ghproxy") .. "https://github.com/Mr-LLLLL/interestingwords.nvim.git",
        dependencies = {
            os.getenv("ghproxy") .. "https://github.com/tzachar/local-highlight.nvim.git"
        },
        version = "*",
        config = function()
            require('interestingwords').setup({
                colors = { '#aeee00', '#ff0000', '#0000ff', '#b88823', '#ffa724', '#ff2c4b' },
                search_count = true,
                navigation = true,
                search_key = keymap.word_highlight,
                cancel_search_key = keymap.word_cancel_highlight
            })

            require('local-highlight').setup({
                disable_file_types = { "NvimTree", "TelescopePrompt", "TelescopeResults", "sagafinder" },
                hlgroup = 'Search',
                cw_hlgroup = nil,
                insert_mode = false, -- Whether to display highlights in INSERT mode or not
                min_match_len = 1,
                max_match_len = math.huge,
                highlight_single_match = true,
            })
            vim.opt.updatetime = 300
            -- vim.api.nvim_create_autocmd("FileType", {
            --     callback = function() vim.notify(vim.bo.filetype) end
            -- })
        end
    }
}
