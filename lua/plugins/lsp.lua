return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x', -- Or your preferred stable branch
  event = { "BufReadPre", "BufNewFile" }, -- Load early for LSP functionality
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' },
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
      -- LuaSnip usually loads with nvim-cmp or on InsertEnter
    },

    -- nvim-navic for breadcrumbs in statusline (if lualine uses it)
    { "SmiteshP/nvim-navic" },

    -- Optional: jdtls (if you want to manage it as part of this larger LSP group)
    -- Or it can be its own plugin spec in a java specific file.
    -- { 'mfussenegger/nvim-jdtls', ft = { 'java' } }
  },
  config = function()
    local lsp_zero = require('lsp-zero')
    lsp_zero.extend_lspconfig() -- Extends nvim-lspconfig capabilities

    -- Keymaps and diagnostics setup (from your original file)
    lsp_zero.on_attach(function(client, bufnr)
      local navic_ok, navic = pcall(require, "nvim-navic")
      if navic_ok and client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end

      local opts = { buffer = bufnr, remap = false, silent = true }
      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
      vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
      vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
      vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next({ float = false }) end, opts) -- Added float = false for consistency
      vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev({ float = false }) end, opts) -- Added float = false
      vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
      vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
      vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
      vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

      vim.keymap.set({ "n", "x" }, "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    end)

    -- Mason setup
    require('mason').setup({}) -- Basic setup, lsp-zero may handle some of this.

    -- Mason-lspconfig setup
    require('mason-lspconfig').setup({
      ensure_installed = {
        'lua_ls',
        'jdtls',    -- For Java
        'rust_analyzer', -- For Rust
        'pyright',  -- For Python (or pylsp)
        'eslint', -- For TypeScript/JavaScript (ensure this is the LSP, e.g., eslint-lsp, if you also want tsserver, add it)
        'marksman', -- For Markdown
        -- Add other LSPs: 'gopls', 'clangd', 'bashls', 'tsserver', etc.
      },
      handlers = {
        lsp_zero.default_setup_servers, -- This handles most LSP server setups
      }
    })

    -- nvim-cmp setup is now largely automatic with lsp-zero v3.x.
    -- The lsp_zero.setup_nvim_cmp() function has been removed.
    -- lsp-zero will apply its default configurations for nvim-cmp.
    -- If you need further customization, you would call require('cmp').setup({ ... })
    -- directly, potentially using helpers like require('lsp-zero').cmp_action()
    -- for mappings. See :help lsp-zero-guide:customize-nvim-cmp


    -- Diagnostics configuration (from your original file)
    vim.diagnostic.config({
      virtual_text = true,
      signs = { -- Configure diagnostic signs
        text = {
          [vim.diagnostic.severity.ERROR] = "✘",
          [vim.diagnostic.severity.WARN]  = "▲",
          [vim.diagnostic.severity.HINT]  = "⚑",
          [vim.diagnostic.severity.INFO]  = "",
        },
        -- Standard highlight groups (DiagnosticSignError, etc.) will be used by default.
        -- numhl = "" behavior (no number column highlight for these signs) is also default.
      },
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always", -- Or "if_many"
        header = "",
        prefix = "",
      },
    })

    -- The old sign definition loop has been removed as it's deprecated.
    -- The signs are now configured above in vim.diagnostic.config().

    -- JDTLS specific setup (from your autocommand)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'java',
      group = vim.api.nvim_create_augroup("UserLspJavaJdtlsSetup", { clear = true }),
      callback = function(args)
        local jdtls_ok, jdtls = pcall(require, 'jdtls')
        if not jdtls_ok then
          vim.notify("jdtls module not found for Java setup", vim.log.levels.WARN)
          return
        end

        local mason_packages_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
        local jdtls_plugins_path = vim.fn.glob(mason_packages_path .. '/plugins/org.eclipse.equinox.launcher_*.jar', true, true)
        local jdtls_config_path = mason_packages_path .. '/config_linux' -- Adjust for OS: config_mac or config_win

        if vim.tbl_isempty(jdtls_plugins_path) then
            vim.notify("JDTLS launcher JAR not found in mason packages. Path: " .. mason_packages_path .. '/plugins/', vim.log.levels.ERROR)
            return
        end
        local jdtls_launcher_jar = jdtls_plugins_path[1]


        local workspace_dir = vim.fn.stdpath('data') .. '/jdtls_ws/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
        vim.fn.mkdir(workspace_dir, "p")

        local root_markers = { 'gradlew', 'mvnw', '.git' }
        local root_dir = require('jdtls.setup').find_root(root_markers)
        if root_dir == nil then
          vim.notify("JDTLS: No project root found (gradlew, mvnw, .git). Using current directory.", vim.log.levels.INFO)
          root_dir = vim.fn.getcwd()
        end
        
        local java_home = vim.env.JAVA_HOME or '/usr/lib/jvm/java-17-openjdk' -- Update this default
        if vim.fn.isdirectory(java_home) == 0 then
            vim.notify("JAVA_HOME (" .. java_home .. ") is not a valid directory. JDTLS might fail.", vim.log.levels.WARN)
        end


        local config = {
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
          settings = {
            java = {
              home = java_home,
              format = {
                enabled = true,
              },
            }
          },
          init_options = {
            bundles = {},
            extendedClientCapabilities = vim.tbl_deep_extend('force', {}, require('jdtls').extendedClientCapabilities, {
                progressReportProvider = false,
            }),
          },
          on_attach = function(c, b)
            lsp_zero.on_attach(c, b)
            -- require('jdtls').setup_dap({ hotcodereplace = 'auto' })
            -- require('jdtls.dap').setup_dap_main_class_configs()
          end,
        }

        local clients = vim.lsp.get_active_clients({ bufnr = args.buf, name = "jdtls" })
        if not vim.tbl_isempty(clients) then
          vim.notify("JDTLS already attached for " .. vim.fn.pathshorten(root_dir), vim.log.levels.DEBUG)
          return
        end

        vim.notify("Starting JDTLS for: " .. vim.fn.pathshorten(root_dir), vim.log.levels.INFO)
        jdtls.start_or_attach(config)
      end
    })
  end,
}
