return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.nix"},
  -- { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.debugging.nvim-bqf" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.rose-pine" },
  {
    -- "catppuccin",
    -- integrations = {
    --   neotree = true,
    -- },
    -- opts = {
    --   transparent_background = true,
    --   dim_inactive = {
    --     enabled = true,
    --     percentage = 0.8,
    --   },
    -- },
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" }),
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" }),
  },
  { import = "astrocommunity.completion.copilot-lua-cmp" },
}
