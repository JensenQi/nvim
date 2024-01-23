-- 自动保存插件
local group = vim.api.nvim_create_augroup('autosave', {})

vim.api.nvim_create_autocmd('User', {
    pattern = 'AutoSaveWritePre',
    group = group,
    callback = function(opts)
        local buf = opts.data.saved_buffer
        if buf == nil then
            return
        end

        local last_line = vim.api.nvim_buf_get_lines(buf, -2, -1, false)[1]
        if last_line == nil or last_line == "" then                     -- nothing need todo
            return
        elseif (last_line:gsub("^%s+", ""):gsub("%s+$", "")) == "" then -- trim last line
            vim.api.nvim_buf_set_lines(buf, -2, -2, false, { "" })
        else                                                            -- append new line
            vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "" })
        end
    end,
})


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

