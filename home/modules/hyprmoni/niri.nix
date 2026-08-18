{ pkgs, ... }:

{
  # ╔══════════════════════════════════════════════════════════════╗
  # ║                     HYPRMONI × NIRI                         ║
  # ║                    Niri 25.11                              ║
  # ╚══════════════════════════════════════════════════════════════╝
  #
  # Niri is completely independent from hyprland.nix.
  #
  # This configuration intentionally uses only Niri 25.11-compatible
  # functionality.
  #
  # Hyprland remains untouched and can still be selected normally.

  xdg.configFile."niri/config.kdl".text = ''

    // ──────────────────────────────────────────────────────────────
    // ENVIRONMENT
    // ──────────────────────────────────────────────────────────────

    environment {
      XCURSOR_SIZE "24"
      HYPRCURSOR_SIZE "24"
      XFT_DPI "150"

      QT_QPA_PLATFORM "wayland"
    }


    // ──────────────────────────────────────────────────────────────
    // CURSOR
    // ──────────────────────────────────────────────────────────────

    cursor {
      xcursor-size 24
    }


    // ──────────────────────────────────────────────────────────────
    // INPUT
    // ──────────────────────────────────────────────────────────────

    input {

      keyboard {
        xkb {
          layout "br"
        }
      }

      mouse {
        accel-speed 0
      }

      touchpad {
        tap
        dwt
        drag true
        accel-speed 0.0
        accel-profile "adaptive"
        scroll-method "two-finger"
        click-method "clickfinger"
      }

      focus-follows-mouse
    }


    // ──────────────────────────────────────────────────────────────
    // LAYOUT
    // ──────────────────────────────────────────────────────────────

    layout {

      // Hyprmoni-style spacing.
      gaps 6

      center-focused-column "on-overflow"

      // We use the persistent border instead of Niri's focus ring.
      focus-ring {
        off
      }

      // Hyprmoni pink/wine border.
      border {
        on
        width 2

        active-color "#FD5BA2"
        inactive-color "#67253Fbb"
        urgent-color "#FD5BA2"
      }

      // Hyprmoni wine-colored shadow.
      shadow {
        on

        softness 18
        spread 4

        offset x=0 y=5

        draw-behind-window true

        color "#401929cc"
        inactive-color "#00000099"
      }

      // IMPORTANT:
      // New windows start at 75% of the output width.
      //
      // This is intentionally larger than the previous 50%.
      default-column-width {
        proportion 0.75
      }

      preset-column-widths {
        proportion 0.33333
        proportion 0.5
        proportion 0.75
      }

      background-color "#0D0D0D"
    }


    // ──────────────────────────────────────────────────────────────
    // STARTUP
    // ──────────────────────────────────────────────────────────────

    // Restore Hyprmoni wallpaper.
    spawn-at-startup "swww-daemon"

    spawn-at-startup "hyprmoni-wallpapers" "--restore"

    // NetworkManager tray.
    spawn-at-startup "nm-applet"

    // IMPORTANT:
    // Waybar is handled separately below.
    //
    // Do NOT use:
    //
    // spawn-at-startup "waybar"
    //
    // here, because your existing Waybar is managed by systemd.


    // ──────────────────────────────────────────────────────────────
    // SCREENSHOTS
    // ──────────────────────────────────────────────────────────────

    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"


    // ──────────────────────────────────────────────────────────────
    // ANIMATIONS
    // ──────────────────────────────────────────────────────────────

    animations {

      workspace-switch {
        spring damping-ratio=1.0 stiffness=900 epsilon=0.0001
      }

      horizontal-view-movement {
        duration-ms 120
        curve "ease-out-expo"
      }

      window-open {
        duration-ms 170
        curve "ease-out-expo"
      }

      window-close {
        duration-ms 130
        curve "ease-out-quad"
      }

      recent-windows-close {
        spring damping-ratio=0.8 stiffness=850 epsilon=0.001
      }

      overview-open-close {
        spring damping-ratio=0.85 stiffness=750 epsilon=0.0001
      }

      screenshot-ui-open {
        duration-ms 180
        curve "ease-out-quad"
      }
    }


    // ──────────────────────────────────────────────────────────────
    // WINDOW APPEARANCE
    // ──────────────────────────────────────────────────────────────

    // Inactive windows.
    window-rule {
      match is-focused=false
      opacity 0.72
    }

    // Focused windows.
    window-rule {
      match is-focused=true
      opacity 0.94
    }

    // Keep the square Hyprmoni appearance.
    window-rule {
      geometry-corner-radius 0
      clip-to-geometry true
    }


    // ──────────────────────────────────────────────────────────────
    // LAYER-SHELL
    // ──────────────────────────────────────────────────────────────

    layer-rule {
      match namespace="^waybar$"
      opacity 1.0
    }

    layer-rule {
      match namespace="^rofi$"
      opacity 0.96
    }


    // ──────────────────────────────────────────────────────────────
    // WORKSPACES
    // ──────────────────────────────────────────────────────────────

    workspace "1"
    workspace "2"
    workspace "3"
    workspace "4"
    workspace "5"
    workspace "6"
    workspace "7"
    workspace "8"
    workspace "9"
    workspace "10"

    // Hyprland special:magic equivalent.
    workspace "magic"


    // ──────────────────────────────────────────────────────────────
    // KEYBINDS
    // ──────────────────────────────────────────────────────────────

    binds {

      // ────────────────────────────────────────────────────────────
      // APPLICATIONS
      // ────────────────────────────────────────────────────────────

      Super+Q hotkey-overlay-title="Terminal: Kitty" {
        spawn "kitty";
      }

      Super+C hotkey-overlay-title="Close Window" {
        close-window;
      }

      Super+E hotkey-overlay-title="File Manager: Thunar" {
        spawn "thunar";
      }

      Super+R hotkey-overlay-title="Application Launcher: Rofi" {
        spawn "rofi" "-show" "drun";
      }

      Super+Shift+P hotkey-overlay-title="Hyprmoni Power Menu" {
        spawn "hyprmoni-power";
      }


      // ────────────────────────────────────────────────────────────
      // EXIT
      // ────────────────────────────────────────────────────────────

      Super+M hotkey-overlay-title="Exit Niri" {
        quit;
      }

      Super+Shift+E hotkey-overlay-title="Exit Niri" {
        quit;
      }


      // ────────────────────────────────────────────────────────────
      // FLOATING
      // ────────────────────────────────────────────────────────────

      Super+F hotkey-overlay-title="Toggle Floating" {
        toggle-window-floating;
      }


      // ────────────────────────────────────────────────────────────
      // COLUMN MANAGEMENT
      // ────────────────────────────────────────────────────────────

      Super+P hotkey-overlay-title="Consume / Expel Window Left" {
        consume-or-expel-window-left;
      }

      Super+D hotkey-overlay-title="Toggle Tabbed Column" {
        toggle-column-tabbed-display;
      }


      // ────────────────────────────────────────────────────────────
      // FOCUS
      // ────────────────────────────────────────────────────────────

      Super+Left {
        focus-column-left;
      }

      Super+Right {
        focus-column-right;
      }

      Super+Up {
        focus-window-up;
      }

      Super+Down {
        focus-window-down;
      }

      Super+H {
        focus-column-left;
      }

      Super+L {
        focus-column-right;
      }

      Super+J {
        focus-window-down;
      }

      Super+K {
        focus-window-up;
      }


      // ────────────────────────────────────────────────────────────
      // WORKSPACES
      // ────────────────────────────────────────────────────────────

      Super+1 {
        focus-workspace "1";
      }

      Super+2 {
        focus-workspace "2";
      }

      Super+3 {
        focus-workspace "3";
      }

      Super+4 {
        focus-workspace "4";
      }

      Super+5 {
        focus-workspace "5";
      }

      Super+6 {
        focus-workspace "6";
      }

      Super+7 {
        focus-workspace "7";
      }

      Super+8 {
        focus-workspace "8";
      }

      Super+9 {
        focus-workspace "9";
      }

      Super+0 {
        focus-workspace "10";
      }


      // ────────────────────────────────────────────────────────────
      // MOVE COLUMN TO WORKSPACE
      // ────────────────────────────────────────────────────────────

      Super+Shift+1 {
        move-column-to-workspace "1";
      }

      Super+Shift+2 {
        move-column-to-workspace "2";
      }

      Super+Shift+3 {
        move-column-to-workspace "3";
      }

      Super+Shift+4 {
        move-column-to-workspace "4";
      }

      Super+Shift+5 {
        move-column-to-workspace "5";
      }

      Super+Shift+6 {
        move-column-to-workspace "6";
      }

      Super+Shift+7 {
        move-column-to-workspace "7";
      }

      Super+Shift+8 {
        move-column-to-workspace "8";
      }

      Super+Shift+9 {
        move-column-to-workspace "9";
      }

      Super+Shift+0 {
        move-column-to-workspace "10";
      }


      // ────────────────────────────────────────────────────────────
      // MAGIC WORKSPACE
      // ────────────────────────────────────────────────────────────

      Super+S hotkey-overlay-title="Focus Magic Workspace" {
        focus-workspace "magic";
      }

      Super+Shift+S hotkey-overlay-title="Move Column to Magic Workspace" {
        move-column-to-workspace "magic";
      }


      // ────────────────────────────────────────────────────────────
      // WORKSPACE SCROLLING
      // ────────────────────────────────────────────────────────────

      Super+WheelScrollDown cooldown-ms=150 {
        focus-workspace-down;
      }

      Super+WheelScrollUp cooldown-ms=150 {
        focus-workspace-up;
      }


      // ────────────────────────────────────────────────────────────
      // COLUMN SCROLLING
      // ────────────────────────────────────────────────────────────

      Super+WheelScrollRight cooldown-ms=100 {
        focus-column-right;
      }

      Super+WheelScrollLeft cooldown-ms=100 {
        focus-column-left;
      }


      // ────────────────────────────────────────────────────────────
      // VOLUME
      // ────────────────────────────────────────────────────────────

      XF86AudioRaiseVolume allow-when-locked=true {
        spawn "wpctl" "set-volume" "-l" "1" "@DEFAULT_AUDIO_SINK@" "5%+";
      }

      XF86AudioLowerVolume allow-when-locked=true {
        spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-";
      }

      XF86AudioMute allow-when-locked=true {
        spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
      }

      XF86AudioMicMute allow-when-locked=true {
        spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
      }


      // ────────────────────────────────────────────────────────────
      // BRIGHTNESS
      // ────────────────────────────────────────────────────────────

      XF86MonBrightnessUp allow-when-locked=true {
        spawn "brightnessctl" "-e4" "-n2" "set" "5%+";
      }

      XF86MonBrightnessDown allow-when-locked=true {
        spawn "brightnessctl" "-e4" "-n2" "set" "5%-";
      }


      // ────────────────────────────────────────────────────────────
      // MEDIA
      // ────────────────────────────────────────────────────────────

      XF86AudioNext allow-when-locked=true {
        spawn "playerctl" "next";
      }

      XF86AudioPrev allow-when-locked=true {
        spawn "playerctl" "previous";
      }

      XF86AudioPlay allow-when-locked=true {
        spawn "playerctl" "play-pause";
      }

      XF86AudioPause allow-when-locked=true {
        spawn "playerctl" "play-pause";
      }


      // ────────────────────────────────────────────────────────────
      // SCREENSHOTS
      // ────────────────────────────────────────────────────────────

      Super+Print {
        screenshot-window;
      }

      Super+Shift+Print {
        screenshot;
      }

      Print {
        screenshot-screen;
      }

      Super+Ctrl+Print {
        screenshot-screen;
      }


      // ────────────────────────────────────────────────────────────
      // WALLPAPER
      // ────────────────────────────────────────────────────────────

      Super+W {
        spawn "waypaper";
      }

      Super+Shift+W {
        spawn "hyprmoni-wallpapers";
      }


      // ────────────────────────────────────────────────────────────
      // OVERVIEW
      // ────────────────────────────────────────────────────────────

      Super+O repeat=false hotkey-overlay-title="Niri Overview" {
        toggle-overview;
      }


      // ────────────────────────────────────────────────────────────
      // KEYBOARD INHIBITION
      // ────────────────────────────────────────────────────────────

      Super+Escape allow-inhibiting=false {
        toggle-keyboard-shortcuts-inhibit;
      }


      // ────────────────────────────────────────────────────────────
      // PREVIOUS WORKSPACE
      // ────────────────────────────────────────────────────────────

      Super+Tab {
        focus-workspace-previous;
      }
    }


    // ──────────────────────────────────────────────────────────────
    // OVERVIEW
    // ──────────────────────────────────────────────────────────────

    overview {
      zoom 0.55
      backdrop-color "#0D0D0D"

      workspace-shadow {
        softness 28
        spread 6
        offset x=0 y=8
        color "#401929aa"
      }
    }


    // ──────────────────────────────────────────────────────────────
    // HOTKEY OVERLAY
    // ──────────────────────────────────────────────────────────────

    hotkey-overlay {
      skip-at-startup
    }


    // ──────────────────────────────────────────────────────────────
    // CLIENT-SIDE DECORATIONS
    // ──────────────────────────────────────────────────────────────

    prefer-no-csd

  '';

  # ───────────────────────────────────────────────────────────────
  # NIRI PACKAGES
  # ───────────────────────────────────────────────────────────────

  home.packages = with pkgs; [
    xwayland-satellite
    swww
  ];
}
