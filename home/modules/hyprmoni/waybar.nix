{ pkgs, ... }:

let
  palette = import ./palette.nix;
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = [
      {
        layer = "top";
        position = "top";
        height = 32;
        spacing = 0;

        "modules-left" = [ "hyprland/workspaces" ];
        "modules-center" = [ "hyprland/window" ];
        "modules-right" = [
          "network"
          "pulseaudio"
          "clock"
          "battery"
          "custom/power"
          "group/hiddentray"
        ];

        "hyprland/workspaces" = {
          "active-only" = false;
          "all-outputs" = true;
          "disable-scroll" = true;
          "sort-by-number" = true;
          format = "{name}";
          "on-click" = "activate";
        };

        "hyprland/window" = {
          format = "{title}";
          "separate-outputs" = true;
          "max-length" = 72;
        };

        network = {
          family = "ipv4";
          "format-ethernet" = "󰈀";
          "format-wifi" = "{icon}";
          "format-linked" = "󱘖";
          "format-disconnected" = "󰤮";
          "format-icons" = [ "󰤫" "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          "on-click" = "kitty -e nmtui";
          "tooltip-format" = "{icon} {signalStrength}% [{essid} - {ifname}]\\n{ipaddr}/{cidr}";
          "format-alt" = "{icon} {signalStrength}%";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          "format-bluetooth" = " {icon} {volume}%";
          "format-muted" = "󰝟 muted";
          "format-icons" = {
            default = [ "󰕿" "󰖀" "󰕾" ];
            headphone = "";
            headset = "󰋎";
            "hands-free" = "󰋎";
            phone = "";
            portable = "";
          };
          "scroll-step" = 1;
          "on-click" = "pavucontrol";
          "max-volume" = 150;
        };

        clock = {
          format = "{:%H:%M}";
          "format-alt" = "{:%d/%m/%Y}";
          "tooltip-format" = "<big>{:%Y %B}</big>\\n<tt><small>{calendar}</small></tt>";
        };

        battery = {
          format = "{capacity}% {icon}";
          "format-charging" = "󰂄 {capacity}%";
          "format-plugged" = "󰂄 {capacity}%";
          "format-full" = "󰁹 {capacity}%";
          "format-icons" = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          states = {
            warning = 30;
            critical = 15;
          };
        };

        "custom/power" = {
          format = "";
          tooltip = false;
          "on-click" = "hyprmoni-power";
        };

        "group/hiddentray" = {
          orientation = "horizontal";
          modules = [
            "custom/eye"
            "cpu"
            "memory"
            "tray"
          ];
          drawer = {
            "transition-duration" = 250;
            "transition-left-to-right" = false;
            "click-to-reveal" = true;
          };
        };

        "custom/eye" = {
          format = "󰈈";
          # Keep this module event-free. A child click handler intercepts the
          # group drawer event and prevents the interactive tray from opening.
          # The parent drawer now owns the click exactly like Hyprlain does.
          tooltip = false;
        };

        cpu = {
          format = " {usage}%";
          "tooltip-format" = "CPU: {usage}%";
        };

        memory = {
          format = " {percentage}%";
          "tooltip-format" = "RAM: {used:0.1f}/{total:0.1f} GiB";
        };

        tray = {
          "icon-size" = 17;
          "show-passive-items" = true;
          spacing = 5;
        };
      }
    ];

    style = ''
      * {
        font-family: "Mali", "AdwaitaMono Nerd Font", "Font Awesome 6 Free", sans-serif;
        font-size: 14px;
        font-weight: 600;
        min-height: 0;
        border-radius: 0;
        text-shadow: none;
        box-shadow: none;
      }

      window#waybar {
        color: ${palette.blush};
        background: alpha(${palette.void}, 0.88);
        border-style: solid;
        border-color: ${palette.pink};
        border-width: 0 0 2px 0;
      }

      #workspaces {
        background: alpha(${palette.panel}, 0.90);
        border-right: 2px solid ${palette.wine};
      }

      #workspaces button {
        color: ${palette.blush};
        background: transparent;
        border: 0;
        border-right: 1px solid ${palette.wineDark};
        padding: 0 9px;
        margin: 0;
      }

      #workspaces button:hover {
        color: ${palette.void};
        background: ${palette.peach};
      }

      #workspaces button.visible {
        color: ${palette.blush};
        background: ${palette.wineDark};
      }

      #workspaces button.active {
        color: ${palette.void};
        background: ${palette.pink};
        border-color: ${palette.hotPink};
      }

      #workspaces button.urgent {
        color: ${palette.void};
        background: ${palette.hotPink};
      }

      #window {
        color: ${palette.blush};
        background: alpha(${palette.panel}, 0.74);
        border-left: 2px solid ${palette.wine};
        border-right: 2px solid ${palette.wine};
        padding: 0 16px;
      }

      #network,
      #pulseaudio,
      #clock,
      #battery,
      #custom-power,
      #custom-eye,
      #cpu,
      #memory,
      #tray {
        color: ${palette.blush};
        background: alpha(${palette.panel}, 0.88);
        border-left: 1px solid ${palette.wine};
        padding: 0 9px;
      }

      #network:hover,
      #pulseaudio:hover,
      #clock:hover,
      #battery:hover,
      #custom-eye:hover,
      #cpu:hover,
      #memory:hover {
        color: ${palette.hotPink};
        background: ${palette.wineDark};
      }

      #clock {
        color: ${palette.peach};
      }

      #pulseaudio.muted,
      #network.disconnected,
      #battery.warning {
        color: ${palette.pink};
      }

      #battery.critical:not(.charging) {
        color: ${palette.void};
        background: ${palette.hotPink};
      }

      #custom-power {
        color: ${palette.hotPink};
        border: 2px solid ${palette.pink};
        border-width: 0 2px;
        padding: 0 11px;
      }

      #custom-power:hover {
        color: ${palette.void};
        background: ${palette.hotPink};
      }

      #custom-eye {
        color: ${palette.hotPink};
        padding: 0 11px;
      }

      tooltip,
      tooltip * {
        color: ${palette.blush};
        background: ${palette.panel};
        border-color: ${palette.pink};
        border-radius: 0;
      }

      #tray menu {
        color: ${palette.blush};
        background: ${palette.panel};
        border: 2px solid ${palette.pink};
        border-radius: 0;
      }
    '';
  };

  home.packages = with pkgs; [
    pavucontrol
    rofi
  ];
}
