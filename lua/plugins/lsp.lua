return {
  {
    'neovim/nvim-lspconfig', -- Main plugin for this configuration block
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- LSP Support (loaded with lspconfig)
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion (loaded with lspconfig)
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },

      -- Snippets (loaded with lspconfig)
      { "L3MON4D3/LuaSnip", version = "v2.*" },

      -- LAZY LOADED DEPENDENCIES --
      { 'hrsh7th/cmp-buffer', lazy = true },
      { 'hrsh7th/cmp-path', lazy = true },
      { 'saadparwaiz1/cmp_luasnip', lazy = true },
      { 'hrsh7th/cmp-nvim-lua', lazy = true },
      { "rafamadriz/friendly-snippets", lazy = true },
      { "SmiteshP/nvim-navic", lazy = true },
      { 'onsails/lspkind.nvim', lazy = true },
    },
    config = function()

      -- DIAGNOSTICS CONFIGURATION (OPTIMIZED)
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false, -- Only update diagnostics when you exit insert mode
        severity_sort = true,
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require('lspconfig')
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      -- GENERAL LSP KEYMAPS (on LspAttach)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspAttach', { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local bufnr = event.buf
          local opts = { buffer = bufnr, remap = false, silent = true }

          -- Keymaps
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
          vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)

          -- Attach nvim-navic
          if client and client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
          end
        end,
      })

      -- OMNISHARP/CSHARP-LS (FOR UNITY) OPTIMIZATIONS
      local unity_root_markers = { 'Assets', 'ProjectSettings', 'Packages' }
      local csharp_root_dir = require('lspconfig.util').root_pattern(unpack(unity_root_markers))


      -- MASON SETUP
      require('mason').setup({
        ui = {
          check_outdated_packages_on_open = false,
        },
      })

      -- MASON-LSPCONFIG SETUP
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',
          'csharp_ls',
          'pyright',
          'eslint',
          'jdtls', -- Ensure jdtls is installed by Mason
        },
        handlers = {
          -- Default handler for servers without custom setups
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,

          -- Prevent mason-lspconfig from starting jdtls; we do it manually
          jdtls = function() end,

          -- Custom handler for csharp_ls (Unity)
          csharp_ls = function()
            lspconfig.csharp_ls.setup({
              capabilities = capabilities,
              root_dir = csharp_root_dir,
              settings = {
                CSharp = {
                  analysis = {
                    exclude = {
                      "**/[Oo]bj/**", "**/[Bb]in/**", "**/[Ll]ibrary/**",
                      "**/[Tt]emp/**", "**/.vs/**", "**/*.meta",
                    },
                  },
                },
              },
            })
          end,

          -- Custom handler for lua_ls
          lua_ls = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = { version = 'LuaJIT' },
                  diagnostics = { globals = { 'vim' } },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    maxPreload = 2000,
                    preloadFileSize = 1000,
                  },
                  telemetry = { enable = false },
                }
              }
            })
          end,
        }
      })

      -- NVIM-CMP SETUP
      cmp.setup({
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = require('lspkind').cmp_format({
            maxwidth = 50,
            ellipsis_char = '...',
          })
        },
      })


      -- JDTLS specific setup
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'java',
        group = vim.api.nvim_create_augroup("UserLspJavaJdtlsSetup", { clear = true }),
        callback = function(args)
          -- The rest of your excellent JDTLS setup remains exactly the same.
          -- It will now be the *only* thing that starts the jdtls server.
          local lspconfig_util_ok, lspconfig_util = pcall(require, 'lspconfig.util')
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
            vim.notify("JDTLS launcher JAR not found in Mason.", vim.log.levels.ERROR)
            return
          end
          local jdtls_launcher_jar = jdtls_plugins_path[1]
          local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
          local workspace_dir = vim.fn.stdpath('data') .. '/jdtls_ws/' .. project_name .. "_" .. vim.fn.sha1(vim.fn.getcwd())
          vim.fn.mkdir(workspace_dir, "p")
          local root_dir
          if lspconfig_util_ok then
            root_dir = lspconfig_util.root_pattern('gradlew', 'mvnw', '.git')(args.file or vim.api.nvim_buf_get_name(args.buf))
          end
          if not root_dir then
            local current_file_path = args.file or vim.api.nvim_buf_get_name(args.buf)
            local file_dir = vim.fn.fnamemodify(current_file_path, ":h")
            local git_ancestor = lspconfig_util_ok and lspconfig_util.find_git_ancestor(file_dir)
            if git_ancestor then
              root_dir = vim.fs.dirname(git_ancestor)
            else
              root_dir = vim.fn.getcwd()
            end
            vim.notify("JDTLS: No primary project markers found. Using root: " .. root_dir, vim.log.levels.INFO)
          end
          local java_home = vim.env.JAVA_HOME or "C:\\Program Files\\Eclipse Adoptium\\jdk-21.0.7.6-hotspot\\"
          if vim.fn.isdirectory(java_home) == 0 then
            vim.notify("JAVA_HOME ('" .. java_home .. "') is not a valid directory.", vim.log.levels.WARN)
          end
          local jdtls_setup_params = {
            cmd = {
              'java', '-Declipse.application=org.eclipse.jdt.ls.core.id1',
              '-Dosgi.bundles.defaultStartLevel=4', '-Declipse.product=org.eclipse.jdt.ls.core.product',
              '-Dlog.protocol=true', '-Dlog.level=ALL', '-Xms1g', '--add-modules=ALL-SYSTEM',
              '--add-opens', 'java.base/java.util=ALL-UNNAMED', '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
              '-jar', jdtls_launcher_jar, '-configuration', jdtls_config_path, '-data', workspace_dir,
            },
            root_dir = root_dir,
            capabilities = capabilities,
            settings = { java = { home = java_home, format = { enabled = true } } },
            init_options = { bundles = {} },
            on_attach = function(client_attached, bufnr_attached)
              -- Global LspAttach handles common keymaps
            end,
          }
          local active_clients = vim.lsp.get_active_clients({ bufnr = args.buf, name = "jdtls" })
          if not vim.tbl_isempty(active_clients) then
            vim.notify("JDTLS client(s) already active. Skipping new start.", vim.log.levels.DEBUG)
            return
          end
          vim.notify("Configuring JDTLS for root: " .. vim.fn.pathshorten(root_dir or "unknown"), vim.log.levels.INFO)
          require('lspconfig').jdtls.setup(jdtls_setup_params)
        end
      })
    end,
  }
}
