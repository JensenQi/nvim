-- 文件树插件
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
                vim.keymap.set('n', '<Tab>', api.node.open.preview, opts("Preview"))
                vim.keymap.set('n', 'o', api.node.open.preview, opts("expand"))
                vim.keymap.set('n', '<CR>', api.node.open.edit, opts("Edit"))
                vim.keymap.set('n', 'zc', api.node.navigate.parent_close, opts("Close parent dir"))
                vim.keymap.set('n', 'xx', api.tree.collapse_all, opts("collapse all"))
                vim.keymap.set('n', 'ZZ', api.tree.change_root_to_node, opts("set dir as root"))
                vim.keymap.set('n', 'nn', api.fs.create, opts('Create'))
                vim.keymap.set('n', 'gg', api.node.navigate.parent, opts('go to parent'))
                vim.keymap.set('n', 'rr', api.fs.rename, opts('Rename'))
                vim.keymap.set('n', 'DD', api.fs.remove, opts('Remove'))
                vim.keymap.set('n', 'dd', api.fs.trash, opts('Trash'))
                vim.keymap.set('n', 'yy', api.fs.copy.node, opts('copy'))
                vim.keymap.set('n', 'cc', api.fs.cut, opts('cut'))
                vim.keymap.set('n', 'p', api.fs.paste, opts('paste'))
                vim.keymap.set('n', '?', api.node.show_info_popup, opts('File Infomation'))
                vim.keymap.set('n', 'R', api.tree.reload, opts('Reload'))
            end

            require("nvim-tree").setup({
                on_attach = my_on_attach,
                renderer = {
                    group_empty = true,
                },
                filters = {
                    custom = {
                        "\\.git", "\\.vim", "\\.idea", "target", "build",
                        "node_modules", "__pycache__", "\\.bloop", "\\.metals",
                        "\\.state"
                    },
                    exclude = {},
                },
                update_focused_file = {
                    enable = true, -- 跟随当前编辑文件
                    update_root = false, -- 不修改根目录, 即不会切换到第三方库文件的路径
                    ignore_list = {},
                },
            })
        end
    }
}

