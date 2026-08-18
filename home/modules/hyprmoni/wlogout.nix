{ pkgs, ... }:

let
  # Keep the vectors self-contained in this module. This guarantees that the
  # icon derivation has explicit store inputs even if a flake source snapshot
  # omits the optional assets directory.
  iconSources = {
    lock = pkgs.writeText "hyprmoni-wlogout-lock.svg" ''
      <svg xmlns="http://www.w3.org/2000/svg" width="128" height="128" viewBox="0 0 128 128">
        <g fill="none" stroke-linecap="round" stroke-linejoin="round">
          <g stroke="#67253F" stroke-width="13"><path d="M40 57V43a24 24 0 0 1 48 0v14"/><rect x="27" y="56" width="74" height="56" rx="6"/><path d="M64 78v13"/></g>
          <g stroke="#FFD9E8" stroke-width="7"><path d="M40 57V43a24 24 0 0 1 48 0v14"/><rect x="27" y="56" width="74" height="56" rx="6"/><path d="M64 78v13"/></g>
        </g>
      </svg>
    '';
    logout = pkgs.writeText "hyprmoni-wlogout-logout.svg" ''
      <svg xmlns="http://www.w3.org/2000/svg" width="128" height="128" viewBox="0 0 128 128">
        <g fill="none" stroke-linecap="round" stroke-linejoin="round">
          <g stroke="#67253F" stroke-width="13"><path d="M70 23H31v82h39"/><path d="M54 64h53M89 46l18 18-18 18"/></g>
          <g stroke="#FFD9E8" stroke-width="7"><path d="M70 23H31v82h39"/><path d="M54 64h53M89 46l18 18-18 18"/></g>
        </g>
      </svg>
    '';
    suspend = pkgs.writeText "hyprmoni-wlogout-suspend.svg" ''
      <svg xmlns="http://www.w3.org/2000/svg" width="128" height="128" viewBox="0 0 128 128">
        <path d="M91 91A43 43 0 0 1 51 22a45 45 0 1 0 40 69Z" fill="#FFD9E8" stroke="#67253F" stroke-width="7" stroke-linecap="round" stroke-linejoin="round"/>
      </svg>
    '';
    hibernate = pkgs.writeText "hyprmoni-wlogout-hibernate.svg" ''
      <svg xmlns="http://www.w3.org/2000/svg" width="128" height="128" viewBox="0 0 128 128">
        <g fill="none" stroke-linecap="round" stroke-linejoin="round">
          <g stroke="#67253F" stroke-width="13"><path d="M64 20v88M26 42l76 44M26 86l76-44"/><path d="m64 20-10 11M64 20l10 11M64 108l-10-11M64 108l10-11"/><path d="m26 42 15 2M26 42l6 14M102 86l-15-2M102 86l-6-14"/><path d="m26 86 6-14M26 86l15-2M102 42l-6 14M102 42l-15 2"/></g>
          <g stroke="#FFD9E8" stroke-width="7"><path d="M64 20v88M26 42l76 44M26 86l76-44"/><path d="m64 20-10 11M64 20l10 11M64 108l-10-11M64 108l10-11"/><path d="m26 42 15 2M26 42l6 14M102 86l-15-2M102 86l-6-14"/><path d="m26 86 6-14M26 86l15-2M102 42l-6 14M102 42l-15 2"/></g>
        </g>
      </svg>
    '';
    reboot = pkgs.writeText "hyprmoni-wlogout-reboot.svg" ''
      <svg xmlns="http://www.w3.org/2000/svg" width="128" height="128" viewBox="0 0 128 128">
        <g fill="none" stroke-linecap="round" stroke-linejoin="round">
          <g stroke="#67253F" stroke-width="13"><path d="M99 51A41 41 0 1 0 101 82"/><path d="M99 51V27H75"/></g>
          <g stroke="#FFD9E8" stroke-width="7"><path d="M99 51A41 41 0 1 0 101 82"/><path d="M99 51V27H75"/></g>
        </g>
      </svg>
    '';
    shutdown = pkgs.writeText "hyprmoni-wlogout-shutdown.svg" ''
      <svg xmlns="http://www.w3.org/2000/svg" width="128" height="128" viewBox="0 0 128 128">
        <g fill="none" stroke-linecap="round" stroke-linejoin="round">
          <g stroke="#67253F" stroke-width="13"><path d="M64 18v47"/><path d="M42 34a43 43 0 1 0 44 0"/></g>
          <g stroke="#FFD9E8" stroke-width="7"><path d="M64 18v47"/><path d="M42 34a43 43 0 1 0 44 0"/></g>
        </g>
      </svg>
    '';
  };

  # Render deterministic PNGs because GTK/Wlogout may not discover the SVG
  # pixbuf loader when launched from Hyprland on NixOS.
  wlogoutIcons = pkgs.runCommand "hyprmoni-wlogout-icons" {
    nativeBuildInputs = [ pkgs.librsvg ];
  } ''
    mkdir -p "$out"
    rsvg-convert --width 128 --height 128 "${iconSources.lock}" --output "$out/lock.png"
    rsvg-convert --width 128 --height 128 "${iconSources.logout}" --output "$out/logout.png"
    rsvg-convert --width 128 --height 128 "${iconSources.suspend}" --output "$out/suspend.png"
    rsvg-convert --width 128 --height 128 "${iconSources.hibernate}" --output "$out/hibernate.png"
    rsvg-convert --width 128 --height 128 "${iconSources.reboot}" --output "$out/reboot.png"
    rsvg-convert --width 128 --height 128 "${iconSources.shutdown}" --output "$out/shutdown.png"
  '';

  buttons = [
    {
      label = "lock";
      action = "hyprlock";
      text = "Lock";
      keybind = "l";
    }
    {
      label = "logout";
      #action = "hyprctl dispatch exit";
      action = "loginctl terminate-session \"$XDG_SESSION_ID\""
      text = "Logout";
      keybind = "e";
    }
    {
      label = "suspend";
      action = "sh -c 'hyprlock & sleep 1; systemctl suspend'";
      text = "Suspend";
      keybind = "u";
    }
    {
      label = "hibernate";
      action = "sh -c 'hyprlock & sleep 1; systemctl hibernate'";
      text = "Hibernate";
      keybind = "h";
    }
    {
      label = "reboot";
      action = "systemctl reboot";
      text = "Reboot";
      keybind = "r";
    }
    {
      label = "shutdown";
      action = "systemctl poweroff";
      text = "Shutdown";
      keybind = "s";
    }
  ];

  hyprmoniPower = pkgs.writeShellApplication {
    name = "hyprmoni-power";
    runtimeInputs = [ pkgs.wlogout ];
    text = ''
      layout="$HOME/.config/wlogout-hyprmoni/layout"
      style="$HOME/.config/wlogout-hyprmoni/style.css"

      if ! wlogout \
        --protocol layer-shell \
        --layout "$layout" \
        --css "$style" \
        --buttons-per-row 3 \
        --margin 120 \
        --show-binds; then
        exec wlogout \
          --protocol xdg \
          --layout "$layout" \
          --css "$style" \
          --buttons-per-row 3 \
          --margin 120 \
          --show-binds
      fi
    '';
  };
