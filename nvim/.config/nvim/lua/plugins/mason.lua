return {
    "williamboman/mason.nvim",
    opts = {
        ensure_installed = {
            "black",
            "debugpy",
            "go-debug-adapter",
            "js-debug-adapter",
            "markdownlint-cli2",
            "pyright",
            "stylua",
            "vtsls",
            "checkstyle",
            "delve",
            "gofumpt",
            "json-lsp",
            "markdown-toc",
            -- "phpcs",
            -- "php-cs-fixer",
            -- "php-debug-adapter",
            -- "phpactor",
            "python-lsp-server",
            "tailwindcss-language-server",
            "vue-language-server",
            "clangd",
            "emmet-ls",
            "goimports",
            "lua-language-server",
            "marksman",
            "ruff",
            "taplo",
            "codelldb",
            "eslint-lsp",
            "gopls",
            "markdownlint",
            "pylint",
            "shfmt",
            "typescript-language-server",
            "prettier",
            "htmlbeautifier",
            -- 添加你在 :Mason 中看到的其他工具
        },
    },
    config = function(_, opts)
        require("mason").setup(opts)

        -- 获取已安装的包
        local registry = require("mason-registry")
        local installed_packages = registry.get_installed_package_names()

        -- 定义需要保留的包
        local desired_packages = opts.ensure_installed or {}

        -- 删除不在 ensure_installed 中的包
        for _, pkg_name in ipairs(installed_packages) do
            if not vim.tbl_contains(desired_packages, pkg_name) then
                local pkg = registry.get_package(pkg_name)
                print("Uninstalling " .. pkg_name)
                pkg:uninstall()
            end
        end

        -- 安装 ensure_installed 中的包
        require("mason-lspconfig").setup({ ensure_installed = desired_packages })
    end,
}
