-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
-- Setup sections
local sections = {
  h = { desc = "󰩷 Harpoon" },
  x = { desc = " Trouble" },
  j = { desc = " Java Test" },
}

return {
  -- first key is the mode
  n = {
    -- Remap home page
    ["<leader>;"] = {
      function()
        local wins = vim.api.nvim_tabpage_list_wins(0)
        if #wins > 1 and vim.api.nvim_get_option_value("filetype", { win = wins[1] }) == "neo-tree" then
          vim.fn.win_gotoid(wins[2]) -- go to non-neo-tree window to toggle alpha
        end
        require("alpha").start(false, require("alpha").default_config)
      end,
      desc = "Home Screen",
    },

    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },

    -- Move lines in normal mode up and down
    ["<A-j>"] = { ":m .+1<cr>", desc = "Move line up" },
    ["<A-k>"] = { ":m .-2<cr>", desc = "Move line down" },

    -- Better buffer navigation
    ["]b"] = false,
    ["[b"] = false,
    ["L"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["H"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },

    -- Better increment/decrement
    ["+"] = { "<c-a>", desc = "Increment next integer" },
    ["-"] = { "<c-x>", desc = "Decrement next integer" },

    -- Remap dap to open dapui when debugger is started
    ["<leader>dj"] = {
      false,
      sections.j,
    },
    ["<leader>djt"] = { function() require("jdtls").test_class() end, desc = "Class" },
    ["<leader>djn"] = { function() require("jdtls").test_nearest_method() end, desc = "Nearest Method" },
    -- ["<leader>dc"] = {
    --   function()
    --     require("dap").continue()
    --     local utils = require "astronvim.utils"
    --     if utils.is_available "nvim-dap-ui" then require("dapui").toggle() end
    --   end,
    --   desc = "Start/Continue (F5)",
    -- },

    -- Split screen
    ["\\"] = false,
    ["<leader>_"] = { "<cmd>split<cr>", desc = "Horizontal Split" },

    -- Telescope buffer switching
    ["<Tab>"] = {
      function()
        if #vim.t.bufs > 1 then
          require("telescope.builtin").buffers { sort_mru = true, ignore_current_buffer = true }
        else
          require("astronvim.utils").notify "No other buffers open"
        end
      end,
    },

    -- Harpoon Mappings
    ["<leader>h"] = {
      -- Unmap homescreen
      false,
      -- Create harpoon section
      sections.h,
    },
    ["<leader>ha"] = { function() require("harpoon.mark").add_file() end, desc = "Add Mark" },
    ["<leader>hb"] = { function() require("harpoon.ui").toggle_quick_menu() end, desc = "List" },
    ["<leader>hh"] = { function() require("harpoon.ui").nav_file(1) end, desc = "Mark 1" },
    ["<leader>hj"] = { function() require("harpoon.ui").nav_file(2) end, desc = "Mark 2" },
    ["<leader>hk"] = { function() require("harpoon.ui").nav_file(3) end, desc = "Mark 3" },
    ["<leader>hl"] = { function() require("harpoon.ui").nav_file(4) end, desc = "Mark 4" },

    -- Trouble Mappings
    ["<leader>x"] = {
      false,
      sections.x,
    },
    ["<leader>xx"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics" },
    ["<leader>xX"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
    ["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", desc = "Location List" },
    ["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List" },

    -- TODO-comments Mappings
    ["<leader>xt"] = { "<cmd>TodoTrouble<cr>", desc = "TODO's" },
    -- Remap Themes to uppercase T
    ["<leader>fT"] = {
      function() require("telescope.builtin").colorscheme { enable_preview = true } end,
      desc = "Find themes",
    },
    -- find TODO's through telescope bound to lowercase t
    ["<leader>ft"] = { "<cmd>TodoTelescope<cr>", desc = "TODO's" },

    -- Undotree Mapping
    ["<leader>r"] = { "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
    ["<leader>fu"] = { function() require("telescope").extensions.undo.undo() end, desc = "Undotree" },

    -- Zen Mode
    ["<leader>z"] = { "<cmd>ZenMode<cr>", desc = "󱌿 Zen Mode" },

    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },

  t = {
    -- setting a mapping to false will disable it
    ["<esc>"] = false,
  },
  v = {
    -- Moves selections in visual mode up and down lines
    ["<A-k>"] = { ":m '<-2<cr>gv=gv", desc = "Move line down" },
    ["<A-j>"] = { ":m '>+1<cr>gv=gv", desc = "Move line up" },
  },
}
