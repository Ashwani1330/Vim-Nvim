local lsp_zero = require('lsp-zero')
local navic = require("nvim-navic")

lsp_zero.extend_lspconfig()

-- Mason setup
require('mason').setup({})

require('mason-lspconfig').setup({
  ensure_installed = {
    'lua_ls',
    'jdtls', -- Let mason install it, but custom config below
  },
  handlers = {
    lsp_zero.default_setup,
    function(server_name)
      if server_name ~= "jdtls" and server_name ~= "rust_analyzer" then
        require('lspconfig')[server_name].setup({})
      end
    end,
  }
})

-- CMP setup
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Diagnostic signs
local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "" }

for type, icon in pairs(signs) do
  local name = "DiagnosticSign" .. type
  vim.api.nvim_set_hl(0, name, { default = true, link = "Diagnostic" .. type })
  vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end

-- LSP keymaps
lsp_zero.on_attach(function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
  local opts = {buffer = bufnr, remap = false}
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- (Optional)
-- JDTLS Setup (Java)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  callback = function()
    -- local jdtls = require('jdtls')
    local ok, jdtls = pcall(require, 'jdtls')
    if not ok then return end  -- gracefully exit if jdtls is not available

    local jdtls_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
    local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    local root_markers = {'gradlew', 'mvnw', '.git'}
    local root_dir = require('jdtls.setup').find_root(root_markers)
    if root_dir == nil then return end

    jdtls.start_or_attach({
      cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
        '-configuration', jdtls_path .. '/config_linux', -- change if on Windows or macOS
        '-data', workspace_dir,
      },
      root_dir = root_dir,
      settings = {
        java = {
          home = '/usr/lib/jvm/java-17-openjdk', -- Adjust if different
          format = {
            enabled = true,
            settings = {
              url = vim.fn.stdpath('config') .. '/eclipse-java-google-style.xml',
              profile = 'GoogleStyle',
            }
          }
        }
      },
      init_options = {
        bundles = {}
      },
    })
  end
})