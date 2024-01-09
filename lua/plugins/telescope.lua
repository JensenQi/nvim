return {
    {
        os.getenv("ghproxy") .. "https://github.com/nvim-telescope/telescope.nvim.git",
        tag = '0.1.5',
        dependencies = {
            {
                os.getenv("ghproxy") .. "https://github.com/nvim-lua/plenary.nvim.git"
            },
            {
                os.getenv("ghproxy") .. "https://github.com/nvim-telescope/telescope-fzf-native.nvim.git",
                build =
                'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
            }
        },
        config = function()
            local map = vim.api.nvim_set_keymap
            local opt = { noremap = true, silent = true }
            map("n", "<A-f>", "/", opt)                         -- 页面内关键词查找
            map("n", "<C-F>", ":Telescope live_grep<CR>", opt)  -- 全局关键词查找
            map("n", "<C-o>", ":Telescope find_files<CR>", opt) -- 全局文件查找
            map("n", "<A-o>", ":Telescope find_files<CR>", opt) -- 全局文件查找

            require("telescope").setup({})
        end
    }
}
