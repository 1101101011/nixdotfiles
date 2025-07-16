return {
  setup = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()
    luasnip.config.setup({})

    cmp.setup({
      snippet = {
        expand = function(args)
	  luasnip.lsp_expand(args.body)
	end,
      },
      window = {
	-- completion = cmp.config.window.bordered(),
	-- documentation = cmp.config.window.bordered(),
	completion = {
	  border = "rounded",
	  winhighlight = "Normal:CmpNormal,CursorLine:PmenuThumb,FloatBorder:Normal",
        },
	documentation = {
          border = "rounded",
	  winhighlight = "Normal:CmpDocNormal,FloatBorder:Normal",
	},
      },
      mapping = cmp.mapping.preset.insert({
	["<C-b>"] = cmp.mapping.scroll_docs(-4),
	["<C-f>"] = cmp.mapping.scroll_docs(4),
	["<C-Space>"] = cmp.mapping.complete(),
	["<C-e>"] = cmp.mapping.abort(),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
	{ name = "nvim_lsp" },
	{ name = "luasnip" },
      }, {
        { name = "buffer" },
      }),
    })
  end
}
