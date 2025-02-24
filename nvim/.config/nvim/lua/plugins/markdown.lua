-- local function generate_or_update_toc()
--     -- 获取当前缓冲区所有行
--     local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
--
--     -- 查找现有的 TOC 标记位置
--     local toc_start, toc_end = -1, -1
--     for i, line in ipairs(lines) do
--         if line:match("^<!-- TOC -->") then
--             toc_start = i
--         elseif line:match("^<!-- /TOC -->") then
--             toc_end = i
--             break
--         end
--     end
--
--     -- 生成新的 TOC 内容
--     local new_toc = { "<!-- TOC -->" }
--     for _, line in ipairs(lines) do
--         local level, title = line:match("^(#+)%s+(.+)")
--         if level and title then
--             local indent = string.rep("  ", #level - 1)
--             local anchor = title:lower():gsub("%s+", "-"):gsub("[^%w-]", "")
--             table.insert(new_toc, indent .. "- [" .. title .. "](#" .. anchor .. ")")
--         end
--     end
--     table.insert(new_toc, "<!-- /TOC -->")
--
--     -- 替换旧 TOC 或插入新 TOC
--     if toc_start ~= -1 and toc_end ~= -1 then
--         -- 删除旧 TOC
--         vim.api.nvim_buf_set_lines(0, toc_start - 1, toc_end, false, {})
--         -- 插入新 TOC
--         vim.api.nvim_buf_set_lines(0, toc_start - 1, toc_start - 1, false, new_toc)
--     else
--         -- 插入新 TOC 到当前光标位置
--         local row = vim.api.nvim_win_get_cursor(0)[1]
--         vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, new_toc)
--     end
-- end
--
-- -- 设置快捷键
-- vim.keymap.set("n", "<leader>mt", generate_or_update_toc, { desc = "Generate/Update TOC" })

return {
    {
        "ellisonleao/glow.nvim",
        config = function()
            require("glow").setup({
                style = "dark", -- 主题风格：dark/light
                width = 120, -- 预览窗口宽度
                border = "rounded", -- 窗口边框样式
            })
        end,
        cmd = "Glow",
        ft = "markdown",
        lazy = true,
    },
}
