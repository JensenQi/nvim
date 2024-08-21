-- 文件树插件
local util = require("util")
local keymap = require("keymap")
keymap.map2cmd('n', keymap.switch_file_explorer_and_editor, '<C-w>w')

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local api = require("nvim-tree.api")
        api.tree.toggle({ focus = false, find_file = true })
    end
})

vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
        local tree_wins = {}
        local floating_wins = {}
        local wins = vim.api.nvim_list_wins()
        for _, w in ipairs(wins) do
            local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
            if bufname:match("NvimTree_") ~= nil then
                table.insert(tree_wins, w)
            end
            if vim.api.nvim_win_get_config(w).relative ~= '' then
                table.insert(floating_wins, w)
            end
        end

        if 1 == #wins - #floating_wins - #tree_wins then
            for _, w in ipairs(tree_wins) do
                vim.api.nvim_win_close(w, true)
            end
        end
    end
})

return {
    {
        os.getenv("ghproxy") .. "https://github.com/nvim-tree/nvim-tree.lua.git",
        version = "*",
        dependencies = { os.getenv("ghproxy") .. "https://github.com/nvim-tree/nvim-web-devicons.git" },
        config = function()
            local function my_on_attach(bufnr)
                local api = require "nvim-tree.api"
                local function opts(desc)
                    return {
                        desc = "nvim-tree: " .. desc,
                        buffer = bufnr,
                        noremap = true,
                        silent = true,
                        nowait = true
                    }
                end

                -- custom mapping
                vim.keymap.set('n', keymap.file_explorer_preview, api.node.open.preview, opts("Preview"))
                vim.keymap.set('n', keymap.file_explorer_edit, api.node.open.edit, opts("Edit"))
                vim.keymap.set('n', keymap.file_explorer_close_parent_dir, api.node.navigate.parent_close,
                    opts("Close parent"))
                vim.keymap.set('n', keymap.file_explorer_create, api.fs.create, opts('Create'))
                vim.keymap.set('n', keymap.file_explorer_goto_parent, api.node.navigate.parent, opts('go to parent'))
                vim.keymap.set('n', keymap.file_explorer_rename, api.fs.rename, opts('Rename'))
                vim.keymap.set('n', keymap.file_explorer_remove, api.fs.remove, opts('Remove'))
                vim.keymap.set('n', keymap.file_explorer_trash, api.fs.trash, opts('Trash'))
                vim.keymap.set('n', keymap.file_explorer_copy, api.fs.copy.node, opts('copy'))
                vim.keymap.set('n', keymap.file_explorer_cut, api.fs.cut, opts('cut'))
                vim.keymap.set('n', keymap.file_explorer_paste, api.fs.paste, opts('paste'))
                vim.keymap.set('n', keymap.file_explorer_show_info, api.node.show_info_popup, opts('File Infomation'))
                vim.keymap.set('n', keymap.file_explorer_reload, api.tree.reload, opts('Reload'))
                vim.keymap.set('n', keymap.file_explorer_larger, function()
                    vim.cmd("NvimTreeResize +1")
                end, opts("larger"))
                vim.keymap.set('n', keymap.file_explorer_smaller, function()
                    vim.cmd("NvimTreeResize -1")
                end, opts("smaller"))
            end

            require("nvim-tree").setup({
                on_attach = my_on_attach,
                renderer = {
                    group_empty = true,
                },
                filters = {
                    custom = function(absolute_path)
                        if absolute_path:match("%.git") or absolute_path:match("%.vim")
                            or absolute_path:match("%.idea") or absolute_path:match("%.bloop")
                            or absolute_path:match("%.metals") or absolute_path:match("%.state")
                            or absolute_path:match("%.settings") or absolute_path:match("%.classpath")
                            or absolute_path:match("%.project") or absolute_path:match("/gradle$")
                            or absolute_path:match("node_modules") or absolute_path:match("__pycache__")
                            or absolute_path:match("/build$") or absolute_path:match("/target$")
                            or absolute_path:match("gradlew")
                        then
                            return true
                        end

                        -- gradle 编译结果
                        if absolute_path:match("bin") and util.exists(absolute_path .. "/main") then
                            return true
                        end

                        return false
                    end,
                    exclude = {},
                },
                update_focused_file = {
                    enable = true,           -- 跟随当前编辑文件
                    ignore_list = {
                        update_root = false, -- 不修改根目录, 即不会切换到第三方库文件的路径
                    },
                    exclude = function(event)
                        local full_path = vim.api.nvim_buf_get_name(event.buf)
                        -- cpp 项目的第三方依赖在项目根目录下
                        -- 依赖前面的 update_root = false 并不能限制目录切换
                        -- 因此这里通过 exlude 的回调函数来判断是否跳过目录切换
                        if string.find(full_path, "/3rdparty/") then
                            return true
                        else
                            return false
                        end
                    end
                },
            })
        end
    }
}
