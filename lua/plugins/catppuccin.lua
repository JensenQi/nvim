return {
    {
        os.getenv("ghproxy") .. "https://github.com/catppuccin/nvim.git",
        version = "*",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "frappe"
            })
            vim.cmd.colorscheme "catppuccin"
        end
    }
}
