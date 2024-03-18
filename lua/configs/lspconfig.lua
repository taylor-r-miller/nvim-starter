local configs = require("nvchad.configs.lspconfig")
local util = require"lspconfig/util"
local lspconfig = require "lspconfig"
local map = vim.keymap.set

local conf = require("chadrc").ui.lsp

function go_attach (client, bufnr)

  local function opts(desc)
    return { buffer = bufnr, desc = desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Lsp Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Lsp Go to definition")
  map("n", "K", vim.lsp.buf.hover, opts "Lsp hover information")
  map("n", "gi", vim.lsp.buf.implementation, opts "Lsp Go to implementation")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Lsp Show signature help")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Lsp Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Lsp Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "Lsp List workspace folders")

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Lsp Go to type definition")

  map("n", "<leader>ra", function()
    require "nvchad.lsp.renamer"()
  end, opts "Lsp NvRenamer")

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Lsp Code action")
  map("n", "gr", vim.lsp.buf.references, opts "Lsp Show references")

  -- setup signature popup
  if conf.signature and client.server_capabilities.signatureHelpProvider then
    require("nvchad.lsp.signature").setup(client, bufnr)
  end

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
  html = {},
  cssls = {},
  tsserver = {},
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
  }
}

for name, opts in pairs(servers) do
  opts.on_init = configs.on_init
  opts.on_attach = configs.on_attach
  opts.capabilities = configs.capabilities

  if name == 'gopls' then
    opts.on_attach = go_attach
  end

  lspconfig[name].setup(opts)
end


-- Without the loop, you would have to manually set up each LSP 
-- 
-- lspconfig.html.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
--
-- lspconfig.cssls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }


