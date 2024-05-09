local utils = require("new-file-template.utils")

local function plugin_template(relative_path, filename)
    return [[
--
return {
    {
        os.getenv("ghproxy") .. "|cursor|",
        version = "*",
        dependencies = {
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

