return {
    {
        os.getenv("ghproxy") .. "https://github.com/terryma/vim-expand-region.git",
        version = "*",
        config = function()
            local map = vim.api.nvim_set_keymap
            local opt = { noremap = true, silent = true }
            map("v", "v", "<Plug>(expand_region_expand)", opt)                 -- 扩大选择块
            map("v", "V", "<Plug>(expand_region_shrink)", opt)                 -- 缩小s选择块
        end
    }
}
