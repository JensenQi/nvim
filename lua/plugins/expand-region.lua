-- 扩大选择块插件
local keymap = require("keymap")
keymap.map2cmd("v", keymap.increase_vis_block, "<Plug>(expand_region_expand)")
keymap.map2cmd("v", keymap.decrease_vis_block, "<Plug>(expand_region_shrink)")

return {
    {
        os.getenv("ghproxy") .. "https://github.com/terryma/vim-expand-region.git",
        version = "*",
        config = function()
        end
    }
}

