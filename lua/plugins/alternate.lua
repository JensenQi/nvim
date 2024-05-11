-- 关联文件跳转

-- 单元测试跳转
vim.keymap.set("n", "gt", function()
    vim.g.telescope_alternate_mappings = {
        { 'src/main/java/(.*)/(.*).java', { { 'src/test/java/[1]/[2]Test.java' } } }, -- java
        { 'src/main/scala/(.*)/(.*).scala', { { 'src/test/scala/[1]/[2]Suite.scala' } } }, -- scala
        { 'src/(.*)/(.*).py',              { { 'tests/[1]/test_[2].py' } } },          -- python
        -- cpp
        { 'src(.*)/(.*).cpp',             { { 'test[1]/test_[2].cpp' } } },
        { 'include(.*)/(.*).hpp',         { { 'test[1]/test_[2].cpp' } } },
        -- c
        { 'src(.*)/(.*).c',             { { 'test[1]/test_[2].c' } } },
        { 'include(.*)/(.*).h',         { { 'test[1]/test_[2].c' } } },
    }
    vim.cmd("Telescope telescope-alternate alternate_file")
end, { noremap = true })

-- 源文件跳转
vim.keymap.set("n", "gs", function()
    vim.g.telescope_alternate_mappings = {
        { 'src/test/java/(.*)/(.*)Test.java', { { 'src/main/java/[1]/[2].java' } } }, -- java
        { 'src/test/scala/(.*)/(.*)Suite.scala', { { 'src/main/scala/[1]/[2].scala' } } }, -- scala
        { 'tests/(.*)/test_(.*).py',           { { 'src/[1]/[2].py' } } },       -- python
        -- cpp
        { 'test(.*)/test_(.*).cpp',           { { 'src[1]/[2].cpp' } } },
        { 'include(.*)/(.*).hpp',             { { 'src[1]/[2].cpp' } } },
        -- c
        { 'test(.*)/test_(.*).c',           { { 'src[1]/[2].c' } } },
        { 'include(.*)/(.*).h',             { { 'src[1]/[2].c' } } },
    }
    vim.cmd("Telescope telescope-alternate alternate_file")
end, { noremap = true })

-- 头文件跳转
vim.keymap.set("n", "gh", function()
    vim.g.telescope_alternate_mappings = {
        -- cpp
        { 'src(.*)/(.*).cpp',       { { 'include[1]/[2].hpp' }, } },
        { 'test(.*)/test_(.*).cpp', { { 'include[1]/[2].hpp' } } },
        -- c
        { 'src(.*)/(.*).c',       { { 'include[1]/[2].h' }, } },
        { 'test(.*)/test_(.*).c', { { 'include[1]/[2].h' } } },
    }
    vim.cmd("Telescope telescope-alternate alternate_file")
end, { noremap = true })

return {
    {
        os.getenv("ghproxy") .. "https://github.com/otavioschwanck/telescope-alternate.nvim.git",
        version = "*",
        config = function()
            require('telescope-alternate').setup({
                mappings = {}, -- 延迟到 gt, gh, gs 等命令执行的时候再注入
                open_only_one_with = 'current_pane',
            })
        end
    }
}

