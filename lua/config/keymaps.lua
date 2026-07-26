local map = vim.keymap.set

-- fzf-lua
map("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "Grep" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>", { desc = "Help" })
map("n", "<leader>fr", "<cmd>FzfLua resume<cr>", { desc = "Resume search" })

-- neo-tree
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Explorer" })

-- tabs
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader>to", "<cmd>tabnew %<cr>", { desc = "Open current file in new tab" })
map("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "]t", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "[t", "<cmd>tabprevious<cr>", { desc = "Prev tab" })

-- dap
map("n", "<F5>", function() require("dap").continue() end, { desc = "Debug: continue" })
map("n", "<F10>", function() require("dap").step_over() end, { desc = "Debug: step over" })
map("n", "<F11>", function() require("dap").step_into() end, { desc = "Debug: step into" })
map("n", "<F12>", function() require("dap").step_out() end, { desc = "Debug: step out" })
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Debug: breakpoint" })
map("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Debug: UI" })

-- lsp (buffer-local set in lsp config via LspAttach)
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", "<cmd>FzfLua lsp_references<cr>", { desc = "References" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
