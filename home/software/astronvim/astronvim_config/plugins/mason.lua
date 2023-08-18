-- customize mason plugins
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    build = ":MasonToolsUpdate",
    opts = {
      ensure_installed = {
        -- "gofumpt",
        -- "golines",
        -- "gotests",
        -- "chrome-debug-adapter",
        -- "impl",
        -- "json-to-struct",
        -- "luacheck",
        -- "pyright",
        -- "rust-analyzer",
        -- "solidity",
      },
      auto_update = true,
      run_on_start = false,
    },
  },
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        -- "lua_ls",
        -- "bashls",
        -- "clangd",
        -- "cmake",
        -- "csharp_ls",
        -- "gradle_ls",
        -- "kotlin_language_server",
        -- "pyright",
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = {
        -- "prettier",
        -- "stylua",
        -- -- "google_java_format",
        -- "todo_comments",
        -- "gitsigns",
        -- "trim_whitespace",
      },
      handlers = {
        shellcheck = function()
          local null_ls = require "null-ls"
          null_ls.register(null_ls.builtins.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#(c)]" })
        end,
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      -- ensure_installed = { "python", "kotlin" },
    },
    config = true,
  },
}
