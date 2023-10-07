local lsp = require("lsp-zero")
local util = require("lspconfig.util")
local lspconfig = require("lspconfig")

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({buffer= bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {'tsserver', 'eslint', 'angularls'},
	handlers = {
		lsp.default_setup,
		['angularls'] = function()
			lspconfig.angularls.setup({
				root_dir = util.root_pattern('angular.json', 'project.json')
			})
		end
	}
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
    -- `Tab` key to confirm and replace
    ['<Tab>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  })
})

vim.diagnostic.config({
    virtual_text = true
})
