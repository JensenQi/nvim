-- 快速词语搜索
local keymap = require("keymap")

return {
    {
        os.getenv("ghproxy") .. "https://github.com/Mr-LLLLL/interestingwords.nvim.git",
        version = "*",
        config = function()
            require('interestingwords').setup({
                colors = { '#aeee00', '#ff0000', '#0000ff', '#b88823', '#ffa724', '#ff2c4b' },
                search_count = true,
                navigation = true,
                search_key = keymap.word_highlight,
                cancel_search_key = keymap.word_cancel_highlight
            })
        end
    }
}

