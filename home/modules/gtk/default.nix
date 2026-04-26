{ config, pkgs, ... }:

{
  # Comment: Enabling GTK theming through Home Manager to apply custom CSS.
  home.packages = with pkgs; [
    gtk3
    gtk4
    # Comment: Adding Papirus Icon Theme for blue folders.
    papirus-icon-theme
  ];

  # Comment: Pointing Home Manager to our custom GTK CSS file and setting Papirus as the icon theme.
  gtk = {
    enable = true;
    # Comment: Configuring Papirus as the default icon theme to get blue folders.
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };

    # Comment: Directly applying custom CSS for GTK3 applications.
    gtk3.extraCss = builtins.readFile ./gtk.css;
    # Comment: Directly applying custom CSS for GTK4 applications.
    gtk4.extraCss = builtins.readFile ./gtk.css;
  };
}
