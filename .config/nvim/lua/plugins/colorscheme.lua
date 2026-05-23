-- Resolve colorscheme:
--   1. If $SSH_CONNECTION is set, use the ember scheme (red/orange remote palette).
--   2. Else read the active theme name from ~/.config/themes/current/neovim (one line).
--   3. Fall back to tokyonight.
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

local colorscheme
if vim.env.SSH_CONNECTION and vim.env.SSH_CONNECTION ~= "" then
  colorscheme = "ember"
else
  colorscheme = read_theme() or "tokyonight"
end

return {
  { "LazyVim/LazyVim", opts = { colorscheme = colorscheme } },
  { "folke/tokyonight.nvim", opts = { style = "night" } },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "ellisonleao/gruvbox.nvim", lazy = true },
}
