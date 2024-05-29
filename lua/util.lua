local M = {}

function M.split(s, delimiter)
    local result = {}

    for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match)
    end

    return result
end

function M.filename()
    local abs_path = vim.api.nvim_buf_get_name(0)
    local part = M.split(abs_path, "/")
    return M.split(part[#part], "%.")[1]
end

function M.filetype()
    local abs_path = vim.api.nvim_buf_get_name(0)
    local part = M.split(abs_path, "/")
    return M.split(part[#part], "%.")[2]
end

--- Check if a file or directory exists in this path
function M.exists(file)
    local ok, err, code = os.rename(file, file)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    return ok, err
end

function M.run_delay(fn, delay)
    vim.loop.new_timer():start(delay, 0, vim.schedule_wrap(fn))
end

function M.delay(second)
    os.execute("sleep " .. second)
end

function M.init_log()
    os.execute('echo "" >> /tmp/nvim.log')
end

function M.log(content)
    os.execute('echo "' .. content .. '" >> /tmp/nvim.log')
end

return M
