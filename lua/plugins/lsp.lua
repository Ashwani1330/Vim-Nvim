return {
  {
    'neovim/nvim-lspconfig', -- Main plugin for this configuration block
    event = { "BufReadPre", "BufNewFile" }, -- Load early for LSP functionality
    dependencies = {
      -- LSP Support
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' }, -- Integrates LuaSnip with nvim-cmp
      { 'hrsh7th/cmp-nvim-lua' },   -- For Lua completion

      -- Snippets
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*", -- Pin to a version for stability
        dependencies = { "rafamadriz/friendly-snippets" }, -- Optional: if you want more snippets
        build = "make install_jsregexp", -- If still required by LuaSnip
      },

      -- nvim-navic for breadcrumbs in statusline
      { "SmiteshP/nvim-navic" },

      -- Optional: for icons in completion menu
      { 'onsails/lspkind.nvim' },
    },
    config = function()
      local lspconfig = require('lspconfig')
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      -- LSP Capabilities
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- LSP Keymaps (on LspAttach)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspAttach', {clear = true}),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local bufnr = event.buf
          local opts = { buffer = bufnr, remap = false, silent = true }

          -- Attach nvim-navic if available and server supports document symbols
          if client and client.server_capabilities.documentSymbolProvider then
            local navic_ok, navic = pcall(require, "nvim-navic")
            if navic_ok then
              navic.attach(client, bufnr)
            end
          end

          vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
          vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
          vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
          vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
          vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next({}) end, opts)
          vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev({}) end, opts)
          vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
          vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
          vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
          vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
          vim.keymap.set({ "n", "x" }, "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        end,
      })

      -- Mason Setup
      require('mason').setup({})

      -- Mason-LSPConfig Setup
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',
          'jdtls',
          'rust_analyzer',
          'pyright',
          'eslint',
          'marksman',
          -- Add other LSPs: 'gopls', 'clangd', 'bashls', etc.
        },
        handlers = {
          -- Default handler for most servers
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
              -- on_attach will trigger the LspAttach autocommand
            })
          end,
          -- Custom handler for lua_ls
          lua_ls = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = { version = 'LuaJIT' },
                  diagnostics = { globals = {'vim'} },
                  workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                  telemetry = { enable = false },
                }
              }
            })
          end,
        }
      })

      -- nvim-cmp Setup
      local cmp_select_opts = {behavior = cmp.SelectBehavior.Select}
      cmp.setup({
        sources = cmp.config.sources({
          {name = 'nvim_lsp'},
          {name = 'luasnip'},
          {name = 'buffer'},
          {name = 'path'},
          {name = 'nvim_lua'},
        }),
        mapping = {
          ['<CR>'] = cmp.mapping.confirm({select = true}),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select_opts),
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select_opts),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item(cmp_select_opts)
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item(cmp_select_opts)
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        -- Optional: If you've installed 'onsails/lspkind.nvim'
        formatting = {
          fields = {'menu', 'abbr', 'kind'},
          format = require('lspkind').cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
          })
        },
      })

      -- Diagnostics Configuration
      vim.diagnostic.config({
        virtual_text = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN] = '▲',
            [vim.diagnostic.severity.HINT] = '⚑',
            [vim.diagnostic.severity.INFO] = '',
          },
        },
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

      -- JDTLS specific setup (using lspconfig directly, no require('jdtls'))
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'java',
        group = vim.api.nvim_create_augroup("UserLspJavaJdtlsSetup", { clear = true }),
        callback = function(args)
          local lspconfig_util_ok, lspconfig_util = pcall(require, 'lspconfig.util')
          -- capabilities variable should be in scope from your main config function

          local mason_packages_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
          local jdtls_plugins_path = vim.fn.glob(mason_packages_path .. '/plugins/org.eclipse.equinox.launcher_*.jar', true, true)

          local jdtls_config_dir_name
          if vim.fn.has("win32") == 1 then
            jdtls_config_dir_name = 'config_win'
          elseif vim.fn.has("macunix") == 1 then
            jdtls_config_dir_name = 'config_mac'
          else
            jdtls_config_dir_name = 'config_linux'
          end
          local jdtls_config_path = mason_packages_path .. '/' .. jdtls_config_dir_name

          if vim.tbl_isempty(jdtls_plugins_path) then
            vim.notify("JDTLS launcher JAR not found in Mason. Path: " .. mason_packages_path .. '/plugins/', vim.log.levels.ERROR)
            return
          end
          local jdtls_launcher_jar = jdtls_plugins_path[1]

          local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
          -- Ensure unique workspace_dir per project to avoid conflicts
          local workspace_dir = vim.fn.stdpath('data') .. '/jdtls_ws/' .. project_name .. "_" .. vim.fn.sha1(vim.fn.getcwd())
          vim.fn.mkdir(workspace_dir, "p")

          local root_dir
          if lspconfig_util_ok then
            -- Try to find root using common Java project markers for the current buffer's file
            root_dir = lspconfig_util.root_pattern('gradlew', 'mvnw', '.git')(args.file or vim.api.nvim_buf_get_name(args.buf))
          end

          if not root_dir then
            -- Fallback root directory logic if specific markers not found or lspconfig.util fails
            local current_file_path = args.file or vim.api.nvim_buf_get_name(args.buf)
            local file_dir = vim.fn.fnamemodify(current_file_path, ":h")
            local git_ancestor = lspconfig_util_ok and lspconfig_util.find_git_ancestor(file_dir)
            if git_ancestor then
              root_dir = vim.fs.dirname(git_ancestor)
            else
              root_dir = vim.fn.getcwd() -- Fallback to CWD if no better root found
            end
            vim.notify("JDTLS: No primary project markers (gradlew, mvnw) found near " .. current_file_path .. ". Using root: " .. root_dir, vim.log.levels.INFO)
          end

          local java_home = vim.env.JAVA_HOME or "C:\\Program Files\\Eclipse Adoptium\\jdk-21.0.7.6-hotspot\\" -- Your detected JAVA_HOME
          if vim.fn.isdirectory(java_home) == 0 then
            vim.notify("JAVA_HOME ('" .. java_home .. "') is not a valid directory. JDTLS might fail.", vim.log.levels.WARN)
          end

          local jdtls_setup_params = {
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
              '-jar', jdtls_launcher_jar,
              '-configuration', jdtls_config_path,
              '-data', workspace_dir,
            },
            root_dir = root_dir,
            capabilities = capabilities, -- Ensure 'capabilities' is defined in the outer scope of your config function
            settings = {
              java = {
                home = java_home,
                format = { enabled = true },
                -- If you need to set specific `extendedClientCapabilities` that JDTLS understands
                -- without the nvim-jdtls plugin, you'd define them here or in init_options.
                -- For example, if JDTLS supports disabling progress reports via a standard capability:
                -- extendedClientCapabilities = { progressReportProvider = false } -- This is hypothetical here
              }
            },
            init_options = {
              bundles = {},
              -- The `extendedClientCapabilities` from `nvim-jdtls` provided more complex structures.
              -- We're keeping this simpler. `progressReportProvider = false` was in your original config.
              -- We can try setting it if it's a standard initOption.
              -- extendedClientCapabilities = { progressReportProvider = false }
            },
            on_attach = function(client_attached, bufnr_attached)
              -- The global LspAttach autocommand (defined elsewhere in your config)
              -- will handle the common keymappings.
              -- You can add JDTLS-specific on_attach logic here if needed.
              -- vim.notify("JDTLS (lspconfig) attached. Client: " .. client_attached.id .. " to buffer " .. bufnr_attached, vim.log.levels.INFO)
            end,
          }

          -- This check helps prevent multiple JDTLS instances if the autocommand were to trigger unexpectedly multiple times.
          -- Given the mason-lspconfig handler for jdtls is set to 'do nothing', this autocommand
          -- should be the sole explicit starter for your custom JDTLS.
          local active_clients = vim.lsp.get_active_clients({ bufnr = args.buf, name = "jdtls" })
          if not vim.tbl_isempty(active_clients) then
            vim.notify("JDTLS client(s) already active for this buffer. Count: " .. #active_clients .. ". Skipping new JDTLS start from autocommand.", vim.log.levels.DEBUG)
            return
          end

          vim.notify("Configuring JDTLS via lspconfig for root: " .. vim.fn.pathshorten(root_dir or "unknown_root"), vim.log.levels.INFO)
          require('lspconfig').jdtls.setup(jdtls_setup_params)
        end
      })
    end,
  }
}
