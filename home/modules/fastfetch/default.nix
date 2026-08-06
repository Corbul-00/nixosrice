{ pkgs, ... }:

let
  accent = "#8b5cf6";
  foreground = "#d8c2f0";
  secondary = "#2a2a6e";
in
{
  programs.fastfetch = {
    enable = true;

    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        source = "~/FetchLogos/tomoew2.png";
        type = "kitty-direct";
        height = 20;
        width = 45;
        padding = {
          top = 1;
          right = 5;
        };
      };

      display = {
        separator = " -";
        color = {
          keys = accent;
          title = accent;
          output = foreground;
          separator = secondary;
        };
      };

      modules = [
        { type = "custom"; format = "󰇅 SYSTEM"; outputColor = accent; }
        { type = "host"; key = " ├󰚗 Host Entity"; }
        { type = "cpu"; key = " ├󰍛 Main Processor"; }
        { type = "gpu"; key = " ├󰈈 Visual Unit"; }
        { type = "os"; key = " ├ Core Protocol"; }
        { type = "kernel"; key = " └ Kernel Schema"; }

        { type = "custom"; format = "󰟀 PROCESSING"; outputColor = accent; }
        { type = "battery"; key = " ├󰁹 Power Sustain"; }
        { type = "memory"; key = " ├ Memory Buffer"; percent.type = [ "num" ]; }
        { type = "disk"; key = " ├ Persistent Storage"; folders = "/"; }
        { type = "packages"; key = " ├󰕰 Module Count"; }
        { type = "shell"; key = " ├ Command Interface"; }
        { type = "uptime"; key = " └󰔚 Uptime Synch"; }

        { type = "custom"; format = "󰖟 WIRED"; outputColor = accent; }
        { type = "localip"; key = " ├󱫋 Local IP Node"; showIpv6 = false; }
        { type = "users"; key = " └ Active Profiles"; compact = true; }

        {
          type = "colors";
          symbol = "block";
          paddingLeft = 1;
          block = {
            width = 4;
            range = [ 0 15 ];
          };
        }

        {
          type = "custom";
          format = "I use nix btw *smug smile*";
          outputColor = accent;
        }
      ];
    };
  };
}
