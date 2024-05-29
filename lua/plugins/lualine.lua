-- 底部状态栏插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/nvim-lualine/lualine.nvim.git",
        version = "*",
        config = function()
            require('lualine').setup({
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'b:gitsigns_blame_line' },
                    lualine_x = { 'g:metals_status', 'encoding', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
            })
        end
    }
}
