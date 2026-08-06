{ pkgs, hyprlain, ... }:

let
  # Hyprlain ships this exact Lain head as a Neofetch logo. Fastfetch uses
  # $1 for its first configurable logo color, while Neofetch uses ${c1}.
  lainLogo = pkgs.writeText "hyprlain-fastfetch-logo" (
    builtins.replaceStrings
      [ "\${c1}" ]
      [ "$1" ]
      (builtins.readFile "${hyprlain}/src/hyprland/src/neofetch/logo")
  );
in
{
  programs.fastfetch = {
    enable = true;

    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        type = "file";
        source = "${lainLogo}";
        color."1" = "magenta";
        padding = {
          top = 1;
          right = 5;
        };
      };

      display = {
        separator = " -";
        color = {
          keys = "magenta";
          title = "magenta";
          output = "yellow";
          separator = "white";
        };
      };

      modules = [
        { type = "custom"; format = "󰇅 SYSTEM"; outputColor = "magenta"; }
        { type = "host"; key = " ├󰚗 Host Entity"; }
        { type = "cpu"; key = " ├󰍛 Main Processor"; }
        { type = "gpu"; key = " ├󰈈 Visual Unit"; }
        { type = "os"; key = " ├ Core Protocol"; }
        { type = "kernel"; key = " └ Kernel Schema"; }

        { type = "custom"; format = "󰟀 PROCESSING"; outputColor = "magenta"; }
        { type = "battery"; key = " ├󰁹 Power Sustain"; }
        { type = "memory"; key = " ├ Memory Buffer"; percent.type = [ "num" ]; }
        { type = "disk"; key = " ├ Persistent Storage"; folders = "/"; }
        { type = "packages"; key = " ├󰕰 Module Count"; }
        { type = "shell"; key = " ├ Command Interface"; }
        { type = "uptime"; key = " └󰔚 Uptime Synch"; }

        { type = "custom"; format = "󰖟 WIRED"; outputColor = "magenta"; }
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
      ];
    };
  };
}
