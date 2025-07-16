return {
  setup = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    vim.lsp.enable('dockerls')
    vim.lsp.enable('docker_compose_language_service')
    vim.lsp.enable('docker_language_service')
    vim.lsp.enable('lua_ls')
    vim.lsp.enable('nil_ls')
    vim.lsp.enable('eslint')
    vim.lsp.enable('eslint_d')
    vim.lsp.enable('html')
    vim.lsp.enable('cssls')
    vim.lsp.enable('vue_ls')
    vim.lsp.enable('phpactor')
    -- vim.lsp.enable('intelephense')
    vim.lsp.enable('sqls')
    vim.lsp.enable('csharp_ls')
    vim.lsp.enable('omnisharp')
    vim.lsp.enable('clangd')
    vim.lsp.enable('rust_analyzer')
    -- vim.lsp.enable('r_language_server')
    vim.lsp.enable('bashls')


    -- docker
    vim.lsp.config('dockerls',{
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "dockerfile", "docker-compose" },
      root_dir = lspconfig.util.root_pattern("Dockerfile", "docker-compose.yml"),
    })
    vim.lsp.config('docker_compose_language_service',{
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "docker-compose" },
      root_dir = lspconfig.util.root_pattern("docker-compose.yml"),
    })
    vim.lsp.config('docker_language_service',{
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "dockerfile" },
      root_dir = lspconfig.util.root_pattern("Dockerfile"),
    })
    -- lua
    vim.lsp.config('lua_ls',{
    	on_attach = on_attach,
    	capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      }
    })
    -- nix
    vim.lsp.config('nil_ls',{
    	on_attach = on_attach,
    	capabilities = capabilities,
    })
    -- web-dev stuffs
    vim.lsp.config('eslint',{
    	on_attach = on_attach,
    	capabilities = capabilities,
    })
    vim.lsp.config('eslint_d',{
      on_attach = on_attach,
      capabilities = capabilities,
    })
    vim.lsp.config('html',{
    	on_attach = on_attach,
    	capabilities = capabilities,
    })
    vim.lsp.config('cssls',{
    	on_attach = on_attach,
    	capabilities = capabilities,
    })
    vim.lsp.config('vue_ls',{
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      init_options = {
        vue = {
          hybridMode = false,
        },
        typescript = {
          tsdk = 'node_modules/typescript/lib',
        },
      },
      on_new_config = function(new_config, new_root_dir)
        local lib_path = vim.fs.find('node_modules/typescript/lib', { path = new_root_dir, upward = true })[1]
        if lib_path then
          new_config.init_options.typescript.tsdk = lib_path
        end
      end
    })
    vim.lsp.config('phpactor',{
    	on_attach = on_attach,
    	capabilities = capabilities,
    })
    --[[ vim.lsp.config('intelephense',{
    	on_attach = on_attach,
    	capabilities = capabilities,
    }) ]]
    vim.lsp.config('sqls',{
    	on_attach = on_attach,
    	capabilities = capabilities,
    	cmd = { "sqls" },
    	filetypes = { "sql", "mysql", "pgsql", "sqlite" },
    	settings = {
    	  sqls = {
    	    connections = {
    	      {
    	      	driver = "mysql",
    	      	-- dataSourceName = "root:root@tcp(127.0.0.1:13306)/world",
    	      },
    	      --[[ {
    	      	driver = "postgresql",
    	      	dataSourceName = "host=127.0.0.1 port=15432 user=postgres password=mysecretpassword1234 dbname=dvdrental sslmode=disable",
    	      }, ]]
    	    },
    	  },
    	},
    })
    -- c# stuff
    vim.lsp.config('csharp_ls',{
    	on_attach = on_attach,
    	capabilities = capabilities,
    })
    vim.lsp.config('omnisharp',{
    	on_attach = on_attach,
    	capabilities = capabilities,
    })
    -- c and c++ stuff
    vim.lsp.config('clangd',{
    	on_attach = on_attach,
    	capabilities = capabilities,
    })
    -- rust
    vim.lsp.config('rust_analyzer',{
    	on_attach = on_attach,
    	capabilities = capabilities,
    })
    -- r
    -- vim.lsp.config('r_language_server',{
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    -- })
    -- scripting
    vim.lsp.config('bashls',{
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        bashIde = {
          enable = true,
          shellcheck = {
            enable = true,
          },
        },
      },
    })
    
    vim.diagnostic.enable()
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = false,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
    
    vim.keymap.set("n", "<Leader>cd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<Leader>ci", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<Leader>cr", vim.lsp.buf.references, {})
    vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, {})
  end
}
