{ pkgs, ... }:

{
  # ╔══════════════════════════════════════════════════════════════╗
  # ║                     HYPRMONI × NIRI                         ║
  # ║              Niri 25.11 configuration for NixOS             ║
  # ╚══════════════════════════════════════════════════════════════╝
  #
  # This module is completely independent from hyprland.nix.
  #
  # Hyprland and Niri can coexist and be selected independently
  # from the display manager.
  #
  # The goal here is not to imitate Hyprland's compositor internals,
  # but to preserve the Hyprmoni visual language, applications,
  # keybind philosophy, wallpaper workflow and desktop behavior
  # using Niri's native model.
  #
  # IMPORTANT:
  # This configuration targets Niri 25.11.
  # Newer Niri-only features such as background-effect are omitted.

  xdg.configFile."niri/config.kdl".text = ''

    // ╔══════════════════════════════════════════════════════════════╗
    // ║                     HYPRMONI × NIRI                         ║
    // ║                    Monika / Niri                           ║
    // ╚══════════════════════════════════════════════════════════════╝


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

      touchpad {
        // Natural scrolling intentionally disabled.
      }

      mouse {
        // Same neutral acceleration used by the Hyprland setup.
        accel-speed 0
      }

      // Equivalent to Hyprland's follow_mouse behavior.
      focus-follows-mouse
    }


    // ──────────────────────────────────────────────────────────────
    // LAYOUT
    // ──────────────────────────────────────────────────────────────
    //
    // Hyprland:
    //
    //   gaps_in  = 4
    //   gaps_out = 8
    //   dwindle
    //
    // Niri uses scrollable columns, so one gap value is used.
    // 6 provides a close visual compromise for Hyprmoni.

    layout {

      gaps 6

      center-focused-column "on-overflow"

      // Disable Niri's focus ring.
      // We use the always-visible border below instead.
      focus-ring {
        off
      }

      // Persistent Hyprmoni border.
      border {
        on
        width 2

        active-color "#FD5BA2"
        inactive-color "#67253Fbb"
        urgent-color "#FD5BA2"
      }

      // Wine-colored Hyprmoni shadow.
      shadow {
        on

        softness 18
        spread 4

        offset x=0 y=5

        draw-behind-window true

        color "#401929cc"
        inactive-color "#00000099"
      }

      // Default width for newly created columns.
      default-column-width {
        proportion 0.5
      }

      // Hyprmoni-friendly width presets.
      preset-column-widths {
        proportion 0.33333
        proportion 0.5
        proportion 0.66667
      }

      // Deep Hyprmoni background.
      background-color "#0D0D0D"
    }


    // ──────────────────────────────────────────────────────────────
    // STARTUP
    // ──────────────────────────────────────────────────────────────

    // Restore the current Hyprmoni wallpaper.
    spawn-at-startup "swww-daemon"

    spawn-at-startup "hyprmoni-wallpapers" "--restore"

    // NetworkManager tray.
    spawn-at-startup "nm-applet"

    // Same Waybar configuration used by Hyprland.
    spawn-at-startup "waybar"


    // ──────────────────────────────────────────────────────────────
    // SCREENSHOTS
    // ──────────────────────────────────────────────────────────────

    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"


    // ──────────────────────────────────────────────────────────────
    // ANIMATIONS
    // ──────────────────────────────────────────────────────────────
    //
    // These are Niri-native equivalents of the fast/smooth
    // Hyprmoni animation character.
    //
    // Hyprland curves:
    //
    //   monikaEase = 0.22, 1.00, 0.36, 1.00
    //   monikaPop  = 0.16, 1.12, 0.30, 1.00
    //   quickFade  = 0.40, 0.00, 0.20, 1.00
    //
    // Niri uses springs/easing rather than Hyprland's bezier syntax.

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
    //
    // Hyprland:
    //
    //   active_opacity   = 0.94
    //   inactive_opacity = 0.72
    //
    // Niri supports per-window opacity rules directly.

    window-rule {
      match is-focused=false

      opacity 0.72
    }

    window-rule {
      match is-focused=true

      opacity 0.94
    }

    // Keep windows square.
    window-rule {
      geometry-corner-radius 0
      clip-to-geometry true
    }


    // ──────────────────────────────────────────────────────────────
    // LAYER-SHELL COMPONENTS
    // ──────────────────────────────────────────────────────────────
    //
    // Waybar and Rofi remain external applications.
    // Their own Hyprmoni CSS remains untouched.

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
    //
    // Niri workspaces are dynamic by design.
    //
    // These named workspaces make the familiar Hyprland
    // Super+1..0 workflow much more persistent.
    //
    // They remain movable between monitors, unlike Hyprland's
    // hard-bound workspace IDs.

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

      // Closest Niri equivalent to pulling a window into/out
      // of the column on the left.

      Super+P hotkey-overlay-title="Consume / Expel Window Left" {
        consume-or-expel-window-left;
      }

      // Niri-native tabbed column mode.
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

      // Vim-style navigation.

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
      // MEDIA / VOLUME
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
      // MEDIA PLAYER
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
      //
      // Niri's native screenshot system replaces Hyprshot here.
      //
      // Super+Print:
      //   focused window
      //
      // Super+Shift+Print:
      //   interactive screenshot UI
      //
      // Print:
      //   focused screen

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

      // Open Waypaper.
      Super+W {
        spawn "waypaper";
      }

      // Existing Hyprmoni wallpaper selector/state system.
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
      // KEYBOARD SHORTCUT INHIBITION
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
  # NIRI-SPECIFIC PACKAGES
  # ───────────────────────────────────────────────────────────────

  home.packages = with pkgs; [
    xwayland-satellite
    swww
  ];
}
