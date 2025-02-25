-- 文件路径转换工具 (保存为 ~/.config/nvim/lua/custom/path_utils.lua)
local M = {}

-- 获取 WSL 发行版名称 (动态适配)
local function get_wsl_distro()
    -- 手动指定发行版名称（如果动态获取失败）
    -- return "Debian"  -- 例如：你的 WSL 名称
    local handle = io.popen('wsl -l -q | findstr /B "*"')
    local result = handle:read("*a")
    handle:close()
    return result:match("%*%s+(%S+)") or "Debian" -- 默认值
end

-- 主转换函数
function M.convert_wsl_path(linux_path)
    -- 类型 1: /mnt/c/... → C:\...
    if linux_path:match("^/mnt/[cd]/") then
        return linux_path:gsub("^/mnt/(%a)/", "%1:\\"):gsub("/", "\\")

    -- 类型 2: /root/... → file://wsl.localhost/Debian/root/...
    else
        local distro = get_wsl_distro()
        return "file://wsl.localhost/" .. distro .. linux_path:gsub(" ", "%%20")
    end
end

return M
