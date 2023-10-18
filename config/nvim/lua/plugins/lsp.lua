return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v2.x",
  lazy = false,
  dependencies = {
    { "neovim/nvim-lspconfig" },
    {
      "williamboman/mason.nvim",
      build = function()
        pcall(vim.cmd, "MasonUpdate")
      end,
    },
    { "williamboman/mason-lspconfig.nvim" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "L3MON4D3/LuaSnip" },

    {
      "jay-babu/mason-null-ls.nvim",
      event = { "BufReadPre", "BufNewFile" },
      dependencies = {
        "williamboman/mason.nvim",
        "nvimtools/none-ls.nvim",
      },
      config = function()
        require("mason").setup()
        require("mason-null-ls").setup({
          handlers = {},
        })
      end,
    },

    { "SmiteshP/nvim-navic" },
  },
  config = function()
    local lsp = require("lsp-zero").preset({})

    lsp.ensure_installed({
      "lua_ls",
      "elixirls",
      "eslint",
      "rust_analyzer",
    })

    lsp.on_attach(function(client, bufnr)
      lsp.default_keymaps({
        buffer = bufnr,
        preserve_mappings = false,
        omit = { "<C-k>" },
      })

      vim.keymap.set({ "n", "x" }, "gt", function()
        vim.lsp.buf.format({ async = true, timeout_ms = 10000 })
      end, { desc = "format" })

      if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
      end
    end)

    require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

    require("lspconfig").elixirls.setup({
      cmd = { vim.fn.expand("~/code/github/elixir-lsp/elixir-ls/release/language_server.sh") },
      settings = {
        fetchDeps = false,
        dialyzerEnabled = false,
        enableTestLenses = false,
        suggestSpecs = false,
        autoInsertRequiredAlias = false,
      },
    })

    require("lspconfig").eslint.setup({
      filestypes = { "javascript", "typescript" },
      settings = {
        format = { enable = true },
        lint = { enable = true },
      },
    })

    lsp.format_mapping("gq", {
      format_opts = {
        async = false,
        timeout_ms = 10000,
      },
      servers = {
        ["null-ls"] = {
          "lua",
          "elixir",
          "eex",
          "heex",
          "surface",
          "javascript",
          "typescript",
          "rust",
        },
      },
    })

    lsp.setup()

    local cmp = require("cmp")

    cmp.setup({
      mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
        ["<C-c>"] = cmp.mapping.close(),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
          else
            fallback()
          end
        end, { "i", "s" }),
      },
    })

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- `:` cmdline setup.
    -- cmp.setup.cmdline(':', {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = cmp.config.sources({
    --     { name = 'path' }
    --   }, {
    --     {
    --       name = 'cmdline',
    --       option = {
    --         ignore_cmds = { 'Man', '!' }
    --       }
    --     }
    --   })
    -- })

    local null_ls = require("null-ls")
    local mason_null_ls = require("mason-null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.formatting.stylua,
      },
    })

    mason_null_ls.setup({
      ensure_installed = nil,
      automatic_installation = true,
    })
  end,
}
