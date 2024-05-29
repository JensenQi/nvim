-- 底部终端插件
local keymap = require("keymap")
vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
        -- 由于 auto-session 与 toggleterm 存在冲突
        -- 当关闭 nvim 时, 如果浮动终端没有关闭，则 session 也会保存终端信息
        -- 但保存的窗口大小是错误的，导致下次启动的时候终端窗口异常
        -- 因此在关闭 nvim 时, 自动关闭已经打开的 toggleterm 窗口
        local lazy = require("toggleterm.lazy")
        local ui = lazy.require("toggleterm.ui")
        local has_open, windows = ui.find_open_windows()
        if has_open then
            ui.close_and_save_terminal_view(windows)
        end
    end
})

return {
    {
        os.getenv("ghproxy") .. "https://github.com/akinsho/toggleterm.nvim.git",
        version = "*",
        config = function()
            require("toggleterm").setup({
                open_mapping = keymap.open_terminal,
                size = 12,
                start_in_insert = true,
                close_on_exit = true,
                direction = "horizontal",
                autochdir = true
            })
        end
    }
}
