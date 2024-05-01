local opts = {
    ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "prettier",
    "eslint-lsp",
    "eslintd",
    "htmx-lsp",
    "templ",
    "tailwindcss-language-server",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- shell stuff
    "shfmt",
    --go
    "gopls",
    "goimports",
    "gofumpt",
    "golines",

    -- python
    "pyright",
    "black",
    "mypy",

  },
}


return opts
