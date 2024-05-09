local utils = require("new-file-template.utils")

-- main 模板
local function default_main_template(pack, entity_type, entity_name)
    return [[
package ]] .. pack .. [[;\n\n
public ]] .. entity_type .. [[ ]] .. entity_name .. [[ {\n    |cursor|\n}\n]]
end

local function main_template(relative_path, filename)
    local pack = relative_path:match("src/main/java/(.+)$"):gsub("/", ".")
    local entity_name = utils.split(filename, "%.")[1]
    local entity_type = "class"

    return default_main_template(pack, entity_type, entity_name)
end

-- test 模板
local function default_test_template(pack, entity_name)
    return [[
package ]] .. pack .. [[;\n\nimport org.junit.Test;\n\nimport static org.junit.Assert.*;\n\n
public class ]] .. entity_name .. [[ {\n\n    @Test\n    public void test|cursor|() {\n    }\n\n}\n]]
end

local function test_template(relative_path, filename)
    local pack = relative_path:match("src/test/java/(.+)$"):gsub("/", ".")
    local entity_name = utils.split(filename, "%.")[1]
    return default_test_template(pack, entity_name)
end

--- @param opts table
---   A table containing the following fields:
---   - `full_path` (string): The full path of the new file, e.g., "lua/new-file-template/templates/init.lua".
---   - `relative_path` (string): The relative path of the new file, e.g., "lua/new-file-template/templates/init.lua".
---   - `filename` (string): The filename of the new file, e.g., "init.lua".
return function(opts)
    local template = {
        { pattern = "src/main/java/.*", content = main_template },
        { pattern = "src/test/java/.*", content = test_template },
    }

    return utils.find_entry(template, opts)
end



