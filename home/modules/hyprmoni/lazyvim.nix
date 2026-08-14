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

    # Hyprmoni colorscheme
    plugins.colorscheme = ''
      return {
        "folke/tokyonight.nvim",
        opts = {
          transparent = true,
          styles = {
            sidebars = "transparent",
            floats = "transparent",
          },
          on_colors = function(colors)
            colors.bg = "#0D0D0D"
            colors.bg_dark = "#0D0D0D"
            colors.bg_float = "NONE"
            colors.bg_sidebar = "NONE"

            colors.fg = "#FFD9E8"
            colors.fg_dark = "#BFBFBF"

            colors.blue = "#CE4A7E"
            colors.cyan = "#FFAA99"
            colors.magenta = "#FD5BA2"
            colors.purple = "#67253F"
            colors.red = "#FD5BA2"
            colors.orange = "#FFAA99"
            colors.yellow = "#FFAA99"
            colors.green = "#CE4A7E"

            colors.comment = "#BFBFBF"
            colors.border = "#67253F"
          end,
        },
        config = function(_, opts)
          require("tokyonight").setup(opts)
          vim.cmd.colorscheme("tokyonight-night")
        end,
      }
    '';

    # MoniVim dashboard
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

    # Discord Rich Presence
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
