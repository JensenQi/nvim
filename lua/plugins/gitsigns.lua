-- git blame 插件
local keymap = require("keymap")
keymap.map2cmd("n", keymap.open_git_blame, "<CMD>BlameToggle<CR>")
keymap.map2cmd("n", keymap.goto_vsc_diff, '<CMD>Gitsigns preview_hunk_inline<CR>')

return {
    {
        os.getenv("ghproxy") .. "https://github.com/lewis6991/gitsigns.nvim.git",
        dependencies = {
            os.getenv("ghproxy") .. "https://github.com/FabijanZulj/blame.nvim.git"
        },
        config = function()
            require("blame").setup({ date_format = "%Y/%m/%d" })
            require('gitsigns').setup({
                numhl = true,
                current_line_blame = true,
                current_line_blame_opts = { virt_text = false, delay = 50 },
                -- current_line_blame_formatter = '<abbrev_sha> 📢<summary> 🧑<committer> 📅<author_time:%Y-%m-%d>',
                current_line_blame_formatter = '<summary>',
            })
        end
    }
}
