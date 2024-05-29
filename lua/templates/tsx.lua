local utils = require("new-file-template.utils")

local function view_template(relative_path, filename)
    return [[
import React from "react";

export default function (props: {}) {
    return <>
        |cursor|
    </>
}]]
end

return function(opts)
    local template = {
        { pattern = "view/.*", content = view_template },
    }

    return utils.find_entry(template, opts)
end
