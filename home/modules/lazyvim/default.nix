{ pkgs, lazyvim-nix, ... }:
{
  imports = [
    lazyvim-nix.homeManagerModules.default
  ];

  programs.lazyvim = {
    enable = true;

    # Core dependencies (git, ripgrep, fd are already included by installCoreDependencies)
    installCoreDependencies = true;

    extraPackages = with pkgs; [
      nodejs
      python3
    ];

    # Custom dashboard header: big FLKV + small FlakaVim underneath
    config.options = ''
      -- FLKV dashboard header
      vim.g.lazyvim_opts = vim.g.lazyvim_opts or {}
      vim.g.lazyvim_opts.defaults = vim.g.lazyvim_opts.defaults or {}
      vim.g.lazyvim_opts.defaults.header = {
        "",
        " ███████╗██╗     ██╗  ██╗██╗   ██╗",
        " ██╔════╝██║     ██║ ██╔╝██║   ██║",
        " █████╗  ██║     █████╔╝ ██║   ██║",
        " ██╔══╝  ██║     ██╔═██╗ ╚██╗ ██╔╝",
        " ██║     ███████╗██║  ██╗ ╚████╔╝ ",
        " ╚═╝     ╚══════╝╚═╝  ╚═╝  ╚═══╝  ",
        "",
        "            FlakaVim",
        "",
      }
    '';

    # Tokyonight colorscheme with transparency
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
  };
}
