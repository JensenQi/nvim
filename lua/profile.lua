vim.opt.fileencoding = "utf-8" -- 文件编码
vim.opt.number = true          -- 显示行号

vim.opt.tabstop = 4            -- 按 1 次 tab 显示 4 个空格数量
vim.opt.softtabstop = 4        -- 按 1 次删除清除空格数量
vim.opt.shiftwidth = 4         -- 换行缩进 4 个空格
vim.opt.autoindent = true      -- 自动缩进
vim.opt.expandtab = true       -- 用空格替换 tab
vim.opt.cursorline = true      -- 光标行高亮

-- filetype plugin 会根据文件类型调整缩进空格数量, 因此这里关闭它
vim.api.nvim_command('filetype plugin off')

vim.opt.termguicolors = true
vim.g.no_plugin_maps = 1 -- 关闭 vim 默认的 filetype plugin 快捷键映射, 避免与 aerial 插件冲突

vim.cmd("command Q q")
vim.cmd("command W w")
vim.cmd("command WQ wq")
vim.cmd("command Wq wq")
vim.cmd("command Todo TodoTelescope initial_mode=normal")

-- 全局变量
local util = require("util")
NVIM_HOME = os.getenv("NVIM_HOME")
PROJECT_PATH = vim.loop.cwd()
PROJECT_NAME = PROJECT_PATH:match("^.+/(.+)$")
LSP_READY = false

if util.exists(PROJECT_PATH .. "/pom.xml") then
    if util.exists(PROJECT_PATH .. "/src/main/scala") then
        PROJECT_TYPE = "scala"
    else
        PROJECT_TYPE = "java"
    end
elseif util.exists(PROJECT_PATH .. "/build.gradle") then
    PROJECT_TYPE = "java"
elseif util.exists(PROJECT_PATH .. "/pyproject.toml") then
    PROJECT_TYPE = "python"
elseif util.exists(PROJECT_PATH .. "/CMakeLists.txt") then
    PROJECT_TYPE = "cmake"
elseif util.exists(PROJECT_PATH .. "/go.mod") then
    PROJECT_TYPE = "go"
elseif util.exists(PROJECT_PATH .. "/Cargo.toml") then
    PROJECT_TYPE = "rust"
elseif util.exists(PROJECT_PATH .. "/lua") then
    PROJECT_TYPE = "lua"
elseif util.exists(PROJECT_PATH .. "/package.json") then
    PROJECT_TYPE = "typescript"
end
