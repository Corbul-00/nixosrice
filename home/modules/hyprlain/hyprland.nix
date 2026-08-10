{ ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;

    settings = {
      # Keep the monitor behavior from your existing configuration.
      monitor = ",preferred,auto,1";

      # Keep your applications and key names. Only the launcher changes from
      # Wofi to the Hyprlain-themed Rofi instance.
      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "rofi -show drun";
      "$mainMod" = "SUPER";

      exec-once = [
        "swww-daemon"
        "hyprlain-wallpapers --restore"
        "nm-applet"
        "eww daemon"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,lilith_hyprcursor"
        "XFT_DPI,150"
      ];

      general = {
        gaps_in = 3;
        gaps_out = 6;
        border_size = 2;
        "col.active_border" = "rgba(ce7688ff)";
        "col.inactive_border" = "rgba(5d333ccc)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 0;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 0.8;
        dim_inactive = true;
        dim_strength = 0.4;
        dim_special = 0.6;

        shadow = {
          enabled = true;
          range = 20;
          render_power = 4;
          color = "rgba(5d333ccc)";
          color_inactive = "rgba(000000cc)";
        };

        blur = {
          enabled = true;
          size = 4;
          passes = 2;
          ignore_opacity = false;
          new_optimizations = true;
          noise = 0.05;
          contrast = 1.1;
          brightness = 0.9;
          vibrancy = 0.2;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "linear, 0.00, 0.00, 1.00, 1.00"
          "easeOutQuint, 0.23, 1.00, 0.32, 1.00"
          "almostLinear, 0.50, 0.50, 0.75, 1.00"
          "quick, 0.15, 0.00, 0.10, 1.00"
          "overshoot, 0.05, 0.90, 0.10, 1.10"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.5, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, overshoot, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "workspaces, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master.new_status = "master";

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        background_color = "rgb(000000)";
        focus_on_activate = true;
      };

      # Preserve your Brazilian keyboard, mouse and touchpad behavior.
      input = {
        kb_layout = "br";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad.natural_scroll = false;
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      # These are your original binds, including media, brightness,
      # screenshots, workspaces and Waypaper.
      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, F, togglefloating"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo"
        "$mainMod, D, togglesplit"
        "$mainMod SHIFT, P, exec, wlogout"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, J, movefocus, d"
        "$mainMod, K, movefocus, u"

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

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"

        "$mainMod, PRINT, exec, hyprshot -m window"
        "$mainMod SHIFT, PRINT, exec, hyprshot -m region"
        ", PRINT, exec, hyprshot -m output"
        "$mainMod CTRL, PRINT, exec, hyprshot -m window --clipboard-only"
        "$mainMod ALT, PRINT, exec, hyprshot -m region --freeze"
        "$mainMod, W, exec, waypaper"
        "$mainMod SHIFT, W, exec, hyprlain-wallpapers"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
