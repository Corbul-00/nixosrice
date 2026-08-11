{ ... }:

let
  palette = import ./palette.nix;
  hex = color: builtins.substring 1 6 color;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    # NixOS starts Hyprland through UWSM in configuration.nix.
    systemd.enable = false;

    settings = {
      monitor = ",preferred,auto,1";

      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "rofi -show drun";
      "$mainMod" = "SUPER";

      exec-once = [
        "swww-daemon"
        "hyprmoni-wallpapers --restore"
        "nm-applet"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "XFT_DPI,150"
      ];

      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
        "col.active_border" = "rgba(${hex palette.hotPink}ff)";
        "col.inactive_border" = "rgba(${hex palette.wine}bb)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 0;
        rounding_power = 2;

        # The whole desktop is slightly translucent; unfocused windows recede
        # much more strongly, as requested.
        active_opacity = 0.94;
        inactive_opacity = 0.72;
        fullscreen_opacity = 1.0;
        dim_inactive = true;
        dim_strength = 0.18;
        dim_special = 0.35;

        shadow = {
          enabled = true;
          range = 18;
          render_power = 4;
          color = "rgba(${hex palette.wineDark}cc)";
          color_inactive = "rgba(00000099)";
        };

        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          ignore_opacity = false;
          new_optimizations = true;
          noise = 0.025;
          contrast = 1.08;
          brightness = 0.82;
          vibrancy = 0.16;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "linear, 0.00, 0.00, 1.00, 1.00"
          "monikaEase, 0.22, 1.00, 0.36, 1.00"
          "monikaPop, 0.16, 1.12, 0.30, 1.00"
          "quickFade, 0.40, 0.00, 0.20, 1.00"
        ];
        animation = [
          "windows, 1, 4, monikaEase"
          "windowsIn, 1, 4, monikaPop, popin 92%"
          "windowsOut, 1, 3, quickFade, popin 94%"
          "border, 1, 5, monikaEase"
          "fade, 1, 3, quickFade"
          "layers, 1, 4, monikaEase, fade"
          "workspaces, 1, 3, monikaEase, slidefade 12%"
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
        background_color = "rgb(${hex palette.void})";
        focus_on_activate = true;
      };

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

      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, F, togglefloating"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo"
        "$mainMod, D, togglesplit"
        "$mainMod SHIFT, P, exec, hyprmoni-power"

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
        "$mainMod SHIFT, W, exec, hyprmoni-wallpapers"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
