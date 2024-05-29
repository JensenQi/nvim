-- 自动保存插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/okuuva/auto-save.nvim.git",
        version = "*",
        config = function()
            require("auto-save").setup {
                enabled = true,
                execution_message = {
                    message = function()
                        return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
                    end,
                    dim = 0.18,
                    cleaning_interval = 1250,
                },
                trigger_events = {
                    immediate_save = { "BufLeave", "WinLeave", "FocusLost" },
                    defer_save = { "InsertLeave", "TextChanged" },
                    cancel_defered_save = { "InsertEnter" },
                },
                condition = function(buf) -- return true if buffer is ok to be saved else false
                    local fn = vim.fn
                    local utils = require("auto-save.utils.data")
                    if fn.getbufvar(buf, "&modifiable") == 1 and
                        utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
                        return true
                    end
                    return false
                end,
                write_all_buffers = false,
                noautocmd = false,
                debounce_delay = 120000,
                callbacks = {
                    enabling = nil,
                    disabling = nil,
                    before_asserting_save = nil,
                    before_saving = nil,
                    after_saving = nil,
                },
            }
        end
    }
}
