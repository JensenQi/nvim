-- 匹配块快速跳转
return {
    {
        os.getenv("ghproxy") .. "https://github.com/andymass/vim-matchup.git",
        version = "*",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "status" }
        end
    }
}
