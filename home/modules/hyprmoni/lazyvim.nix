{ pkgs, lazyvim-nix, ... }:
{
  imports = [
    lazyvim-nix.homeManagerModules.default
  ];

  programs.lazyvim = {
    enable = true;
    installCoreDependencies = true;

    extraPackages = with pkgs; [
      nodejs
      python3
    ];

    # ─────────────────────────────────────────────
    # Hyprmoni colorscheme
    # ─────────────────────────────────────────────
    plugins.colorscheme = ''
      return {
        "folke/tokyonight.nvim",
        priority = 1000,

        opts = {
          transparent = true,

          styles = {
            sidebars = "transparent",
            floats = "transparent",
          },

          on_colors = function(c)
            c.bg = "#0D0D0D"
            c.bg_dark = "#0D0D0D"
            c.bg_float = "#1B1B1B"
            c.bg_sidebar = "#1B1B1B"

            c.fg = "#FFD9E8"
            c.fg_dark = "#BFBFBF"

            c.blue = "#CE4A7E"
            c.cyan = "#FFAA99"
            c.green = "#CE4A7E"
            c.magenta = "#FD5BA2"
            c.purple = "#67253F"
            c.red = "#FD5BA2"
            c.orange = "#FFAA99"
            c.yellow = "#FFAA99"

            c.comment = "#BFBFBF"
            c.border = "#67253F"
          end,

          on_highlights = function(hl, c)
            -- Core UI
            hl.Normal       = { fg = "#FFD9E8", bg = "#0D0D0D" }
            hl.NormalFloat  = { fg = "#FFD9E8", bg = "#1B1B1B" }
            hl.FloatBorder  = { fg = "#CE4A7E", bg = "#1B1B1B" }

            hl.WinSeparator = { fg = "#67253F" }
            hl.VertSplit    = { fg = "#67253F" }

            hl.CursorLine   = { bg = "#1B1B1B" }
            hl.CursorLineNr = { fg = "#FD5BA2", bold = true }
            hl.LineNr       = { fg = "#67253F" }

            hl.Visual = {
              bg = "#401929",
              fg = "#FFD9E8",
            }

            hl.Search = {
              fg = "#0D0D0D",
              bg = "#FFAA99",
              bold = true,
            }

            hl.IncSearch = {
              fg = "#0D0D0D",
              bg = "#FD5BA2",
              bold = true,
            }

            -- Completion / popup menus
            hl.Pmenu       = { fg = "#FFD9E8", bg = "#1B1B1B" }
            hl.PmenuSel    = { fg = "#FFD9E8", bg = "#401929", bold = true }
            hl.PmenuBorder = { fg = "#CE4A7E", bg = "#1B1B1B" }

            -- Diagnostics
            hl.DiagnosticError = { fg = "#FD5BA2" }
            hl.DiagnosticWarn  = { fg = "#FFAA99" }
            hl.DiagnosticInfo  = { fg = "#CE4A7E" }
            hl.DiagnosticHint  = { fg = "#BFBFBF" }

            -- Git
            hl.GitSignsAdd    = { fg = "#CE4A7E" }
            hl.GitSignsChange = { fg = "#FFAA99" }
            hl.GitSignsDelete = { fg = "#FD5BA2" }

            -- Snacks dashboard
            hl.SnacksDashboardHeader = { fg = "#FD5BA2" }
            hl.SnacksDashboardIcon   = { fg = "#CE4A7E" }
            hl.SnacksDashboardKey    = { fg = "#FD5BA2" }
            hl.SnacksDashboardDesc   = { fg = "#FFAA99" }
            hl.SnacksDashboardFile   = { fg = "#FFD9E8" }
            hl.SnacksDashboardFooter = { fg = "#CE4A7E" }

            -- Snacks picker / recent files
            hl.SnacksPickerBorder       = { fg = "#67253F" }
            hl.SnacksPickerTitle        = { fg = "#FD5BA2" }
            hl.SnacksPickerPrompt       = { fg = "#FFD9E8", bg = "#1B1B1B" }
            hl.SnacksPickerInput        = { fg = "#FFD9E8", bg = "#1B1B1B" }
            hl.SnacksPickerList         = { fg = "#FFD9E8", bg = "#0D0D0D" }
            hl.SnacksPickerPreview      = { fg = "#FFD9E8", bg = "#0D0D0D" }
            hl.SnacksPickerSelected     = { fg = "#FFD9E8", bg = "#401929" }
            hl.SnacksPickerMatch        = { fg = "#FD5BA2", bold = true }
            hl.SnacksPickerDir          = { fg = "#CE4A7E" }
            hl.SnacksPickerFile         = { fg = "#FFD9E8" }

            -- Generic Snacks UI
            hl.SnacksInputBorder        = { fg = "#67253F" }
            hl.SnacksInputTitle         = { fg = "#FD5BA2" }
            hl.SnacksInputNormal        = { fg = "#FFD9E8", bg = "#1B1B1B" }

            -- Which-key
            hl.WhichKey           = { fg = "#FD5BA2" }
            hl.WhichKeyGroup      = { fg = "#CE4A7E" }
            hl.WhichKeyDesc       = { fg = "#FFD9E8" }
            hl.WhichKeySeparator  = { fg = "#67253F" }

            -- Statusline / tabline
            hl.StatusLine   = { fg = "#FFD9E8", bg = "#1B1B1B" }
            hl.StatusLineNC = { fg = "#BFBFBF", bg = "#1B1B1B" }

            hl.TabLine     = { fg = "#BFBFBF", bg = "#1B1B1B" }
            hl.TabLineFill = { fg = "#BFBFBF", bg = "#0D0D0D" }
            hl.TabLineSel  = { fg = "#FFD9E8", bg = "#401929", bold = true }

            -- Telescope, for anything still using it
            hl.TelescopeNormal        = { fg = "#FFD9E8", bg = "#1B1B1B" }
            hl.TelescopeBorder        = { fg = "#67253F", bg = "#1B1B1B" }
            hl.TelescopePrompt        = { fg = "#FFD9E8", bg = "#401929" }
            hl.TelescopePromptBorder  = { fg = "#CE4A7E", bg = "#401929" }
            hl.TelescopeSelection     = { fg = "#FFD9E8", bg = "#401929", bold = true }
            hl.TelescopeMatching      = { fg = "#FD5BA2", bold = true }

            -- Neo-tree
            hl.NeoTreeNormal          = { fg = "#FFD9E8", bg = "#1B1B1B" }
            hl.NeoTreeDirectoryIcon   = { fg = "#CE4A7E" }
            hl.NeoTreeDirectoryName   = { fg = "#FFD9E8" }
            hl.NeoTreeCursorLine      = { bg = "#401929" }

            -- General blue/cyan groups that plugins commonly inherit
            hl.Identifier = { fg = "#FFD9E8" }
            hl.Special    = { fg = "#FD5BA2" }
            hl.Function   = { fg = "#FD5BA2", bold = true }
            hl.Keyword    = { fg = "#CE4A7E", bold = true }
            hl.Statement  = { fg = "#CE4A7E" }
            hl.Type       = { fg = "#FFD9E8" }
            hl.String     = { fg = "#FFAA99" }
            hl.Number     = { fg = "#FFAA99" }
            hl.Constant   = { fg = "#FFAA99" }
            hl.Operator   = { fg = "#FFAA99" }
            hl.Comment    = { fg = "#BFBFBF", italic = true }

            -- LSP references
            hl.LspReferenceText  = { bg = "#401929" }
            hl.LspReferenceRead  = { bg = "#401929" }
            hl.LspReferenceWrite = { bg = "#401929", fg = "#FD5BA2" }
          end,
        },

        config = function(_, opts)
          require("tokyonight").setup(opts)
          vim.cmd.colorscheme("tokyonight-night")
        end,
      }
    '';

    # ─────────────────────────────────────────────
    # MoniVim dashboard
    # ─────────────────────────────────────────────
    plugins.snacks = ''
      return {
        "folke/snacks.nvim",
        opts = {
          dashboard = {
            preset = {
              header = table.concat({
                " ███╗   ███╗ ██████╗ ███╗   ██╗██╗██╗   ██╗██╗███╗   ███╗",
                " ████╗ ████║██╔═══██╗████╗  ██║██║██║   ██║██║████╗ ████║",
                " ██╔████╔██║██║   ██║██╔██╗ ██║██║██║   ██║██║██╔████╔██║",
                " ██║╚██╔╝██║██║   ██║██║╚██╗██║██║╚██╗ ██╔╝██║██║╚██╔╝██║",
                " ██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██║ ╚████╔╝ ██║██║ ╚═╝ ██║",
                " ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
                "",
                "                         MoniVim",
              }, "\n"),
            },
          },
        },
      }
    '';

    # ─────────────────────────────────────────────
    # Discord Rich Presence
    # ─────────────────────────────────────────────
    plugins.cord = ''
      return {
        dir = "${pkgs.vimPlugins.cord-nvim}",
        opts = {
          usercmds = true,
          log_level = "error",

          editor = {
            client = "neovim",
            tooltip = "MoniVim",
          },

          display = {
            theme = "default",
            flavor = "dark",
          },

          idle = {
            enable = true,
            timeout = 300000,
            text = "Taking a break",
          },
        },
      }
    '';
  };
}
