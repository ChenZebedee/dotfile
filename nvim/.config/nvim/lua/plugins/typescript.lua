return {
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        opts = {
            settings = {
                expose_as_code_action = "all",
                tsserver_file_preferences = {
                    includeInlayParameterNameHints = "all",
                    includeCompletionsForModuleExports = true,
                },
            },
            on_attach = function(client, bufnr)
                -- 自定义 on_attach 逻辑（如绑定 LSP 快捷键）
            end,
        },
    },
}
