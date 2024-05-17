local utils = require("new-file-template.utils")

local function plugin_template(relative_path, filename)
    return [[
--
local keymap = require("keymap")
local util = require("util")

return {
    {
        os.getenv("ghproxy") .. "https://github.com/|cursor|.git",
        -- os.getenv("ghproxy") .. "",
        version = "*",
        dependencies = {
            -- os.getenv("ghproxy") .. "https://github.com/.git",
            -- os.getenv("ghproxy") .. "",
        },
        config = function()
            require("").setup({
            })
        end
    }
}
]]
end

return function(opts)
    local template = {
        { pattern = "lua/plugins/.*", content = plugin_template },
    }

    return utils.find_entry(template, opts)
end

