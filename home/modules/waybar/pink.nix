{ config, pkgs, lib, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [{
      layer = "top";
      position = "top";
      height = 30;
      "modules-left" = [ "hyprland/workspaces" "hyprland/window" ];
      "modules-center" = [ "mpris" ];
      "modules-right" = [
        # "custom/processes"
        "network"
        "pulseaudio"
        "battery"
        "tray"
        "clock"
      ];

      "hyprland/workspaces" = {
        format = "{name}";
        persistent_workspaces = {
          "1" = []; "2" = []; "3" = []; "4" = []; "5" = [];
        };
      };
      "hyprland/window" = {
        "max-length" = 50;
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
    }];

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", "JetBrains Mono", "Font Awesome 6 Free", monospace;
        font-size: 14px;
        border: none;
        border-radius: 0;
        min-height: 0;
      }

      /* === KAWAI MOE PINK THEME CHANGES === */
      #waybar {
        background: rgba(255, 182, 193, 0.92);     /* Soft Kawaii Pink - Moe anime style */
        color: #ff4d94;                            /* Deep rose/magenta text - high contrast and cute */
        border-radius: 18px;
        border: 2px solid #ff4d94;                 /* Vibrant matching red-pink border */
        box-shadow: 0 4px 15px rgba(255, 77, 148, 0.25);
        margin: 4px;
        transition: border-radius 0.15s ease;
      }

      #workspaces button,
      #network, #pulseaudio, #battery, #clock, #tray, #mpris {
        border-radius: 0;
        background: transparent;
        padding: 0 6px;
        margin: 0 7px;
      }

      #workspaces button.active {
        margin: 6px;
        background: #ff4d94;                       /* Bright moe red-pink for active workspace */
        border-radius: 4px;
        color: #fffaf0;                            /* Soft cream/white for excellent readability */
      }

      #pulseaudio.muted {
        color: #c71585;                            /* Deep pink for muted state */
      }

      #mpris {
        padding: 0 10px;
        color: #6b2d4f;                            /* Rich rose color for media player */
      }
      /* === END OF KAWAI MOE PINK THEME === */
    '';
  };

  home.packages = with pkgs; [
    jetbrains-mono
    font-awesome_6
    playerctl
    pkgs.nerd-fonts.jetbrains-mono
  ];
}
