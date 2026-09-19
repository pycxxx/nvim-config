return {
  -- completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = { expand = function(a) luasnip.lsp_expand(a.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -- mason: installs LSP servers, DAP adapters, linters
  { "williamboman/mason.nvim", cmd = "Mason", opts = {} },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local caps = require("cmp_nvim_lsp").default_capabilities()

      local servers = {
        ts_ls = {},
        eslint = {},
        ruff = {},
        pyright = require("config.lsp.pyright"),
      }
      if vim.fn.executable("go") == 1 then
        servers.gopls = {}
      end

      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      local lsp = vim.lsp
      for server, custom_opts in pairs(servers) do
        local opts = vim.tbl_deep_extend("force", { capabilities = caps }, custom_opts)
        lsp.config(server, opts)
        lsp.enable(server)
      end

      -- format on save via LSP where available
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(ev)
          vim.lsp.buf.format({ bufnr = ev.buf, async = false })
        end,
      })

      -- show type/doc popup above cursor when idle
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = vim.lsp.buf.hover,
      })
    end,
  },
}
