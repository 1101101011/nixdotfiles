return {
  setup = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }

      vim.keymap.set("n", "<Leader>cd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<Leader>ci", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "<Leader>cr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<Leader>cf", function()
        vim.lsp.buf.format({ async = true })
      end, opts)
    end
    local language_servers = {
      "dockerls",
      "docker_compose_language_service",
      "docker_language_service",
      "lua_ls",
      "nil_ls",
      "eslint",
      "eslint_d",
      "html",
      "cssls",
      "dartls",
      "vue_ls",
      --"phpactor", -- not working
      "intelephense",
      "sqls",
      "csharp_ls",
      "omnisharp",
      "clangd",
      "rust_analyzer",
      --"r_language_server", -- not working
      "bashls",
      "textlab",
      --"digestif", -- not working
      "ltex_plus",
    }

    for _, server in ipairs(language_servers) do
      vim.lsp.enable(server)
      vim.lsp.config(server, {
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end
    -- docker
    vim.lsp.config("dockerls", {
      filetypes = { "dockerfile", "docker-compose" },
      root_dir = lspconfig.util.root_pattern("Dockerfile", "docker-compose.yml"),
    })
    vim.lsp.config("docker_compose_language_service", {
      filetypes = { "docker-compose" },
      root_dir = lspconfig.util.root_pattern("docker-compose.yml"),
    })
    vim.lsp.config("docker_language_service", {
      filetypes = { "dockerfile" },
      root_dir = lspconfig.util.root_pattern("Dockerfile"),
    })
    -- lua
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })
    vim.lsp.config("dartls", {
      filetypes = { "dart" },
      cmd = { "dart", "language-server", "--protocol=lsp" },
      init_options = {
        {
          closingLabels = true,
          flutterOutline = true,
          onlyAnalyzeProjectsWithOpenFiles = true,
          outline = true,
          suggestFromUnimportedLibraries = true,
        },
      },
      root_markers = { "pubspec.yaml" },
      settings = {
        dart = {
          completeFunctionCalls = true,
          showTodos = true,
        },
      },
    })
    vim.lsp.config("vue_ls", {
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      init_options = {
        vue = {
          hybridMode = false,
        },
        typescript = {
          tsdk = "node_modules/typescript/lib",
        },
      },
      on_new_config = function(new_config, new_root_dir)
        local lib_path = vim.fs.find("node_modules/typescript/lib", { path = new_root_dir, upward = true })[1]
        if lib_path then
          new_config.init_options.typescript.tsdk = lib_path
        end
      end,
    })
    vim.lsp.config("sqls", {
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
    -- scripting
    vim.lsp.config("bashls", {
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
  end,
}