in
{
  xdg.configFile."wlogout-hyprmoni/layout".text =
    pkgs.lib.concatMapStringsSep "\n" builtins.toJSON buttons;

  xdg.configFile."wlogout-hyprmoni/style.css".text = ''
    * {
      all: unset;
      font-family: "Mali", "AdwaitaMono Nerd Font";
      font-size: 20px;
      font-weight: bold;
    }

    window {
      background-color: rgba(13, 13, 13, 0.90);
    }

    button {
      color: #FFD9E8;
      background-color: rgba(27, 27, 27, 0.94);
      background-repeat: no-repeat;
      background-position: center 35%;
      background-size: 88px 88px;
      border: 2px solid #67253F;
      border-radius: 0;
      margin: 8px;
      padding-top: 110px;
    }

    #lock {
      background-image: image(url("${wlogoutIcons}/lock.png"));
    }

    #logout {
      background-image: image(url("${wlogoutIcons}/logout.png"));
    }

    #suspend {
      background-image: image(url("${wlogoutIcons}/suspend.png"));
    }

    #hibernate {
      background-image: image(url("${wlogoutIcons}/hibernate.png"));
    }

    #reboot {
      background-image: image(url("${wlogoutIcons}/reboot.png"));
    }

    #shutdown {
      background-image: image(url("${wlogoutIcons}/shutdown.png"));
    }

    button:focus,
    button:active,
    button:hover {
      color: #0D0D0D;
      background-color: #CE4A7E;
      border: 3px solid #FD5BA2;
    }

    #shutdown:focus,
    #shutdown:active,
    #shutdown:hover {
      background-color: #FD5BA2;
    }
  '';

  home.packages = [
    pkgs.wlogout
    hyprmoniPower
  ];
}
