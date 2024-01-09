return {
    {
        os.getenv("ghproxy") .. "https://github.com/numToStr/Comment.nvim.git",
        version = "*",
        lazy = false,
        config = function()
            local map = vim.api.nvim_set_keymap
            local opt = { noremap = true, silent = true }
            map("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)j", opt) -- 快速注释当前行并移动到下一行
            map("v", "<C-_>", "<Plug>(comment_toggle_linewise_visual)", opt)   -- 快速注释选中块
            require('Comment').setup({
                mappings = {
                    basic = false,
                    extra = false,
                }
            })
        end
    }
}
