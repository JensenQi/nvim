local M = {}

function M.setup()
    require("snippets.jvm_snippets").setup()
    require("snippets.react_native").setup()
end

return M
