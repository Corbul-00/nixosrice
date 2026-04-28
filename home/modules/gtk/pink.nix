{ config, pkgs, ... }:
{
  # GTK Pink (Kawaii Moe) Theme - Matching Waybar
  home.packages = with pkgs; [
    gtk3
    gtk4
    papirus-icon-theme
  ];

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };

    # Use the pink CSS instead of the default one
    gtk3.extraCss = builtins.readFile ./gtk-pink.css;
    gtk4.extraCss = builtins.readFile ./gtk-pink.css;
  };
}
