return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "typescript", "tsx", "javascript", "python", "go", "gomod", "gosum",
        "lua", "json", "yaml", "html", "css", "markdown", "bash",
      },
    },
  },
}