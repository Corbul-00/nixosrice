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
      # LOGO / IMAGE
      # ============================================================

      logo =
        if hasCustomImage then
          {
            type = "kitty-direct";
            source = customImage;

            # ======================================================
            # IMAGE SIZE
            #
            # CHANGE THIS if you want the image larger/smaller.
            #
            # Recommended range:
            #   14 = small
            #   16 = balanced (recommended)
            #   18 = large
            # ======================================================

            height = 14;

            padding = {
              top = 1;

              # ====================================================
              # SPACE BETWEEN IMAGE AND SYSTEM INFORMATION
              #
              # Increase = more horizontal separation.
              # Decrease = information moves closer to image.
              # ====================================================

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
      # GLOBAL DISPLAY SETTINGS
      # ============================================================

      display = {

        # ==========================================================
        # SPACE BETWEEN KEY AND VALUE
        #
        # Increase for more breathing room.
        # ==========================================================

        separator = "   ";

        color = {
          keys = palette.pink;
          title = palette.hotPink;
          output = palette.blush;
          separator = palette.wine;
        };

        key = {

          # ========================================================
          # KEY COLUMN WIDTH
          #
          # Increase = values move further right.
          #
          # Recommended:
          #   13 = compact
          #   15 = balanced
          #   17 = spacious
          # ========================================================

          width = 14;
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

          # Change the amount of ─ if you want a wider header.
          format = "╭──────────────── System Core ────────────────╮";
        }

        {
          type = "os";

          # NixOS logo.
          key = "  OS";

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
          format = "╭───────────────── Software ──────────────────╮";
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
          format = "╭───────────────── Hardware ──────────────────╮";
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
          format = "╭────────────────── Colors ───────────────────╮";
        }

        {
          type = "colors";
          key = "󰏘  Colors";
        }
      ];
    };
  };
}
