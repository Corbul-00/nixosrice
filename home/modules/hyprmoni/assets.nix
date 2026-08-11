{ pkgs, ... }:

{
  # Personal artwork stays local to this profile. Replacing files below only
  # requires a rebuild; no mutable installer writes into ~/.config.
  xdg.configFile."hyprmoni/assets" = {
    source = ./assets;
    recursive = true;
  };

  home.packages = with pkgs; [
    swww
    waypaper
    wlogout
  ];
}
