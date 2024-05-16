--
return {
    {
        os.getenv("ghproxy") .. "https://github.com/andymass/vim-matchup.git",
        version = "*",
        dependencies = {
        },
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "status" }
        end
    }
}

