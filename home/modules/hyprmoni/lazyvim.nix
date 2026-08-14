{ config, lib, pkgs, ... }:

let
  palette = import ./palette.nix;
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;

    # Tools used by LazyVim, LSPs, formatters and Telescope.
    extraPackages = with pkgs; [
      git
      lazygit
      ripgrep
      fd
      fzf
      curl
      tree-sitter

      # Lua
      lua-language-server
      stylua

      # Nix
      nil
      nixfmt-rfc-style

      # Python
      pyright
      ruff

      # Rust
      rust-analyzer
      rustfmt

      # JavaScript / TypeScript
      nodePackages.typescript-language-server
      nodePackages.prettier

      # C / C++
      clang-tools
    ];

    # LazyVim itself manages its plugins through lazy.nvim.
    # We only need Neovim + the external tooling here.
    extraLuaConfig = ''
      vim.g.mapleader = " "
      vim.g.maplocalleader = "\\"

      vim.opt.termguicolors = true
      vim.opt.background = "dark"
      vim.opt.mouse = "a"
      vim.opt.clipboard = "unnamedplus"

      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.cursorline = true
      vim.opt.signcolumn = "yes"

      vim.opt.expandtab = true
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2

      vim.opt.splitbelow = true
      vim.opt.splitright = true

      vim.opt.scrolloff = 8
      vim.opt.sidescrolloff = 8

      vim.opt.wrap = false
      vim.opt.termguicolors = true

      vim.opt.updatetime = 250
      vim.opt.timeoutlen = 300

      vim.opt.undofile = true
      vim.opt.swapfile = false
      vim.opt.backup = false
    '';
  };

  # LazyVim's standard bootstrap.
  xdg.configFile."nvim/init.lua".text = ''
    require("config.lazy")
  '';

  xdg.configFile."nvim/lua/config/lazy.lua".text = ''
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

    if not (vim.uv or vim.loop).fs_stat(lazypath) then
      local lazyrepo = "https://github.com/folke/lazy.nvim.git"

      local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
      })

      if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
          { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
          { out, "WarningMsg" },
          { "\nPress any key to exit..." },
        }, true, {})

        vim.fn.getchar()
        os.exit(1)
      end
    end

    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup({
      spec = {
        {
          "LazyVim/LazyVim",
          import = "lazyvim.plugins",
          opts = {
            colorscheme = "hyprmoni",
          },
        },

        {
          "nvim-treesitter/nvim-treesitter",
          opts = {
            ensure_installed = {
              "lua",
              "nix",
              "python",
              "rust",
              "javascript",
              "typescript",
              "tsx",
              "json",
              "jsonc",
              "bash",
              "c",
              "cpp",
              "markdown",
              "markdown_inline",
              "vim",
              "vimdoc",
            },
          },
        },

        {
          "neovim/nvim-lspconfig",
          opts = {
            servers = {
              nil_ls = {},
              lua_ls = {},
              pyright = {},
              rust_analyzer = {},
              ts_ls = {},
              clangd = {},
            },
          },
        },

        {
          "stevearc/conform.nvim",
          opts = {
            formatters_by_ft = {
              nix = { "nixfmt" },
              lua = { "stylua" },
              python = { "ruff_format" },
              rust = { "rustfmt" },
              javascript = { "prettier" },
              javascriptreact = { "prettier" },
              typescript = { "prettier" },
              typescriptreact = { "prettier" },
              json = { "prettier" },
              jsonc = { "prettier" },
              markdown = { "prettier" },
            },
          },
        },

        {
          "folke/noice.nvim",
          opts = {
            presets = {
              bottom_search = true,
              command_palette = true,
              long_message_to_split = true,
              inc_rename = false,
              lsp_doc_border = true,
            },
          },
        },

        {
          "nvim-lualine/lualine.nvim",
          opts = {
            options = {
              theme = "hyprmoni",
              globalstatus = true,
              component_separators = { left = "│", right = "│" },
              section_separators = { left = "", right = "" },
            },
          },
        },

        {
          "akinsho/bufferline.nvim",
          opts = {
            options = {
              separator_style = "slant",
              always_show_bufferline = true,
            },
          },
        },

        {
          "lewis6991/gitsigns.nvim",
          opts = {
            signs = {
              add = { text = "│" },
              change = { text = "│" },
              delete = { text = "▾" },
              topdelete = { text = "▴" },
              changedelete = { text = "│" },
              untracked = { text = "┆" },
            },
          },
        },
      },

      defaults = {
        lazy = false,
        version = false,
      },

      install = {
        colorscheme = {
          "hyprmoni",
          "habamax",
        },
      },

      checker = {
        enabled = true,
        notify = false,
      },

      performance = {
        rtp = {
          disabled_plugins = {
            "gzip",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
          },
        },
      },
    })
  '';

  # Hyprmoni-native colorscheme.
  xdg.configFile."nvim/colors/hyprmoni.lua".text = ''
    vim.cmd("highlight clear")
    vim.cmd("syntax reset")

    vim.o.background = "dark"
    vim.g.colors_name = "hyprmoni"

    local c = {
      void    = "${palette.void}",
      panel   = "${palette.panel}",
      wine    = "${palette.wine}",
      wineD   = "${palette.wineDark}",
      pink    = "${palette.pink}",
      hot     = "${palette.hotPink}",
      blush   = "${palette.blush}",
      peach   = "${palette.peach}",
      muted   = "${palette.muted}",
      green   = "${palette.green}",
    }

    local hi = vim.api.nvim_set_hl

    -- Core UI
    hi(0, "Normal",       { fg = c.blush, bg = c.void })
    hi(0, "NormalFloat",  { fg = c.blush, bg = c.panel })
    hi(0, "FloatBorder",  { fg = c.wine, bg = c.panel })
    hi(0, "Cursor",       { fg = c.void, bg = c.hot })
    hi(0, "CursorLine",   { bg = c.panel })
    hi(0, "CursorLineNr", { fg = c.hot, bold = true })
    hi(0, "LineNr",       { fg = c.wine })
    hi(0, "SignColumn",   { bg = c.void })

    -- Windows / separators
    hi(0, "WinSeparator", { fg = c.wineD })
    hi(0, "VertSplit",    { fg = c.wineD })

    -- Selection
    hi(0, "Visual", {
      bg = c.wineD,
      fg = c.blush,
    })

    hi(0, "Search", {
      fg = c.void,
      bg = c.peach,
      bold = true,
    })

    hi(0, "IncSearch", {
      fg = c.void,
      bg = c.hot,
      bold = true,
    })

    -- Text
    hi(0, "Comment", { fg = c.muted, italic = true })
    hi(0, "String",  { fg = c.peach })
    hi(0, "Constant", { fg = c.peach })
    hi(0, "Number",   { fg = c.peach })
    hi(0, "Boolean",  { fg = c.hot, bold = true })

    -- Syntax
    hi(0, "Keyword",   { fg = c.pink, bold = true })
    hi(0, "Statement", { fg = c.pink })
    hi(0, "Function",  { fg = c.hot, bold = true })
    hi(0, "Type",      { fg = c.blush })
    hi(0, "Identifier",{ fg = c.blush })
    hi(0, "Operator",  { fg = c.peach })
    hi(0, "Delimiter", { fg = c.muted })
    hi(0, "Special",   { fg = c.hot })

    -- Diagnostics
    hi(0, "DiagnosticError", { fg = c.hot })
    hi(0, "DiagnosticWarn",  { fg = c.peach })
    hi(0, "DiagnosticInfo",  { fg = c.pink })
    hi(0, "DiagnosticHint",  { fg = c.muted })

    hi(0, "DiagnosticVirtualTextError", {
      fg = c.hot,
      bg = c.wineD,
    })

    hi(0, "DiagnosticVirtualTextWarn", {
      fg = c.peach,
      bg = c.wineD,
    })

    hi(0, "DiagnosticVirtualTextInfo", {
      fg = c.pink,
      bg = c.wineD,
    })

    -- Completion / popup menus
    hi(0, "Pmenu",       { fg = c.blush, bg = c.panel })
    hi(0, "PmenuSel",    { fg = c.blush, bg = c.wineD, bold = true })
    hi(0, "PmenuBorder", { fg = c.wine, bg = c.panel })

    -- Git
    hi(0, "GitSignsAdd",    { fg = c.blush })
    hi(0, "GitSignsChange", { fg = c.peach })
    hi(0, "GitSignsDelete", { fg = c.hot })

    -- Telescope
    hi(0, "TelescopeNormal",   { fg = c.blush, bg = c.panel })
    hi(0, "TelescopeBorder",   { fg = c.wine, bg = c.panel })
    hi(0, "TelescopePrompt",   { fg = c.blush, bg = c.wineD })
    hi(0, "TelescopePromptBorder", { fg = c.pink, bg = c.wineD })
    hi(0, "TelescopeSelection", { fg = c.blush, bg = c.wineD, bold = true })
    hi(0, "TelescopeMatching",  { fg = c.hot, bold = true })

    -- Neo-tree
    hi(0, "NeoTreeNormal",    { fg = c.blush, bg = c.panel })
    hi(0, "NeoTreeDirectoryName", { fg = c.blush })
    hi(0, "NeoTreeDirectoryIcon", { fg = c.pink })
    hi(0, "NeoTreeGitAdded",    { fg = c.blush })
    hi(0, "NeoTreeGitModified", { fg = c.peach })
    hi(0, "NeoTreeGitDeleted",  { fg = c.hot })
    hi(0, "NeoTreeCursorLine",  { bg = c.wineD })

    -- Which-key
    hi(0, "WhichKey",      { fg = c.hot })
    hi(0, "WhichKeyGroup", { fg = c.pink })
    hi(0, "WhichKeyDesc",  { fg = c.blush })
    hi(0, "WhichKeySeparator", { fg = c.wine })

    -- Statusline
    hi(0, "StatusLine",   { fg = c.blush, bg = c.panel })
    hi(0, "StatusLineNC", { fg = c.muted, bg = c.panel })

    -- Tabs
    hi(0, "TabLine",    { fg = c.muted, bg = c.panel })
    hi(0, "TabLineFill",{ fg = c.muted, bg = c.void })
    hi(0, "TabLineSel", { fg = c.blush, bg = c.wineD, bold = true })

    -- Markdown
    hi(0, "Title",    { fg = c.hot, bold = true })
    hi(0, "markdownH1", { fg = c.hot, bold = true })
    hi(0, "markdownH2", { fg = c.pink, bold = true })
    hi(0, "markdownCode", { fg = c.peach })

    -- LSP references
    hi(0, "LspReferenceText",  { bg = c.wineD })
    hi(0, "LspReferenceRead",  { bg = c.wineD })
    hi(0, "LspReferenceWrite", { bg = c.wineD, fg = c.hot })
  '';

  # LSP / LazyVim-specific overrides.
  xdg.configFile."nvim/lua/plugins/hyprmoni.lua".text = ''
    return {
      {
        "LazyVim/LazyVim",
        opts = {
          colorscheme = "hyprmoni",
        },
      },

      {
        "folke/snacks.nvim",
        opts = {
          dashboard = {
            enabled = true,
            preset = {
              header = [[
██╗  ██╗██╗   ██╗██████╗ ██████╗ ███╗   ███╗ ██████╗ ███╗   ██╗██╗
██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗████╗ ████║██╔═══██╗████╗  ██║██║
███████║ ╚████╔╝ ██████╔╝██████╔╝██╔████╔██║██║   ██║██╔██╗ ██║██║
██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗██║╚██╔╝██║██║   ██║██║╚██╗██║██║
██║  ██║   ██║   ██║     ██║  ██║██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██║
╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝
              ]],
            },
          },
        },
      },
    }
  '';
}
