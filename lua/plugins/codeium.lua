-- AI 代码提示插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/Exafunction/codeium.nvim.git",
        version = "*",
        dependencies = {
            os.getenv("ghproxy") .. "https://github.com/nvim-lua/plenary.nvim.git",
            os.getenv("ghproxy") .. "https://github.com/hrsh7th/nvim-cmp",
        },
        config = function()
            require("codeium").setup({
                bin_path = _G.NVIM_HOME .. '/share/codeium',
                language_server_download_url = os.getenv("ghproxy") .. "https://github.com"
            })
        end
    }
}
