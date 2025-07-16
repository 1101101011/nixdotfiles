return {
  setup = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    -- lua
    lspconfig.lua_ls.setup({
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
    lspconfig.nil_ls.setup({
    	on_attach = on_attach,
    	capabilities = capabilities,
    })
    -- web-dev stuffs
    lspconfig.eslint.setup({
    	on_attach = on_attach,
    	capabilities = capabilities,
    })
    lspconfig.eslint_d.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    lspconfig.html.setup({
    	on_attach = on_attach,
    	capabilities = capabilities,
    })
    lspconfig.cssls.setup({
    	on_attach = on_attach,
    	capabilities = capabilities,
    })
    lspconfig.volar.setup ({
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
    lspconfig.phpactor.setup({
    	on_attach = on_attach,
    	capabilities = capabilities,
    })
    --[[ lspconfig.intelephense.setup({
    	on_attach = on_attach,
    	capabilities = capabilities,
    }) ]]
    lspconfig.sqls.setup({
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
    lspconfig.csharp_ls.setup({
    	on_attach = on_attach,
    	capabilities = capabilities,
    })
    lspconfig.omnisharp.setup({
    	on_attach = on_attach,
    	capabilities = capabilities,
    })
    -- c and c++ stuff
    lspconfig.clangd.setup({
    	on_attach = on_attach,
    	capabilities = capabilities,
    })
    -- rust
    lspconfig.rust_analyzer.setup({
    	on_attach = on_attach,
    	capabilities = capabilities,
    })
    -- r
    -- lspconfig.r_language_server.setup({
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    -- })
    -- scripting
    lspconfig.bashls.setup({
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
