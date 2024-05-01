local configs = require("nvchad.configs.lspconfig")
local util = require"lspconfig/util"
local lspconfig = require "lspconfig"

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities



local go_attach = function (client, bufnr)

  on_attach(client,bufnr)

  if not client.server_capabilities.semanticTokensProvider then
    local semantic = client.config.capabilities.textDocument.semanticTokens
    client.server_capabilities.semanticTokensProvider = {
      full = true,
      legend = {tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes},
      range = true,
    }
  end
end



local servers = {
  html = {
    filetypes = { "html", "templ" },
  },
  cssls = {},
  tsserver = {
    init_options = {
      preferences = {
        disableSuggestions = true
      }
    }
  },
  eslint = {},
  clangd = {},
  pyright = {},
  gopls = {
    cmd = {"gopls"},
    filetypes = {"go","gomod","gowork","gotmpl"},
    root_dir = util.root_pattern("go.work","go.mod",".git"),
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        semanticTokens = true,
        analyses = {
          unusedparams = true
        }
     }
    }
  },
  templ = {},
  htmx = {
    filetypes = { "html", "templ" },
  },
  tailwindcss = {
    filetypes = { "templ", "javascriptreact", "typescriptreact", "react", "html" },
    init_options = { userLanguages = { templ = "html" } },
  }
}

for name, opts in pairs(servers) do
  opts.on_init = on_init
  opts.on_attach = on_attach
  opts.capabilities = capabilities

  if name == 'gopls' then
    opts.on_attach = go_attach
  end

  lspconfig[name].setup(opts)

end

