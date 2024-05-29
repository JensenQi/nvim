local M = {}

function M.setup()
    local jvm_snippets = require("snippets.jvm_snippets")
    jvm_snippets.setup()
end

return M
