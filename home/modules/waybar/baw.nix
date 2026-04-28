{ config, pkgs, lib, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = [
      # === LEFT BAR: NixOS icon + Workspaces ===
      {
        name = "leftbar";  # Helps with CSS targeting if needed
        layer = "top";
        position = "top";
        height = 32;
        width = 420;           # Adjust to fit your workspaces comfortably
        margin = "4px 4px 0 4px";

        modules-left = [ "custom/nixos" "hyprland/workspaces" ];

        "custom/nixos" = {
          format = "󱄅";  # Official-ish NixOS logo (Nerd Font)
          tooltip = false;
        };

        "hyprland/workspaces" = {
          format = "{name}";
          persistent_workspaces = {
            "1" = []; "2" = []; "3" = []; "4" = []; "5" = [];
          };
          "on-click" = "activate";
        };
      }

      # === CENTER BAR: Custom scrolling/static phrase ===
      {
        name = "centerbar";
        layer = "top";
        position = "top";
        height = 32;
        width = 380;           # Adjust based on your screen
        margin = "4px 0 0 0";

        modules-center = [ "custom/waifu" ];

        "custom/waifu" = {
          format = "{}";
          exec = pkgs.writeShellScript "waifu-phrase" ''
            echo "Simping 4 waifus... Again."
            # To make it update periodically (optional):
            # sleep 30; echo "Simping 4 waifus... Again."
          '';
          interval = 60;       # Update every 60s (harmless for static text)
          tooltip = false;
        };
      }

      # === RIGHT BAR: All your system modules ===
      {
        name = "rightbar";
        layer = "top";
        position = "top";
        height = 32;
        # width will auto-expand or you can set a large value / omit for full remaining space
        margin = "4px 4px 0 4px";

        "modules-left" = [ "hyprland/window" ];   # Active window title on right bar
        "modules-center" = [ "mpris" ];
        "modules-right" = [
          "network"
          "pulseaudio"
          "battery"
          "tray"
          "clock"
        ];

        "hyprland/window" = {
          "max-length" = 60;
          "tooltip" = false;
        };

        mpris = {
          format = "{player_icon} {title} - {artist}";
          "format-paused" = "{player_icon} {title} - {artist} (Paused)";
          interval = 1;
          "tooltip-format" = "{album}\n{status}\n{position}/{length}";
          "player-icons" = {
            default = "🎵";
            spotify = "🎶";
            firefox = "🌐";
          };
        };

        network = {
          interface = "wlan0";
          "format-wifi" = "{icon}";
          "format-ethernet" = "󰈀";
          "format-disconnected" = "󰌙";
          "tooltip-format-wifi" = "{essid} ({signalStrength}%)";
          "tooltip-format-ethernet" = "Connected";
          "tooltip-format-disconnected" = "Disconnected";
          "format-icons" = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          "on-click" = "kitty -e nmtui";
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          "format-muted" = "󰝟";
          "format-icons" = { default = [ "󰕿" "󰖀" "󰕾" ]; };
          "tooltip-format" = "Volume: {volume}%";
        };

        battery = {
          format = "{capacity}% {icon}";
          "format-icons" = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          bat = "BAT1";
        };

        clock = {
          format = "{:%H:%M %d/%m/%Y}";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt>{calendar}</tt>";
          "on-click" = ''notify-send "$(cal)" -t 10000'';
        };

        tray = {
          "icon-size" = 18;
          spacing = 10;
        };
      }
    ];

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", "JetBrains Mono", monospace;
        font-size: 14px;
        border: none;
        min-height: 0;
      }

      window#waybar {
        background: rgba(30, 30, 35, 0.92);   /* dark grey */
        color: #e0e0e0;
        border: 2px solid #ffffff;
        border-radius: 10px;                  /* subtle square-ish rounding */
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.4);
        margin: 4px;
      }

      /* Make each bar look separated and clean */
      #leftbar, #centerbar, #rightbar {
        border-radius: 10px;
        padding: 0 6px;
      }

      #workspaces button {
        padding: 0 8px;
        margin: 0 3px;
        border-radius: 4px;
        color: #e0e0e0;
      }

      #workspaces button.active {
        background: #ffffff;
        color: #1e1e23;
        font-weight: bold;
      }

      #custom-nixos {
        margin-right: 8px;
        font-size: 18px;
        color: #ffffff;
      }

      #custom-waifu {
        font-style: italic;
        color: #bbbbbb;
        padding: 0 12px;
      }

      #window, #mpris, #network, #pulseaudio, #battery, #clock, #tray {
        padding: 0 8px;
        margin: 0 4px;
      }

      #pulseaudio.muted { color: #ff7f7f; }
      #mpris { color: #cccccc; }
    '';
  };

  home.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    font-awesome_6
    playerctl
  ];
}
