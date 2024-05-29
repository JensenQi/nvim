-- 单词高亮插件
local keymap = require("keymap")

return {
    {
        os.getenv("ghproxy") .. "https://github.com/Mr-LLLLL/interestingwords.nvim.git",
        dependencies = {
            os.getenv("ghproxy") .. "https://github.com/xiyaowong/nvim-cursorword.git",
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

            vim.api.nvim_set_hl(0, 'CursorWord', { bg = '#4A7056' })

            vim.g.cursorword_disable_filetypes = { "NvimTree", "TelescopePrompt", "TelescopeResults", "sagafinder" }
            -- vim.api.nvim_create_autocmd("FileType", {
            --     callback = function() vim.notify(vim.bo.filetype) end
            -- })
        end
    }
}
