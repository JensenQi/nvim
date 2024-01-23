-- 代码大纲插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/stevearc/aerial.nvim.git",
        version = "*",
        dependencies = {
            os.getenv("ghproxy") .. "https://github.com/nvim-treesitter/nvim-treesitter",
            os.getenv("ghproxy") .. "https://github.com/nvim-tree/nvim-web-devicons"
        },

        config = function()
            require("aerial").setup({
                -- optionally use on_attach to set keymaps when aerial has attached to a buffer
                on_attach = function(bufnr)
                    -- Jump forwards/backwards with '{' and '}'
                    vim.keymap.set("n", "[", "<cmd>AerialPrev<CR>", { buffer = bufnr })
                    vim.keymap.set("n", "]", "<cmd>AerialNext<CR>", { buffer = bufnr })
                end,
                keymaps = {
                    ["j"] = "actions.down_and_scroll",
                    ["k"] = "actions.up_and_scroll",
                    ["<esc><esc>"] = "actions.close",
                    ["q"] = "actions.close",
                },
                close_on_select = true
            })
            vim.keymap.set("n", "<leader>[]", "<cmd>AerialToggle<CR>")
        end
    }
}
