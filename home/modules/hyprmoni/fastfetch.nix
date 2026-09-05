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

            # Only set height so Fastfetch keeps the image's
            # original aspect ratio automatically.
            height = 18;

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
      # DISPLAY
      # ============================================================

      display = {
        separator = "  ";

        color = {
          keys = palette.pink;
          title = palette.hotPink;
          output = palette.blush;
          separator = palette.wine;
        };

        key = {
          width = 13;
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

        # ==========================================================
        # SYSTEM CORE
        # ==========================================================

        {
          type = "custom";
          format = "╭──────────── System Core ────────────╮";
        }

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

        # ==========================================================
        # SOFTWARE
        # ==========================================================

        {
          type = "custom";
          format = "╭───────────── Software ──────────────╮";
        }

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

        # ==========================================================
        # HARDWARE
        # ==========================================================

        {
          type = "custom";
          format = "╭───────────── Hardware ──────────────╮";
        }

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

        # ==========================================================
        # COLORS
        # ==========================================================

        {
          type = "custom";
          format = "╭────────────── Colors ───────────────╮";
        }

        {
          type = "colors";
          key = "󰏘  Colors";
        }
      ];
    };
  };
}
