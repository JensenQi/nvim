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
                backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
                layout = { min_width = 30, },

                filter_kind = false, -- display all kile
                show_guides = true,
                guides = {
                    mid_item = "┣━",
                    last_item = "┗━",
                    nested_top = "┃ ",
                    whitespace = "  ",
                },

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
            vim.keymap.set("n", "<esc>[]", "<cmd>AerialToggle<CR>")
        end
    }
}

