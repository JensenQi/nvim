-- 代码大纲插件
local keymap = require("keymap")

vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
        -- 由于 auto-session 与 Aerial 存在冲突
        -- 因此在关闭 nvim 时, 需要通过回调关闭大纲
        vim.cmd('AerialClose')
    end
})

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

                on_attach = function(bufnr)
                    keymap.map2fun("n", keymap.goto_prev_object, "<cmd>AerialPrev<CR>", { buffer = bufnr })
                    keymap.map2fun("n", keymap.goto_next_object, "<cmd>AerialNext<CR>", { buffer = bufnr })
                end,
                keymaps = {
                    [keymap.outline_goto_next_line] = "actions.down_and_scroll",
                    [keymap.outline_goto_prev_line] = "actions.up_and_scroll",
                    [keymap.close_outline] = "actions.close",
                },
                close_on_select = true
            })
            keymap.map2cmd("n", keymap.open_outline, "<cmd>AerialToggle<CR>")
        end
    }
}
