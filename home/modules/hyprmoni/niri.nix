{ pkgs, ... }:

{
  # Niri is deliberately configured separately from Hyprland.
  #
  # Do NOT import hyprland.nix from here.
  # Do NOT modify hyprland.nix.
  #
  # The system-wide programs.niri.enable belongs in configuration.nix.
  # This module only owns the Hyprmoni-specific Niri session config.

  xdg.configFile."niri/config.kdl".text = ''
    // ╔══════════════════════════════════════════════════════════════╗
    // ║                     HYPRMONI × NIRI                         ║
    // ║        Monika-themed Niri configuration for NixOS           ║
    // ╚══════════════════════════════════════════════════════════════╝
    //
    // Hyprland remains completely independent in hyprland.nix.
    //
    // This file intentionally follows the same philosophy and keybind
    // layout as the Hyprland configuration, while adapting the actual
    // window-management semantics to Niri's scrollable tiling model.

    // ──────────────────────────────────────────────────────────────
    // ENVIRONMENT
    // ──────────────────────────────────────────────────────────────

    environment {
      XCURSOR_SIZE "24"
      HYPRCURSOR_SIZE "24"
      XFT_DPI "150"

      // Prefer native Wayland applications.
      QT_QPA_PLATFORM "wayland"
    }

    // Niri can manage X11 applications through xwayland-satellite.
    xwayland-satellite {
      path "xwayland-satellite"
    }

    // Keep the cursor size consistent with Hyprmoni.
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
        // Same behavior as Hyprland:
        // natural scrolling disabled.
        //
        // In Niri, natural-scroll is enabled by presence, so we
        // deliberately omit it.
      }

      mouse {
        // Hyprland had sensitivity 0 globally.
        accel-speed 0
      }

      // Equivalent spirit to Hyprland's follow_mouse = 1.
      focus-follows-mouse
    }

    // The original Hyprland configuration has a device-specific
    // sensitivity adjustment for "epic-mouse-v1".
    //
    // Niri currently cannot configure individual mouse devices
    // separately, so this cannot be translated 1:1.
    //
    // The global accel-speed above intentionally stays neutral.

    // ──────────────────────────────────────────────────────────────
    // LAYOUT
    // ──────────────────────────────────────────────────────────────
    //
    // Hyprland:
    //   gaps_in  = 4
    //   gaps_out = 8
    //   dwindle
    //
    // Niri has one gap value around the scrollable columns.
    // 6 is the closest visual compromise between your 4/8 setup.

    layout {
      gaps 6

      // Keep Niri's natural scrollable-column behavior rather than
      // forcing every focused column into the center.
      center-focused-column "on-overflow"

      // Your Hyprmoni windows are square rather than rounded.
      //
      // Focus ring replaces Hyprland's active border.
      focus-ring {
        off 
      }

      // Keep a persistent inactive border just like Hyprland's
      // inactive border.
      border {
        width 2
        active-color "#FD5BA2"
        inactive-color "#67253Fbb"
        urgent-color "#FD5BA2"
      }

      // Niri normally expects either focus-ring OR border.
      // We explicitly disable the focus ring so the persistent
      // border becomes the visual equivalent of Hyprland's border.
      focus-ring {
        off
      }

      // Hyprmoni's wine-colored shadow.
      shadow {
        on
        softness 18
        spread 4
        offset x=0 y=5
        draw-behind-window true
        color "#401929cc"
        inactive-color "#00000099"
      }

      // New columns should generally occupy a useful amount of
      // screen real estate without becoming absurdly wide.
      default-column-width {
        proportion 0.5
      }

      preset-column-widths {
        proportion 0.33333
        proportion 0.5
        proportion 0.66667
      }

      background-color "#0D0D0D"
    }

    // ──────────────────────────────────────────────────────────────
    // STARTUP
    // ──────────────────────────────────────────────────────────────

    // Your existing Hyprmoni wallpaper module already provides the
    // hyprmoni-wallpapers command and its state handling.
    spawn-at-startup "swww-daemon"
    spawn-at-startup "hyprmoni-wallpapers" "--restore"

    // NetworkManager tray applet, same as Hyprland.
    spawn-at-startup "nm-applet"

    // Waybar is shared with Hyprland, so we simply start the exact
    // same Waybar configuration.
    spawn-at-startup "waybar"

    // ──────────────────────────────────────────────────────────────
    // SCREENSHOTS
    // ──────────────────────────────────────────────────────────────
    //
    // Niri has native screenshot actions, so Hyprshot is not needed
    // for this session.
    //
    // Screenshot directory follows Niri's strftime syntax.

    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    // ──────────────────────────────────────────────────────────────
    // ANIMATIONS
    // ──────────────────────────────────────────────────────────────
    //
    // Hyprland's original Hyprmoni animation curves:
    //
    // monikaEase = 0.22, 1.00, 0.36, 1.00
    // monikaPop  = 0.16, 1.12, 0.30, 1.00
    // quickFade  = 0.40, 0.00, 0.20, 1.00
    //
    // Niri uses easing curves and springs rather than Hyprland's
    // animation declarations. These values preserve the same
    // fast/smooth Monika-style character.

    animations {
      workspace-switch {
        spring damping-ratio=1.0 stiffness=900 epsilon=0.0001
      }

      window-open {
        duration-ms 170
        curve "ease-out-expo"
      }

      window-close {
        duration-ms 130
        curve "ease-out-quad"
      }

      horizontal-view-movement {
        spring damping-ratio=1.0 stiffness=850 epsilon=0.0001
      }

      window-movement {
        spring damping-ratio=1.0 stiffness=850 epsilon=0.0001
      }

      window-resize {
        spring damping-ratio=1.0 stiffness=850 epsilon=0.0001
      }

      config-notification-open-close {
        spring damping-ratio=0.6 stiffness=1000 epsilon=0.001
      }

      overview-open-close {
        spring damping-ratio=0.85 stiffness=750 epsilon=0.0001
      }

      screenshot-ui-open {
        duration-ms 180
        curve "ease-out-quad"
      }

      recent-windows-close {
        spring damping-ratio=0.8 stiffness=850 epsilon=0.001
      }
    }

    // ──────────────────────────────────────────────────────────────
    // GLOBAL BLUR
    // ──────────────────────────────────────────────────────────────
    //
    // This is the Niri equivalent of the Hyprland blur block:
    //
    //   size       = 5
    //   passes     = 3
    //   noise      = 0.025
    //   contrast   = 1.08
    //   brightness = 0.82
    //   vibrancy   = 0.16
    //
    // Niri exposes different controls, so saturation/noise are used
    // to reproduce the visual character rather than pretending the
    // parameters are numerically identical.

    blur {
      passes 3
      offset 3.0
      noise 0.025
      saturation 1.16
    }

    // ──────────────────────────────────────────────────────────────
    // WINDOW APPEARANCE
    // ──────────────────────────────────────────────────────────────
    //
    // Hyprland:
    //   active_opacity   = 0.94
    //   inactive_opacity = 0.72
    //   fullscreen       = 1.0
    //   dim_inactive     = true
    //   dim_strength     = 0.18
    //
    // Niri's is-focused matcher is used here because it corresponds
    // more closely to Hyprland's focused-window opacity.

    window-rule {
      match is-focused=false
      opacity 0.72

      background-effect {
        xray true
        blur true
        noise 0.025
        saturation 1.16
      }
    }

    window-rule {
      match is-focused=true
      opacity 0.94

      background-effect {
        xray true
        blur true
        noise 0.025
        saturation 1.16
      }
    }

    // Fullscreen applications should remain fully opaque, matching
    // Hyprland's fullscreen_opacity = 1.0.
    window-rule {
      match is-fullscreen=true
      opacity 1.0
    }

    // Keep the square Hyprmoni visual language.
    window-rule {
      geometry-corner-radius 0
      clip-to-geometry true
    }

    // ──────────────────────────────────────────────────────────────
    // LAYER-SHELL COMPONENTS
    // ──────────────────────────────────────────────────────────────
    //
    // Waybar/Rofi/Wlogout are external applications, but Niri can
    // apply compositor-side rules to their layer surfaces.
    //
    // These rules intentionally remain conservative so we do not
    // interfere with their own Hyprmoni CSS.

    layer-rule {
      match namespace="^waybar$"

      // Keep Waybar crisp while preserving its own transparency.
      opacity 1.0
    }

    layer-rule {
      match namespace="^rofi$"

      opacity 0.96

      background-effect {
        xray true
        blur true
        noise 0.025
        saturation 1.10
      }
    }

    // ──────────────────────────────────────────────────────────────
    // WORKSPACES
    // ──────────────────────────────────────────────────────────────
    //
    // Niri workspaces are dynamic, but numbered workspace actions
    // behave naturally and match your current Super+1..0 workflow.

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

    // Hyprland's "special:magic" becomes a named Niri workspace.
    workspace "magic"

    // ──────────────────────────────────────────────────────────────
    // KEYBINDS
    // ──────────────────────────────────────────────────────────────

    binds {

      // ── Applications ──────────────────────────────────────────

      Super+Q hotkey-overlay-title="Terminal: Kitty" {
        spawn "kitty";
      }

      Super+C hotkey-overlay-title="Close Window" {
        close-window;
      }

      Super+M hotkey-overlay-title="Exit Niri" {
        quit;
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


      // ── Floating ──────────────────────────────────────────────
      //
      // Hyprland Super+F = togglefloating.
      // Niri's direct equivalent is toggle-window-floating.

      Super+F hotkey-overlay-title="Toggle Floating" {
        toggle-window-floating;
      }


      // ── Hyprland pseudo/togglesplit replacements ──────────────
      //
      // Niri has no direct dwindle/pseudotile/togglesplit equivalent.
      //
      // Super+P becomes "consume/expel left", which lets you pull
      // windows into/out of a column.
      //
      // Super+D becomes a useful column-display toggle.
      //
      // These are deliberately chosen as the closest useful Niri
      // operations rather than fake translations of Hyprland-only
      // concepts.

      Super+P hotkey-overlay-title="Consume / Expel Window Left" {
        consume-or-expel-window-left;
      }

      Super+D hotkey-overlay-title="Toggle Tabbed Column" {
        toggle-column-tabbed-display;
      }


      // ── Focus ─────────────────────────────────────────────────

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


      // ── Workspaces ────────────────────────────────────────────

      Super+1 {
        focus-workspace 1;
      }

      Super+2 {
        focus-workspace 2;
      }

      Super+3 {
        focus-workspace 3;
      }

      Super+4 {
        focus-workspace 4;
      }

      Super+5 {
        focus-workspace 5;
      }

      Super+6 {
        focus-workspace 6;
      }

      Super+7 {
        focus-workspace 7;
      }

      Super+8 {
        focus-workspace 8;
      }

      Super+9 {
        focus-workspace 9;
      }

      Super+0 {
        focus-workspace 10;
      }


      // ── Move window/column to workspace ───────────────────────

      Super+Shift+1 {
        move-column-to-workspace 1;
      }

      Super+Shift+2 {
        move-column-to-workspace 2;
      }

      Super+Shift+3 {
        move-column-to-workspace 3;
      }

      Super+Shift+4 {
        move-column-to-workspace 4;
      }

      Super+Shift+5 {
        move-column-to-workspace 5;
      }

      Super+Shift+6 {
        move-column-to-workspace 6;
      }

      Super+Shift+7 {
        move-column-to-workspace 7;
      }

      Super+Shift+8 {
        move-column-to-workspace 8;
      }

      Super+Shift+9 {
        move-column-to-workspace 9;
      }

      Super+Shift+0 {
        move-column-to-workspace 10;
      }


      // ── Magic workspace ──────────────────────────────────────
      //
      // Niri doesn't have Hyprland's special-workspace primitive.
      // "magic" is therefore a normal named workspace.
      //
      // Super+S focuses it.
      // Super+Shift+S sends the current column there.

      Super+S hotkey-overlay-title="Focus Magic Workspace" {
        focus-workspace "magic";
      }

      Super+Shift+S hotkey-overlay-title="Move Column to Magic Workspace" {
        move-column-to-workspace "magic";
      }


      // ── Workspace scrolling ──────────────────────────────────

      Super+WheelScrollDown cooldown-ms=150 {
        focus-workspace-down;
      }

      Super+WheelScrollUp cooldown-ms=150 {
        focus-workspace-up;
      }


      // ── Media / volume ───────────────────────────────────────

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

      XF86MonBrightnessUp allow-when-locked=true {
        spawn "brightnessctl" "-e4" "-n2" "set" "5%+";
      }

      XF86MonBrightnessDown allow-when-locked=true {
        spawn "brightnessctl" "-e4" "-n2" "set" "5%-";
      }

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


      // ── Screenshots ───────────────────────────────────────────
      //
      // Replaces the Hyprshot bindings with Niri's native screenshot
      // implementation.
      //
      // Super+Print       = focused window
      // Super+Shift+Print = interactive selector
      // Print             = focused screen
      // Super+Ctrl+Print  = focused screen
      //
      // Niri's screenshot actions save to screenshot-path and copy
      // the result to the clipboard where supported.

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


      // ── Wallpaper ─────────────────────────────────────────────

      Super+W {
        spawn "waypaper";
      }

      Super+Shift+W {
        spawn "hyprmoni-wallpapers";
      }


      // ── Mouse wheel workspace navigation ──────────────────────

      Super+WheelScrollRight cooldown-ms=100 {
        focus-column-right;
      }

      Super+WheelScrollLeft cooldown-ms=100 {
        focus-column-left;
      }


      // ── Mouse window manipulation ─────────────────────────────
      //
      // Niri already has native mouse/window behavior. We do not
      // recreate Hyprland's bindm here because Niri owns those
      // gestures itself.


      // ── Safety / Niri controls ────────────────────────────────

      Super+Shift+E hotkey-overlay-title="Exit Niri" {
        quit;
      }

      Super+Escape allow-inhibiting=false {
        toggle-keyboard-shortcuts-inhibit;
      }

      Super+O repeat=false hotkey-overlay-title="Niri Overview" {
        toggle-overview;
      }

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

    // Do not show the default Niri hotkey overlay every login.
    hotkey-overlay {
      skip-at-startup
    }

    // Keep Niri's CSD behavior friendly to the square Hyprmoni look.
    prefer-no-csd
  '';

  # Niri-specific utilities.
  #
  # The rest of Hyprmoni already supplies most of these, but keeping
  # xwayland-satellite and swww explicit here makes this compositor
  # module self-contained.
  home.packages = with pkgs; [
    xwayland-satellite
    swww
  ];
}
