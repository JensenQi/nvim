local M = {}

function M.setup()
    require("snippets.jvm_snippets").setup()
    require("snippets.react_native").setup()
    require("snippets.common").setup()
end

return M
