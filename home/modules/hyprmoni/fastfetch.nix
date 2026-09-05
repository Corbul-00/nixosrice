{ ... }:

let
  palette = import ./palette.nix;
  assets = toString ./assets;
  customImage = "${assets}/fastfetch.png";
  hasCustomImage = builtins.pathExists customImage;

  # ============================================================
  #                    EASY TWEAK SETTINGS
  # ============================================================

  # ------------------------------------------------------------
  # CUSTOM IMAGE SIZE
  #
  # These values control the image independently.
  #
  # width  = horizontal terminal cells
  # height = vertical terminal cells
  #
  # Recommended starting point:
  # width  = 24
  # height = 18
  #
  # IMPORTANT:
  # If preserveAspectRatio is true, Fastfetch will prevent
  # distortion and prioritize keeping the original image ratio.
  # ------------------------------------------------------------

  imageWidth = 24;
  imageHeight = 18;

  # ------------------------------------------------------------
  # IMAGE POSITION / SPACING
  #
  # imagePaddingRight:
  # Space between image and Fastfetch information.
  #
  # imagePaddingTop:
  # Moves the image down.
  # ------------------------------------------------------------

  imagePaddingRight = 5;
  imagePaddingTop = 1;

  # ------------------------------------------------------------
  # INFORMATION SPACING
  #
  # keyWidth:
  # Width reserved for icons + labels.
  #
  # separator:
  # Space between label and system information.
  #
  # Recommended:
  # keyWidth = 15 or 16
  # ------------------------------------------------------------

  keyWidth = 16;

  separator = "    ";

  # ------------------------------------------------------------
  # SECTION WIDTH
  #
  # This controls the visual width of the section headers.
  #
  # Increase the amount of ─ if your terminal is wider and
  # you want a larger information structure.
  # ------------------------------------------------------------

  systemHeader = "╭────────────────── System Core ──────────────────╮";

  softwareHeader = "╭─────────────────── Software ────────────────────╮";

  hardwareHeader = "╭─────────────────── Hardware ────────────────────╮";

  colorsHeader = "╭──────────────────── Colors ─────────────────────╮";

in
{
  programs.fastfetch = {
    enable = true;

    settings = {

      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      # ==========================================================
      #                         LOGO
      # ==========================================================

      logo =
        if hasCustomImage then
          {
            type = "kitty-direct";
            source = customImage;

            # ======================================================
            # IMAGE DIMENSIONS
            #
            # Change these variables at the top of the file:
            #
            # imageWidth
            # imageHeight
            # ======================================================

            width = imageWidth;
            height = imageHeight;

            # Prevent the image from becoming stretched.
            preserveAspectRatio = true;

            # ======================================================
            # IMAGE POSITION
            # ======================================================

            padding = {
              top = imagePaddingTop;
              right = imagePaddingRight;
            };
          }

        else
          {
            type = "builtin";
            source = "nixos_small";

            color."1" = palette.pink;
            color."2" = palette.blush;

            padding = {
              top = imagePaddingTop;
              right = imagePaddingRight;
            };
          };

      # ==========================================================
      #                    GLOBAL DISPLAY
      # ==========================================================

      display = {

        # Space between key and value.
        separator = separator;

        color = {

          # Icons and module names.
          keys = palette.pink;

          # Section/title emphasis.
          title = palette.hotPink;

          # Hardware/system information.
          output = palette.blush;

          # Separators and decorative elements.
          separator = palette.wine;
        };

        key = {

          # Width of:
          #
          # 󰣇 OS
          #  Kernel
          # etc.
          #
          width = keyWidth;
        };
      };

      # ==========================================================
      #                        MODULES
      # ==========================================================

      modules = [

        # ========================================================
        # TITLE
        # ========================================================

        {
          type = "title";

          key = "";

          format = "{user-name}@{host-name}";
        }

        # ========================================================
        # SYSTEM CORE
        # ========================================================

        {
          type = "custom";
          format = systemHeader;
        }

        {
          type = "os";

          # Correct NixOS Nerd Font icon.
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

        # ========================================================
        # SOFTWARE
        # ========================================================

        {
          type = "custom";
          format = softwareHeader;
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

        # ========================================================
        # HARDWARE
        # ========================================================

        {
          type = "custom";
          format = hardwareHeader;
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

        # ========================================================
        # COLORS
        # ========================================================

        {
          type = "custom";
          format = colorsHeader;
        }

        {
          type = "colors";

          key = "󰏘  Colors";
        }
      ];
    };
  };
}
