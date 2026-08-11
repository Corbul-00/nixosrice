{ pkgs, ... }:

let
  assets = toString ./assets;

  buttons = [
    {
      label = "lock";
      action = "hyprlock";
      text = "Lock";
      keybind = "l";
    }
    {
      label = "logout";
      action = "hyprctl dispatch exit";
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
      background-image: url("${assets}/wlogout/lock.svg");
    }

    #logout {
      background-image: url("${assets}/wlogout/logout.svg");
    }

    #suspend {
      background-image: url("${assets}/wlogout/suspend.svg");
    }

    #hibernate {
      background-image: url("${assets}/wlogout/hibernate.svg");
    }

    #reboot {
      background-image: url("${assets}/wlogout/reboot.svg");
    }

    #shutdown {
      background-image: url("${assets}/wlogout/shutdown.svg");
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
