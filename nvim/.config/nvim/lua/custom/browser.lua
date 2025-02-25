local M = {}
local path_utils = require("custom.path_utils")

local function open_browser(target_path)
    local cmd

    -- 判断路径类型
    cmd = { "x-www-browser", target_path }

    vim.fn.jobstart(cmd, {
        detach = true,
        on_exit = function(_, code)
            if code ~= 0 then
                vim.notify("打开失败，错误码: " .. code, vim.log.levels.ERROR)
            end
        end,
    })
end

function M.open_html()
    local file_path = vim.fn.expand("%:p")
    if file_path == "" then
        vim.notify("文件未保存", vim.log.levels.WARN)
        return
    end

    -- 智能路径转换
    local target_path = path_utils.convert_wsl_path(file_path)
    open_browser(target_path)
end

return M
