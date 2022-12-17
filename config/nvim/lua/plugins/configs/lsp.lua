local present, lsp = pcall(require, "lsp-zero")

if not present then
  return
end

lsp.preset('recommended')

local cmp = require('cmp')
local luasnip = require('luasnip')

local cmp_mappings = cmp.mapping.preset.insert({
  ['<CR>'] = nil,
  ['<C-y>'] = cmp.mapping.confirm {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  ['<Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    else
      fallback()
    end
  end, { 'i', 's' }),
  ['<S-Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { 'i', 's' }),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})
