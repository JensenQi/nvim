local M = {}

function M.trim_margin(str, sep)
    sep = sep or "|"
    local lines = {}
    for s in str:gmatch("[^\r\n]+") do
        local start_idx = s:find(sep)
        if start_idx ~= nil then
            table.insert(lines, s:sub(start_idx + 1))
        else
            table.insert(lines, s)
        end
    end
    return table.concat(lines, "\n")
end

function M.content_before_cursor()
    local line_num, col_num = unpack(vim.api.nvim_win_get_cursor(0))
    if col_num == 0 then
        return ""
    else
        return vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, true)[1]
    end
end

function M.is_not_blank(str)
    return str ~= nil and str:match("[^%s]") ~= nil
end

function M.start_with(str, prefix)
    return str:sub(1, #prefix) == prefix
end

function M.end_with(str, subfix)
    return str:sub(-1 * #subfix) == subfix
end

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
