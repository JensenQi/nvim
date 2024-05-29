-- 新文件模板
return {
    {
        os.getenv("ghproxy") .. "https://github.com/JensenQi/new-file-template.nvim.git",
        version = "*",
        dependencies = { os.getenv("ghproxy") .. "https://github.com/nvim-tree/nvim-tree.lua.git" },
        config = function()
            require("new-file-template").setup({
                -- 如果 nvim-tree 创建文件后自动打开新创建的文件，那么模板插件的默认参数有冲突
                -- 默认自动插入模板，这会导致写冲突, 因此需要将 autocmd 关闭，通过手动调用来插入
                disable_autocmd = true, -- 创建文件后是否自动插入模板

                disable_insert = false, -- 插入模板后是否自动进入 insert 模式
                disable_filetype = {},  -- 对特定文件类型禁用所有系统模板，用户模板不受影响
                disable_specific = {},  -- 对特定文件类型禁用部分系统模板, e.g { ruby = { ".*" } }, 用户模板不受影响
                suffix_as_filetype = true,
            })

            local api = require("nvim-tree.api")
            api.events.subscribe(api.events.Event.FileCreated, function(file)
                vim.cmd("edit " .. file.fname)                                  -- 创建文件后自动打开新创建的文件

                vim.loop.new_timer():start(250, 0, vim.schedule_wrap(function() -- 延迟 250ms 后执行 1 次
                    -- 手动触发模版插入
                    vim.cmd("InsertTemplateFile")
                end))
            end)
        end
    }
}
