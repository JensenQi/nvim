local utils = require("new-file-template.utils")

-- src 模板
local function default_src_template(entity_name)
    os.execute("echo '\n' > include/" .. entity_name .. ".h")
    return "\n"
end

local function src_template(_, filename)
    local entity_name = utils.split(filename, "%.")[1]
    return default_src_template(entity_name)
end

-- test 模板
local function default_test_template(test_case)
    return [[#include <stdarg.h>
]] .. [[#include <stddef.h>
]] .. [[#include <setjmp.h>
]] .. [[#include <cmocka.h> \n
]] .. [[void ]] .. test_case .. [[(void **state) {\n    |cursor|\n}]]
end

local function test_template(_, filename)
    local test_case = utils.split(filename, "%.")[1]
    return default_test_template(test_case)
end

return function(opts)
    local template = {
        { pattern = "src/.*",  content = src_template },
        { pattern = "test/.*", content = test_template },
    }

    return utils.find_entry(template, opts)
end
