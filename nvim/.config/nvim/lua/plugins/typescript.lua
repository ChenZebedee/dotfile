return {
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        ft = { "typescript", "typescriptreact" }, -- 仅针对 TypeScript 文件加载
        opts = {
            -- 自定义配置（可选）
        },
    },
}
