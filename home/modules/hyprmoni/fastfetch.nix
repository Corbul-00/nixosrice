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
  # Square image container.
  #
  # Change BOTH values together to keep it square.
  #
  # Smaller:
  #   imageWidth = 16;
  #   imageHeight = 16;
  #
  # Current balanced size:
  # ------------------------------------------------------------

  imageWidth = 18;
  imageHeight = 18;

  # ------------------------------------------------------------
  # IMAGE POSITION / SPACING
  # ------------------------------------------------------------

  imagePaddingRight = 5;
  imagePaddingTop = 1;

  # ------------------------------------------------------------
  # INFORMATION SPACING
  #
  # keyWidth:
  # Space reserved for icon + module name.
  #
  # separator:
  # Space between label and information.
  # ------------------------------------------------------------

  keyWidth = 17;

  separator = "    ";

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
            # Keep these equal for a square image container.
            # ======================================================

            width = imageWidth;
            height = imageHeight;

            # NOTE:
            #
            # Set to false so Fastfetch uses the exact square
            # dimensions instead of automatically changing one
            # dimension to preserve the original image ratio.
            #
            # If the source image itself isn't square, this may
            # stretch it slightly.
            preserveAspectRatio = false;

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

        separator = separator;

        color = {
          keys = palette.pink;
          title = palette.hotPink;
          output = palette.blush;
          separator = palette.wine;
        };

        key = {
          width = keyWidth;
        };
      };

      # ==========================================================
      #                        MODULES
      # ==========================================================

      modules = [

        # --------------------------------------------------------
        # TITLE
        # --------------------------------------------------------

        {
          type = "title";

          key = "";

          format = "{user-name}@{host-name}";
        }

        # ========================================================
        # SYSTEM INFORMATION
        # ========================================================

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

        # --------------------------------------------------------
        # SPACE BETWEEN SYSTEM AND SOFTWARE
        # --------------------------------------------------------

        {
          type = "custom";
          format = "";
        }

        # ========================================================
        # SOFTWARE INFORMATION
        # ========================================================

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

        # --------------------------------------------------------
        # SPACE BETWEEN SOFTWARE AND HARDWARE
        # --------------------------------------------------------

        {
          type = "custom";
          format = "";
        }

        # ========================================================
        # HARDWARE INFORMATION
        # ========================================================

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

        # --------------------------------------------------------
        # SPACE BEFORE COLORS
        # --------------------------------------------------------

        {
          type = "custom";
          format = "";
        }

        # ========================================================
        # COLORS
        # ========================================================

        {
          type = "colors";

          key = "󰏘  Colors";
        }
      ];
    };
  };
}
