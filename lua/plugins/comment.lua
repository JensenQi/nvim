-- 快速注释插件
local keymap = require("keymap")
keymap.map2cmd("n", keymap.comment_current_line, "<Plug>(comment_toggle_linewise_current)j")
keymap.map2cmd("v", keymap.comment_block, "<Plug>(comment_toggle_linewise_visual)")

return {
    {
        os.getenv("ghproxy") .. "https://github.com/numToStr/Comment.nvim.git",
        version = "*",
        lazy = false,
        config = function()
            require('Comment').setup({
                mappings = {
                    basic = false,
                    extra = false,
                }
            })
        end
    }
}
