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
            colors.bg = "#0f0e17"
            colors.bg_dark = "#0a0a12"
            colors.bg_float = "NONE"
            colors.bg_sidebar = "NONE"
          end,
        },
        config = function(_, opts)
          require("tokyonight").setup(opts)
          vim.cmd.colorscheme("tokyonight-night")
        end,
      }
    '';

    plugins.snacks = ''
      return {
        "folke/snacks.nvim",
        opts = {
          dashboard = {
            preset = {
              header = table.concat({
                " ███████╗██╗     ██╗  ██╗██╗   ██╗",
                " ██╔════╝██║     ██║ ██╔╝██║   ██║",
                " █████╗  ██║     █████╔╝ ██║   ██║",
                " ██╔══╝  ██║     ██╔═██╗ ╚██╗ ██╔╝",
                " ██║     ███████╗██║  ██╗ ╚████╔╝ ",
                " ╚═╝     ╚══════╝╚═╝  ╚═╝  ╚═══╝  ",
                "",
                "            FlakaVim",
              }, "\n"),
            },
          },
        },
      }
    '';
  };
}
