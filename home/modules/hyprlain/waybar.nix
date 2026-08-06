{ pkgs, hyprlain, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = [
      {
        layer = "top";
        position = "top";
        height = 24;
        spacing = 0;

        "modules-left" = [ "hyprland/workspaces" ];
        "modules-center" = [ "hyprland/window" ];
        "modules-right" = [
          "pulseaudio"
          "network"
          "clock"
          "group/hiddentray"
          "custom/power"
        ];

        "group/hiddentray" = {
          orientation = "horizontal";
          modules = [ "custom/expand" "cpu" "memory" "tray" ];
          drawer = {
            "transition-duration" = 250;
            "transition-left-to-right" = false;
            "click-to-reveal" = true;
          };
        };

        "hyprland/workspaces" = {
          "active-only" = false;
          "all-outputs" = true;
          "disable-scroll" = true;
          "warp-on-scroll" = false;
          format = "{icon}";
          "format-icons" = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "󰲦";
            "5" = "󰲨";
            "6" = "󰲪";
            "7" = "󰲬";
            "8" = "󰲮";
            "9" = "";
            "10" = "";
            urgent = "";
            focused = "";
            default = "";
          };
        };

        "hyprland/window" = {
          format = " {title} ";
          "separate-outputs" = true;
          "max-length" = 80;
        };

        pulseaudio = {
          format = "{icon}";
          "format-bluetooth" = " {icon} {volume}%";
          "format-muted" = "";
          "format-icons" = {
            default = [ "" "" ];
            headphone = "";
            headset = "󰋎";
          };
          "scroll-step" = 1;
          "on-click" = "pavucontrol";
          "max-volume" = 150;
          "format-alt" = "{icon} {volume}%";
        };

        network = {
          family = "ipv4";
          "format-ethernet" = "󰈀";
          "format-wifi" = "{icon}";
          "format-linked" = "󱘖";
          "format-disconnected" = "󰤮";
          "format-icons" = [ "󰤫" "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          "on-click" = "kitty -e nmtui";
          "tooltip-format" = "{icon} {signalStrength}% [{essid} - {ifname}]\n{ipaddr}/{cidr}";
          "format-alt" = "{icon} {signalStrength}%";
        };

        clock = {
          format = "{:%H:%M}";
          "format-alt" = "{:%Y-%m-%d}";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "custom/expand" = {
          format = " ";
          tooltip = false;
        };

        cpu = {
          format = "";
          tooltip = true;
          "tooltip-format" = "CPU: {usage}%";
        };

        memory = {
          format = "";
          tooltip = true;
          "tooltip-format" = "{used:0.1f}/{total:0.1f} GiB [{percentage}%]";
        };

        tray = {
          "icon-size" = 16;
          "show-passive-items" = true;
          spacing = 2;
        };

        "custom/power" = {
          format = " ";
          tooltip = false;
          "on-click" = "wlogout";
        };
      }
    ];

    # This CSS imports ~/.config/assets/palette/palette.css, which assets.nix
    # provides declaratively.
    style = builtins.readFile "${hyprlain}/src/hyprland/src/waybar/style.css";
  };

  home.packages = with pkgs; [
    font-awesome_6
    nerd-fonts.adwaita-mono
  ];
}
