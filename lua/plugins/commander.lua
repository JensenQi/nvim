-- 快捷命令插件
local keymap = require("keymap")
keymap.map2cmd("n", keymap.open_commander, "<CMD>Telescope commander<CR>")

local function execute(command)
    local terminal = require("toggleterm")
    terminal.exec_command("cmd='" .. command .. "'")
end

local function run_maven(_, filepath)
    if string.find(filepath, "src/main/java") then
        local class = filepath:match("src/main/java/(.+).java$"):gsub("/", ".")
        execute('mvn -q compile exec:java -Dexec.mainClass="' .. class .. '"')
    elseif string.find(filepath, "src/main/scala") then
        local class = filepath:match("src/main/scala/(.+).scala$"):gsub("/", ".")
        execute('mvn -q compile exec:java -Dexec.mainClass="' .. class .. '"')
    elseif string.find(filepath, "src/test/java") then
        local class = filepath:match("src/test/java/(.+).java$"):gsub("/", ".")
        execute('mvn test -Dtest="' .. class .. '"')
    elseif string.find(filepath, "src/test/scala") then
        local class = filepath:match("src/test/scala/(.+).scala$"):gsub("/", ".")
        execute('mvn test -Dtest="' .. class .. '"')
    end
end

local function run_gradle(_, filepath)
    if string.find(filepath, "src/main/java") then
        local class = filepath:match("src/main/java/(.+).java$"):gsub("/", ".")
        execute('./gradlew -PmainClass=' .. class .. ' run --warning-mode none')
    elseif string.find(filepath, "src/test/java") then
        local class = filepath:match("src/test/java/(.+).java$"):gsub("/", ".")
        execute('./gradlew -Dtest.single=' .. class .. ' test --warning-mode none')
    end
end


local function run_cmake(working_dir, filepath)
    local build_cmd = 'cmake -S . -B build && cmake --build build '
    local c_project = vim.fn.glob(working_dir .. "/app/*.c") ~= ""

    if string.find(filepath, "test/") then
        if c_project then
            if string.find(filepath, "test/test.c") then -- all unittest
                execute(build_cmd .. '&& ./build/test/testall')
            else
                local test_case = filepath:match("test/test_(.+).c$"):gsub("/", ".")
                execute("TESTCASE=test_" .. test_case .. " " .. build_cmd .. '&& ./build/test/testall')
            end
        else
            if string.find(filepath, "test/test.cpp") then -- all unittest
                execute(build_cmd .. '&& ./build/test/testall')
            else
                local test_case = filepath:match("test/test_(.+).cpp$"):gsub("/", ".")
                execute(build_cmd .. '&& ./build/test/testall --gtest_filter="*test_' .. test_case .. '*"')
            end
        end
    else
        local app_file = vim.fn.glob(working_dir .. "/app/*" .. (c_project and ".c" or ".cpp"))
        local app_name = app_file:gsub(working_dir, ""):match("app/(.+)%.c")
        execute(build_cmd .. '&& ./build/app/' .. app_name)
    end
end

local function run_cargo(working_dir, filepath)
    execute('cargo run')
end

local function run_python(working_dir, filepath)
    if string.find(filepath:gsub(working_dir, ""), "/tests") then
        local test_case = filepath:match("/tests/(.+)$")
        execute('python -m unittest tests/' .. test_case)
        return
    end

    execute('python ' .. vim.api.nvim_buf_get_name(0))
end

local function run_golang(working_dir, filepath)
    execute('go run ' .. filepath)
end

return {
    {
        os.getenv("ghproxy") .. "https://github.com/FeiyouG/commander.nvim.git",
        version = "*",
        dependencies = { os.getenv("ghproxy") .. "https://github.com/nvim-telescope/telescope.nvim.git" },
        config = function()
            local commander = require("commander")
            commander.setup({
                components = { "DESC", "KEYS", "CAT" },
                sort_by = { "DESC", "KEYS", "CAT", "CMD" },
                integration = {
                    telescope = { enable = true },
                    lazy = { enable = true, set_plugin_name_as_cat = true }
                }
            })
            commander.add({
                {
                    desc = " Build",
                    keys = { { "n", keymap.exec_build_command }, { "i", keymap.exec_build_command } },
                    cmd = function()
                        local working_dir = vim.loop.cwd()

                        if vim.fn.empty(vim.fn.glob(working_dir .. "/pom.xml")) == 0 then
                            execute("mvn clean build")
                        elseif vim.fn.empty(vim.fn.glob(working_dir .. "/CMakeLists.txt")) == 0 then
                            execute('cmake -S . -B build && cmake --build build')
                        elseif vim.fn.empty(vim.fn.glob(working_dir .. "/Cargo.toml")) == 0 then
                            execute("cargo build")
                        end
                    end
                },

                {
                    desc = " Run",
                    keys = { { "n", keymap.exec_run_command }, { "i", keymap.exec_run_command } },
                    cmd = function()
                        local working_dir = vim.loop.cwd()
                        local filepath = vim.api.nvim_buf_get_name(0)

                        if vim.fn.empty(vim.fn.glob(working_dir .. "/pom.xml")) == 0 then
                            run_maven(working_dir, filepath)
                        elseif vim.fn.empty(vim.fn.glob(working_dir .. "/build.gradle")) == 0 then
                            run_gradle(working_dir, filepath)
                        elseif vim.fn.empty(vim.fn.glob(working_dir .. "/pyproject.toml")) == 0 then
                            run_python(working_dir, filepath)
                        elseif vim.fn.empty(vim.fn.glob(working_dir .. "/CMakeLists.txt")) == 0 then
                            run_cmake(working_dir, filepath)
                        elseif vim.fn.empty(vim.fn.glob(working_dir .. "/go.mod")) == 0 then
                            run_golang(working_dir, filepath)
                        elseif vim.fn.empty(vim.fn.glob(working_dir .. "/Cargo.toml")) == 0 then
                            run_cargo(working_dir, filepath)
                        end
                    end
                },
                {
                    desc = " Release Package",
                    keys = { { "n", keymap.exec_release_command }, { "i", keymap.exec_release_command } },
                    cmd = function()
                        local working_dir = vim.loop.cwd()

                        if vim.fn.empty(vim.fn.glob(working_dir .. "/pom.xml")) == 0 then
                            execute("mvn clean package")
                        elseif vim.fn.empty(vim.fn.glob(working_dir .. "/pyproject.toml")) == 0 then
                            execute("poetry build")
                        elseif vim.fn.empty(vim.fn.glob(working_dir .. "/CMakeLists.txt")) == 0 then
                            local build_cmd = 'cmake -S . -B build && cmake --build build'
                            execute(build_cmd .. " && cpack --config build/CPackConfig.cmake")
                        elseif vim.fn.empty(vim.fn.glob(working_dir .. "/go.mod")) == 0 then
                            local binary_name = working_dir ~= nil and working_dir:match("^.+/(.+)$") or "main"
                            execute("go build -o dist/" .. binary_name .. " cmd/main.go")
                        elseif vim.fn.empty(vim.fn.glob(working_dir .. "/Cargo.toml")) == 0 then
                            execute("cargo build --release")
                        end
                    end

                }
            })
        end
    }
}
