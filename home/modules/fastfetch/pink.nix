{ config, pkgs, lib, ... }:

let
  pinkfetchConfig = pkgs.writeTextFile {
    name = "pinkfetch-config.jsonc";
    text = builtins.toJSON {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        source = "nixos";
        color = {
          "1" = "bright_magenta";
          "2" = "bright_red";
        };
        padding = {
          top = 1;
          left = 1;
          right = 1;
        };
      };

      display = {
        separator = " → ";
        color = {
          keys   = "bright_magenta";
          title  = "bright_red";
          output = "magenta";
        };
      };

      modules = [
        {
          type = "title";
          color = {
            user = "bright_magenta";
            at   = "bright_red";
            host = "bright_magenta";
          };
        }
        { type = "separator"; str = "─"; color = "bright_magenta"; }
        { type = "os";       key = "  OS      "; keyColor = "bright_magenta"; }
        { type = "kernel";   key = "  Kernel  "; keyColor = "bright_red"; }
        { type = "uptime";   key = "󰅐  Uptime  "; keyColor = "bright_magenta"; }
        { type = "packages"; key = "  Pkgs    "; keyColor = "bright_red"; }
        { type = "shell";    key = "  Shell   "; keyColor = "bright_magenta"; }
        { type = "display";  key = "󰍹  Display "; keyColor = "bright_red"; }
        { type = "wm";       key = "  WM      "; keyColor = "bright_magenta"; }
        { type = "terminal"; key = "  Term    "; keyColor = "bright_red"; }
        { type = "cpu";      key = "  CPU     "; keyColor = "bright_magenta"; }
        { type = "gpu";      key = "󰢮  GPU     "; keyColor = "bright_red"; }
        { type = "memory";   key = "  RAM     "; keyColor = "bright_magenta"; }
        { type = "disk";     key = "  Disk    "; keyColor = "bright_red"; }
        { type = "separator"; str = "─"; color = "bright_magenta"; }
        {
          type = "colors";
          symbol = "circle";
          paddingLeft = 2;
        }
      ];
    };
  };

  pinkfetch = pkgs.writeShellScriptBin "pinkfetch" ''
    exec ${pkgs.fastfetch}/bin/fastfetch --config ${pinkfetchConfig} "$@"
  '';

in
{
  home.packages = [ pinkfetch ];
}
