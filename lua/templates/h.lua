local utils = require("new-file-template.utils")

-- header 模板
local function default_header_template(entity_name)
    os.execute("echo '\n' > src/"..entity_name ..".c")
    return "\n"
end

local function header_template(_, filename)
    local entity_name = utils.split(filename, "%.")[1]
    return default_header_template(entity_name)
end

return function(opts)
    local template = {
        { pattern = "include/.*", content = header_template },
    }

    return utils.find_entry(template, opts)
end



