local utils = require("new-file-template.utils")

-- main 模板
local function default_main_template(pack, entity_type, entity_name)
    return [[
package ]] .. pack .. [[\n\n
]] .. entity_type .. [[ ]] .. entity_name .. [[ {\n    |cursor|\n}\n]]
end

local function main_template(relative_path, filename)
    local pack = relative_path:match("src/main/scala/(.+)$"):gsub("/", ".")
    local entity_name = utils.split(filename, "%.")[1]
    local entity_type = "class"

    return default_main_template(pack, entity_type, entity_name)
end

-- test 模板
local function default_test_template(pack, entity_name)
    return [[
package ]] .. pack .. [[\n
class ]] .. entity_name .. [[ extends munit.FunSuite{\n\n    test("|cursor|") {\n    }\n\n}\n]]
end

local function test_template(relative_path, filename)
    local pack = relative_path:match("src/test/scala/(.+)$"):gsub("/", ".")
    local entity_name = utils.split(filename, "%.")[1]
    return default_test_template(pack, entity_name)
end

return function(opts)
    local template = {
        { pattern = "src/main/scala/.*", content = main_template },
        { pattern = "src/test/scala/.*", content = test_template },
    }

    return utils.find_entry(template, opts)
end

