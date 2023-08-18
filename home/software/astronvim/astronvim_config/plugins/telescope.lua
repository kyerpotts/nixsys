return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "debugloop/telescope-undo.nvim",
  },
  extensions = {
    undo = {
      side_by_side = true,
      layout_strategy = "vertical",
      layout_config = {
        preview_height = 0.8,
      },
    },
  },
}
