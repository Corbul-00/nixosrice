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
        # "custom/processes"   # ← comentado por enquanto (descomente quando tiver o script)
        "network"
        "pulseaudio"
        "battery"
        "tray"
        "clock"
      ];
      # ... (todo o resto do config continua igual)
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
        "on-click" = "eww open --toggle mpris-dashboard";
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
      #waybar {
        background: rgba(40, 30, 60, 0.88);
        color: #d8c2f0;
        border-radius: 18px;
        border: 2px solid #33ccff;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.35);
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
        background: #8b5cf6;
        border-radius: 4px;
        color: white;
      }
      #pulseaudio.muted {
        color: #f38ba8;
      }
      #mpris {
        padding: 0 10px;
        color: #c4b5fd;
      }
    '';
  };
  # Removemos o home.file do processes.sh por enquanto
  # Quando você quiser adicionar o script de verdade, descomente o bloco abaixo:
  # home.file.".config/waybar/scripts/processes.sh" = {
  #   source = ./scripts/processes.sh;
  #   executable = true;
  # };

  xdg.configFile."eww/eww.yuck".source = ./eww/eww.yuck;
  xdg.configFile."eww/eww.scss".source = ./eww/eww.scss;
  xdg.configFile."eww/scripts/mpris-info.sh" = {
    source = ./eww/scripts/mpris-info.sh;
    executable = true;
  };

  home.packages = with pkgs; [
     jetbrains-mono
     font-awesome_6
     playerctl
     pkgs.nerd-fonts.jetbrains-mono# Ensure Nerd Font glyphs are available for Waybar icons
     eww
     jq
  ];
}
