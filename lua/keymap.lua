local M = {
    goto_file_explorer = "<Leader>`",          -- 跳转到文件管理器
    goto_tab1 = "<Leader>1",                   -- 跳转到编号为 1 的 Tab 页
    goto_tab2 = "<Leader>2",                   -- 跳转到编号为 2 的 Tab 页
    goto_tab3 = "<Leader>3",                   -- 跳转到编号为 3 的 Tab 页
    goto_tab4 = "<Leader>4",                   -- 跳转到编号为 4 的 Tab 页
    goto_tab5 = "<Leader>5",                   -- 跳转到编号为 5 的 Tab 页
    goto_tab6 = "<Leader>6",                   -- 跳转到编号为 6 的 Tab 页
    goto_left_tab = "<Leader>h",               -- 跳转到左边的 Tab 页
    goto_right_tab = "<Leader>l",              -- 跳转到右边 Tab 页

    close_current_tab = "<Leader><backspace>", -- 关闭当前 Tab 页
    close_other_tab = "<Leader><down>",        -- 关闭其他 Tab 页
    close_left_tab = "<Leader><left>",         -- 关闭左侧 Tab 页
    close_right_tab = "<Leader><right>",       -- 关闭右侧 Tab 页

    word_highlight = "<Leader>f",
    word_cancel_highlight = "<Leader>F",

    open_git_blame = "<esc>v",  -- 打开 git blame 面板
    open_todo = "<esc>t", -- 打开 todo 列表
    open_terminal = "<esc>\\",

    open_commander = "<esc>p", -- 打开自定义快捷命令面板
    exec_run_command = "<F5>", -- 执行项目 Run 命令
    exec_build_command = "<F4>", -- 执行项目 Build 命令
    exec_release_command = "<F10>", -- 执行项目打包命令

    find_file = "<esc>o", -- 查找文件
    find_file_hisotry = "<esc>h", -- 查看文件本地变更历史
    find_string = "<C-F>", -- 全局搜索字符串

    goto_next_problem =  '<A-n>', -- 跳转到当前文件中下一个代码有问题的地方
    goto_definition =  'gd', -- 跳转到函数或变量定义的地方
    go_back = "gb", -- 跳回跳转前的地方
    goto_class_definition = 'gc', -- 跳转到类定义的地方

    goto_preview = 'gp', -- 显示函数预览
    close_preview = "<esc>",

    find_usage = "gu", -- 查看函数或变量的引用
    usage_jump = "<CR>",
    usage_edit = "<Tab>",
    close_find_usage = "<esc>",

    find_implement = "gi", -- 查看接口的继承
    code_action = "<A-Enter>", -- 列举修复建议
    close_code_action = "<esc>",
    code_action_confirm = "<CR>",
    code_complete = "<A-Enter>", -- [normal] 列举自动补全项
    complete_confirm_or_jump_next_slot = "<Tab>",
    complete_confirm = "<CR>",
    refactor_name = '<s-r>', -- [insert]变量或函数重命名
    refactor_confirm = "<CR>",
    close_refactor = "<esc>",

    format_file = "<C-A-L>", -- 格式化文件
    goto_test_file = "gt",
    goto_source_file = "gs",
    goto_header_file = "gh",
    goto_vsc_diff = "gv",  -- git 变更预览

    comment_current_line = "<C-_>", -- 注释当前行，并将光标移动到下一行
    comment_block = "<C-_>", -- 注释当前选中块

    increase_vis_block = "v", -- 扩大当前选中块
    decrease_vis_block = "V", -- 缩小当前选中块

    switch_file_explorer_and_editor = '<C-e>',
    file_explorer_preview = '<Tab>',
    file_explorer_edit = '<CR>',
    file_explorer_close_parent_dir = 'zc',
    file_explorer_close_all_dir = 'xx',
    file_explorer_create = 'nn',
    file_explorer_goto_parent = 'gg',
    file_explorer_rename = 'rr',
    file_explorer_remove = 'DD',
    file_explorer_trash = 'dd',
    file_explorer_copy = 'yy',
    file_explorer_cut = 'cc',
    file_explorer_paste = 'p',
    file_explorer_show_info = '?',
    file_explorer_reload = 'R',

    open_outline = '<esc>[]',
    close_outline = '<esc>',
    outline_goto_next_line = 'j',
    outline_goto_prev_line = 'k',
    goto_prev_object = '[',
    goto_next_object = ']',

    add_or_remove_bookmark = "mm",
    edit_bookmark = "mi",
    remove_curr_buf_bookmark = "dm",
    list_all_bookmarks = "<esc>m",

    leap_jump_forward = "s",
    leap_jump_backward = "S",
}

function M.map2fun(mode, key, fun, opt)
    opt = opt or { noremap = true, silent = true }
    vim.keymap.set(mode, key, fun, opt)
end

function M.map2cmd(mode, key, cmd, opt)
    opt = opt or { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, key, cmd, opt)
end

function M.init()

    vim.g.mapleader = " "    -- Leader Key 设置为空格
    vim.g.maplocalleader = " "
    vim.opt.timeoutlen = 400       -- leader & esc 等待延迟时长(ms)
    M.map2cmd("n", "<Space>", "") -- 关闭空格键的移动, 仅作为 Leader 键

    M.map2cmd("n", "j", "gj")
    M.map2cmd("n", "k", "gk")
    M.map2cmd("n", "$", "g$")
    M.map2cmd("n", "0", "g0")
    M.map2cmd("n", "qq", '<CMD>wqall<CR>')

end

return M

