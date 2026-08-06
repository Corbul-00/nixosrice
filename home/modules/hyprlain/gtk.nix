{ pkgs, hyprlain, ... }:

let
  hyprlainGtkTheme = pkgs.stdenvNoCC.mkDerivation {
    pname = "hyprlain-gtk-theme";
    version = "ffb81b7";
    dontUnpack = true;
    installPhase = ''
      runHook preInstall
      mkdir -p "$out/share/themes/hyprlain"
      cp -R ${hyprlain}/src/gtkqtxdg/src/hyprlain/. "$out/share/themes/hyprlain/"
      runHook postInstall
    '';
  };

  hyprlainIcons = pkgs.stdenvNoCC.mkDerivation {
    pname = "hyprlaicons";
    version = "ffb81b7";
    dontUnpack = true;
    installPhase = ''
      runHook preInstall
      mkdir -p "$out/share/icons/Hyprlaicons"
      cp -R ${hyprlain}/src/gtkqtxdg/src/hyprlaicons/. "$out/share/icons/Hyprlaicons/"
      runHook postInstall
    '';
  };
in
{
  gtk = {
    enable = true;
    theme = {
      name = "hyprlain";
      package = hyprlainGtkTheme;
    };
    iconTheme = {
      name = "Hyprlaicons";
      package = hyprlainIcons;
    };
  };

  home.packages = [
    pkgs.gtk3
    pkgs.gtk4
    hyprlainGtkTheme
    hyprlainIcons
  ];
}
