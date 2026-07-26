-- eslint (JS/TS/React), ruff (Python) and gopls already lint via LSP.
-- nvim-lint adds golangci-lint, which gopls does not run itself.
return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost" },
    config = function()
      require("lint").linters_by_ft = {
        go = { "golangcilint" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
        callback = function() require("lint").try_lint() end,
      })
    end,
  },
}
