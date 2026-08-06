{ pkgs, hyprlain, ... }:

{
  # Keep Hyprlain's media in its pinned Nix store source. Home Manager creates
  # a managed symlink; no installer writes into the real ~/.config directory.
  xdg.configFile."assets" = {
    source = "${hyprlain}/src/hyprland/src/assets";
    recursive = true;
  };

  # The upstream CSS intentionally resolves ../assets from ~/.config/wlogout.
  xdg.configFile."wlogout/style.css".source =
    "${hyprlain}/src/hyprland/src/wlogout/style.css";

  xdg.configFile."wlogout/layout".text = builtins.toJSON [
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
      action = "systemctl suspend";
      text = "Suspend";
      keybind = "u";
    }
    {
      label = "hibernate";
      action = "systemctl hibernate";
      text = "Hibernate";
      keybind = "h";
    }
    {
      label = "shutdown";
      action = "systemctl poweroff";
      text = "Shutdown";
      keybind = "s";
    }
    {
      label = "reboot";
      action = "systemctl reboot";
      text = "Reboot";
      keybind = "r";
    }
  ];

  home.packages = with pkgs; [
    swww
    wlogout
    nerd-fonts.adwaita-mono
  ];
}
