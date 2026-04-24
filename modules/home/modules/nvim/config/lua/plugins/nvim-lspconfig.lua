return {
  setup = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local function lsp_keymaps(bufnr)
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

    local function on_attach(_, bufnr)
      lsp_keymaps(bufnr)
    end

    local default_config = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    local servers = {
      lua_ls = {
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      },

      dockerls = {
        filetypes = { "dockerfile" },
        root_dir = lspconfig.util.root_pattern("Dockerfile"),
      },

      docker_compose_language_service = {
        filetypes = { "docker-compose" },
        root_dir = lspconfig.util.root_pattern("docker-compose.yml"),
      },

      dartls = {
        cmd = { "dart", "language-server", "--protocol=lsp" },
        filetypes = { "dart" },
        root_markers = { "pubspec.yaml" },
        init_options = {
          closingLabels = true,
          flutterOutline = true,
          outline = true,
          suggestFromUnimportedLibraries = true,
        },
        settings = {
          dart = {
            completeFunctionCalls = true,
            showTodos = true,
          },
        },
      },

      vue_ls = {
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        init_options = {
          vue = { hybridMode = false },
          typescript = { tsdk = "node_modules/typescript/lib" },
        },
        on_new_config = function(new_config, root_dir)
          local tsdk = vim.fs.find("node_modules/typescript/lib", {
            path = root_dir,
            upward = true,
          })[1]
          if tsdk then
            new_config.init_options.typescript.tsdk = tsdk
          end
        end,
      },

      sqls = {
        settings = {
          sqls = {
            connections = {
              { driver = "mysql" },
            },
          },
        },
      },

      bashls = {
        settings = {
          bashIde = {
            shellcheck = { enable = true },
          },
        },
      },
      qmlls = {
        cmd = { "qmlls", "-E" },
      },

      -- simple servers (no extra config)
      nil_ls = {},
      html = {},
      cssls = {},
      clangd = {},
      rust_analyzer = {},
      intelephense = {},
      phpactor = {},
      vtsls = {},
      ltex_plus = {},
      textlab = {},
      csharp_ls = {},
      omnisharp = {
        cmd = { "OmniSharp", "--languageserver" },
        filetypes = { "cs" },
        FormattingOptions = {
          enableEditorConfigSupport = true,
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
        },
        --[[ handlers = {
          ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
          ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
          ["textDocument/references"] = require('omnisharp_extended').references_handler,
          ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
        }, ]]
      },
    }

    for server, config in pairs(servers) do
      local merged = vim.tbl_deep_extend("force", default_config, config)

      vim.lsp.config(server, merged)
      vim.lsp.enable(server)
    end

    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      float = {
        border = "rounded",
        source = "always",
      },
    })
  end,
}
