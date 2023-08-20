-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local utils = require("astronvim.utils")
local sections = {
  -- h = { desc = "󰩷 Harpoon" },
  x = { desc = " Trouble" },
  j = { desc = " Java Test" },
}

-- require("telescope").load_extension("refactoring")
require("telescope").load_extension("yank_history")
require("telescope").load_extension("undo")

return {
  -- normal mode
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
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
          require("astronvim.utils.buffer").close(bufnr)
        end)
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
      function()
        require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1)
      end,
      desc = "Next buffer",
    },
    ["H"] = {
      function()
        require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1))
      end,
      desc = "Previous buffer",
    },

    -- Better increment/decrement
    ["+"] = { "<c-a>", desc = "Increment next integer" },
    ["-"] = { "<c-x>", desc = "Decrement next integer" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command

    -- Remap dap to open dapui when debugger is started
    ["<leader>dj"] = {
      false,
      sections.j,
    },
    ["<leader>djt"] = {
      function()
        require("jdtls").test_class()
      end,
      desc = "Class",
    },
    ["<leader>djn"] = {
      function()
        require("jdtls").test_nearest_method()
      end,
      desc = "Nearest Method",
    },

    ["<leader>tp"] = {
      function()
        utils.toggle_term_cmd("python")
        -- utils.toggle_term_cmd("ipython")
      end,
      desc = "ToggleTerm python",
    },

    -- Split screen
    ["\\"] = false,
    ["<leader>_"] = { "<cmd>split<cr>", desc = "Horizontal Split" },
    ["<leader>|"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" },

    -- Telescope buffer switching
    ["<Tab>"] = {
      function()
        if #vim.t.bufs > 1 then
          require("telescope.builtin").buffers({ sort_mru = true, ignore_current_buffer = true })
        else
          require("astronvim.utils").notify("No other buffers open")
        end
      end,
    },

    -- Harpoon Mappings
    -- ["<leader>h"] = {
    --   -- Unmap homescreen
    --   false,
    --   -- Create harpoon section
    --   sections.h,
    -- },
    -- ["<leader>ha"] = {
    --   function()
    --     require("harpoon.mark").add_file()
    --   end,
    --   desc = "Add Mark",
    -- },
    -- ["<leader>hb"] = {
    --   function()
    --     require("harpoon.ui").toggle_quick_menu()
    --   end,
    --   desc = "List",
    -- },
    -- ["<leader>hh"] = {
    --   function()
    --     require("harpoon.ui").nav_file(1)
    --   end,
    --   desc = "Mark 1",
    -- },
    -- ["<leader>hj"] = {
    --   function()
    --     require("harpoon.ui").nav_file(2)
    --   end,
    --   desc = "Mark 2",
    -- },
    -- ["<leader>hk"] = {
    --   function()
    --     require("harpoon.ui").nav_file(3)
    --   end,
    --   desc = "Mark 3",
    -- },
    -- ["<leader>hl"] = {
    --   function()
    --     require("harpoon.ui").nav_file(4)
    --   end,
    --   desc = "Mark 4",
    -- },

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
      function()
        require("telescope.builtin").colorscheme({ enable_preview = true })
      end,
      desc = "Find themes",
    },
    -- find TODO's through telescope bound to lowercase t
    ["<leader>ft"] = { "<cmd>TodoTelescope<cr>", desc = "TODO's" },

    -- Undotree Mapping
    ["<leader>r"] = { "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
    ["<leader>fu"] = {
      function()
        require("telescope").extensions.undo.undo()
      end,
      desc = "Undotree",
    },

    -- Zen Mode
    ["<leader>z"] = { "<cmd>ZenMode<cr>", desc = "󱌿 Zen Mode" },

    ["<leader>b"] = { name = "Buffers" },
    -- search and replace globally
    -- ["<leader>ss"] = { '<cmd>lua require("spectre").toggle()<CR>', desc = "Toggle Spectre" },
    -- ["<leader>sw"] = {
    --   '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
    --   desc = "Search current word",
    -- },
    -- ["<leader>sp"] = {
    --   '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
    --   desc = "Search on current file",
    -- },

    -- refactoring
    -- ["<leader>ri"] = {
    --   function()
    --     require("refactoring").refactor("Inline Variable")
    --   end,
    --   desc = "Inverse of extract variable",
    -- },
    -- ["<leader>rb"] = {
    --   function()
    --     require("refactoring").refactor("Extract Block")
    --   end,
    --   desc = "Extract Block",
    -- },
    -- ["<leader>rbf"] = {
    --   function()
    --     require("refactoring").refactor("Extract Block To File")
    --   end,
    --   desc = "Extract Block To File",
    -- },
    -- ["<leader>rr"] = {
    --   function()
    --     require("telescope").extensions.refactoring.refactors()
    --   end,
    --   desc = "Prompt for a refactor to apply",
    -- },
    -- ["<leader>rp"] = {
    --   function()
    --     require("refactoring").debug.printf({ below = false })
    --   end,
    --   desc = "Insert print statement to mark the calling of a function",
    -- },
    -- ["<leader>rv"] = {
    --   function()
    --     require("refactoring").debug.print_var()
    --   end,
    --   desc = "Insert print statement to print a variable",
    -- },
    -- ["<leader>rc"] = {
    --   function()
    --     require("refactoring").debug.cleanup({})
    --   end,
    --   desc = "Cleanup of all generated print statements",
    -- },

    -- yank_history
    ["<leader>hy"] = {
      function()
        require("telescope").extensions.yank_history.yank_history()
      end,
      desc = "Preview Yank History",
    },

    -- undo history
    ["<leader>hu"] = { "<cmd>Telescope undo<cr>", desc = "Telescope undo" },

    -- implementation/definition preview
    ["<leader>lgd"] = {
      "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
      desc = "goto_preview_definition",
    },
    ["<leader>lgt"] = {
      "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
      desc = "goto_preview_type_definition",
    },
    ["<leader>lgi"] = {
      "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
      desc = "goto_preview_implementation",
    },
    ["<leader>lgP"] = { "<cmd>lua require('goto-preview').close_all_win()<CR>", desc = "close_all_win" },
    ["<leader>lgr"] = {
      "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
      desc = "goto_preview_references",
    },
  },
  t = {
    -- setting a mapping to false will disable it
    ["<esc>"] = false,
  },
  -- Visual mode
  v = {
    -- Moves selections in visual mode up and down lines
    ["<A-k>"] = { ":m '<-2<cr>gv=gv", desc = "Move line down" },
    ["<A-j>"] = { ":m '>+1<cr>gv=gv", desc = "Move line up" },
    -- search and replace globally
    -- ["<leader>sw"] = { '<esc><cmd>lua require("spectre").open_visual()<Cr>', desc = "Search current word" },
  },
  -- visual mode(what's the difference between v and x???)
  x = {
    -- refactoring
    -- ["<leader>ri"] = {
    --   function()
    --     require("refactoring").refactor("Inline Variable")
    --   end,
    --   desc = "Inverse of extract variable",
    -- },
    -- ["<leader>re"] = {
    --   function()
    --     require("refactoring").refactor("Extract Function")
    --   end,
    --   desc = "Extracts the selected code to a separate function",
    -- },
    -- ["<leader>rf"] = {
    --   function()
    --     require("refactoring").refactor("Extract Function To File")
    --   end,
    --   desc = "Extract Function To File",
    -- },
    -- ["<leader>rv"] = {
    --   function()
    --     require("refactoring").refactor("Extract Variable")
    --   end,
    --   desc = "Extracts occurrences of a selected expression to its own variable",
    -- },
    -- ["<leader>rr"] = {
    --   function()
    --     require("telescope").extensions.refactoring.refactors()
    --   end,
    --   desc = "Prompt for a refactor to apply",
    -- },
  },
}
