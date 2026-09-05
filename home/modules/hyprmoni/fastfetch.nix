{ ... }:

let
  palette = import ./palette.nix;
  assets = toString ./assets;
  customImage = "${assets}/fastfetch.png";
  hasCustomImage = builtins.pathExists customImage;
in
{
  programs.fastfetch = {
    enable = true;

    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      # ============================================================
      # LOGO
      # ============================================================

      logo =
        if hasCustomImage then
          {
            type = "kitty-direct";
            source = customImage;

            # Larger visual presence, closer to the reference layout.
            width = 32;
            height = 24;

            padding = {
              top = 1;
              right = 5;
            };
          }
        else
          {
            type = "builtin";
            source = "nixos_small";

            color."1" = palette.pink;
            color."2" = palette.blush;

            padding = {
              top = 1;
              right = 5;
            };
          };

      # ============================================================
      # GLOBAL DISPLAY
      # ============================================================

      display = {
        separator = "  ";

        color = {
          keys = palette.pink;
          title = palette.hotPink;
          output = palette.blush;
          separator = palette.wine;
        };

        # Gives the information a wider and more spacious appearance.
        key = {
          width = 15;
        };
      };

      # ============================================================
      # MODULES
      # ============================================================

      modules = [

        # ----------------------------------------------------------
        # TITLE
        # ----------------------------------------------------------

        {
          type = "title";
          key = "";
          format = "{user-name}@{host-name}";
        }

        {
          type = "custom";
          format = "╭────────────── System Core ──────────────╮";
        }

        # ----------------------------------------------------------
        # SYSTEM CORE
        # ----------------------------------------------------------

        {
          type = "os";
          key = "󰣇  OS";
          format = "{pretty-name}";
        }

        {
          type = "kernel";
          key = "  Kernel";
        }

        {
          type = "uptime";
          key = "󰔛  Uptime";
        }

        {
          type = "custom";
          format = "╭─────────────── Software ────────────────╮";
        }

        # ----------------------------------------------------------
        # SOFTWARE
        # ----------------------------------------------------------

        {
          type = "wm";
          key = "󱂬  WM";
        }

        {
          type = "shell";
          key = "  Shell";
        }

        {
          type = "packages";
          key = "󰏖  Packages";
        }

        {
          type = "custom";
          format = "╭─────────────── Hardware ────────────────╮";
        }

        # ----------------------------------------------------------
        # HARDWARE
        # ----------------------------------------------------------

        {
          type = "cpu";
          key = "  CPU";
        }

        {
          type = "gpu";
          key = "󰢮  GPU";
        }

        {
          type = "memory";
          key = "  RAM";

          percent.type = [ "num" ];
        }

        {
          type = "disk";
          key = "  Disk";
          folders = "/";
        }

        {
          type = "custom";
          format = "╭──────────────── Colors ─────────────────╮";
        }

        # ----------------------------------------------------------
        # COLORS
        # ----------------------------------------------------------

        {
          type = "colors";
          key = "󰏘  Colors";
        }
      ];
    };
  };
}
