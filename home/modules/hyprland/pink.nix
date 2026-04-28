{ config, lib, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;   # Keep as false for now (more stable during migration)

    settings = {
      # -------------------------------
      # Monitors
      # -------------------------------
      monitor = ",preferred,auto,1";

      # -------------------------------
      # Variables / My Programs
      # -------------------------------
      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "wofi --show drun";

      # -------------------------------
      # Autostart
      # -------------------------------
      exec-once = [
        "hyprpaper"
        "nm-applet"
      ];

      # -------------------------------
      # Environment variables
      # -------------------------------
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,lilith_hyprcursor"
        "SWWW_TRANSITION_FPS,60"
        "SWWW_TRANSITION_STEP,1"
        "SWWW_TRANSITION_TYPE,simple"
        "XFT_DPI,150"
      ];

      # -------------------------------
      # General
      # -------------------------------
      general = {
        gaps_in = 5;
        gaps_out = 15;
        border_size = 2;
        
        # === Pink Theme Border Colors ===
        "col.active_border" = "rgba(ff4d94ee) rgba(ff6eb5ee) 45deg";   # Vibrant pink gradient (main accent)
        "col.inactive_border" = "rgba(ffb6c1aa)";                      # Soft kawaii pink for inactive windows

        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      # -------------------------------
      # Decoration
      # -------------------------------
      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 0.7;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 4;
          passes = 2;
          ignore_opacity = false;
          new_optimizations = true;
          vibrancy = 0.1696;
        };
      };

      # -------------------------------
      # Animations
      # -------------------------------
      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint, 0.23, 1, 0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear, 0, 0, 1, 1"
          "almostLinear, 0.5, 0.5, 0.75, 1"
          "quick, 0.15, 0, 0.1, 1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
          "zoomFactor, 1, 7, quick"
        ];
      };

      # -------------------------------
      # Layouts
      # -------------------------------
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      # -------------------------------
      # Misc
      # -------------------------------
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      # -------------------------------
      # Input
      # -------------------------------
      input = {
        kb_layout = "br";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      # -------------------------------
      # Keybinds
      # -------------------------------
      "$mainMod" = "SUPER";
      bind = [
        # Basic
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, F, togglefloating"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo"
        "$mainMod, D, togglesplit"

        # Focus
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, J, movefocus, d"
        "$mainMod, K, movefocus, u"

        # Workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Special workspace
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll workspaces
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Media & Brightness
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"

        # Playerctl
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"

        # Screenshots
        "$mainMod, PRINT, exec, hyprshot -m window"
        "$mainMod SHIFT, PRINT, exec, hyprshot -m region"
        ", PRINT, exec, hyprshot -m output"
        "$mainMod CTRL, PRINT, exec, hyprshot -m window --clipboard-only"
        "$mainMod ALT, PRINT, exec, hyprshot -m region --freeze"

        # Waypaper
        "$mainMod, W, exec, waypaper"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
