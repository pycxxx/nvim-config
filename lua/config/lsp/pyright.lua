local is_win = vim.fn.has("win32") == 1
local py_bin = is_win and "Scripts/python.exe" or "bin/python"

local function get_python_path(workspace)
  -- 1. Check if VIRTUAL_ENV is already active in the shell
  if vim.env.VIRTUAL_ENV then
    local venv_py = vim.fs.joinpath(vim.env.VIRTUAL_ENV, py_bin)
    if vim.fn.executable(venv_py) == 1 then
      return venv_py
    end
  end

  -- 2. Search upwards for .venv or venv (supports uv and standard venvs)
  local start_dir = workspace or vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  if start_dir and start_dir ~= "" then
    local match = vim.fs.find({ ".venv", "venv" }, {
      path = start_dir,
      upward = true,
      type = "directory",
    })[1]
    if match then
      local venv_py = vim.fs.joinpath(match, py_bin)
      if vim.fn.executable(venv_py) == 1 then
        return venv_py
      end
    end
  end

  -- 3. Fallback to system Python
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

return {
  root_markers = {
    ".venv",
    "uv.lock",
    "pyproject.toml",
    "pyrightconfig.json",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    ".git",
  },
  before_init = function(_, config)
    if not config.settings then
      config.settings = {}
    end
    if not config.settings.python then
      config.settings.python = {}
    end
    config.settings.python.pythonPath = get_python_path(config.root_dir)
  end,
}
