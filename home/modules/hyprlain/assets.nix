{ pkgs, hyprlain, ... }:

let
  # Wlogout 1.2.x does not accept a JSON array here. Its parser expects a
  # sequence of standalone JSON objects, matching the upstream layout format.
  wlogoutButtons = [
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
in
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

  xdg.configFile."wlogout/layout".text =
    pkgs.lib.concatMapStringsSep "\n" builtins.toJSON wlogoutButtons;

  home.packages = with pkgs; [
    swww
    wlogout
    nerd-fonts.adwaita-mono
  ];
}
