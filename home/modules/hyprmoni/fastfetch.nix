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

      logo =
        if hasCustomImage then
          {
            type = "kitty-direct";
            source = customImage;
            width = 36;
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
            color."1" = "magenta";
            color."2" = "white";
            padding = {
              top = 1;
              right = 5;
            };
          };

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

      modules = [
        {
          type = "title";
          key = "";
          format = "{user-name}@{host-name}";
        }
        {
          type = "os";
          key = "  OS";
          format = "{pretty-name}";
        }
        {
          type = "kernel";
          key = "  Kernel";
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
        {
          type = "packages";
          key = "󰏖  Packages";
        }
        {
          type = "shell";
          key = "  Shell";
        }
        {
          type = "uptime";
          key = "󰔛  Uptime";
        }
      ];
    };
  };
}
