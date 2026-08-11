{ lib, pkgs, ... }:

let
  monikaCursor = pkgs.stdenvNoCC.mkDerivation {
    pname = "just-monika-cursors";
    version = "2025-01-25";

    # Download Just-Monika.tar.gz from:
    # https://www.gnome-look.org/p/2251945
    src = ./assets/Just-Monika.tar.gz;

    dontUnpack = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      install -d "$out/share/icons/Just-Monika"
      tar \
        --extract \
        --gzip \
        --file "$src" \
        --directory "$out/share/icons/Just-Monika" \
        --strip-components 1 \
        --no-same-owner

      runHook postInstall
    '';

    meta = {
      description = "Animated Just Monika cursor theme for Linux";
      homepage = "https://www.gnome-look.org/p/2251945";
      license = lib.licenses.unfreeRedistributable;
      platforms = lib.platforms.linux;
    };
  };
in
{
  # Hyprmoni owns this cursor definition; other profiles keep Frieren.
  home.pointerCursor = {
    enable = true;
    name = "Just-Monika";
    package = monikaCursor;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
