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
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
            }
        },
        config = function()
            require("telescope").setup({
            })
        end
    }
}
