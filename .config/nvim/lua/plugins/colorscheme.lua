-- Resolve colorscheme: read the active theme name from
-- ~/.config/themes/current/neovim (one line), else fall back to tokyonight.
local function read_theme()
  local path = vim.fn.expand("~/.config/themes/current/neovim")
  local f = io.open(path, "r")
  if not f then return nil end
  local name = f:read("*l")
  f:close()
  if name then name = name:gsub("%s+$", "") end
  if name == "" then return nil end
  return name
end

local colorscheme = read_theme() or "tokyonight"

return {
  { "LazyVim/LazyVim", opts = { colorscheme = colorscheme } },
  { "folke/tokyonight.nvim", opts = { style = "night" } },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "ellisonleao/gruvbox.nvim", lazy = true },
}
