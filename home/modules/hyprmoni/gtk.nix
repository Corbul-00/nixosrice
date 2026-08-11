{ pkgs, hyprlain, ... }:

let
  ddlcFonts = pkgs.google-fonts.override {
    fonts = [ "Mali" ];
  };

  hyprmoniGtkTheme = pkgs.stdenvNoCC.mkDerivation {
    pname = "hyprmoni-gtk-theme";
    version = "1.0.0";
    dontUnpack = true;

    installPhase = ''
      runHook preInstall
      mkdir -p "$out/share/themes/Hyprmoni"
      cp -R ${hyprlain}/src/gtkqtxdg/src/hyprlain/. "$out/share/themes/Hyprmoni/"
      chmod -R u+w "$out/share/themes/Hyprmoni"

      find "$out/share/themes/Hyprmoni" -type f \
        \( -name '*.css' -o -name 'index.theme' \) -exec sed -i \
        -e 's/hyprlain/Hyprmoni/gI' \
        -e 's/#ce7688/#CE4A7E/gI' \
        -e 's/#050505/#1B1B1B/gI' \
        -e 's/#000000/#0D0D0D/gI' \
        -e 's/#c0bfbc/#FFD9E8/gI' \
        -e 's/#f6f5f4/#FFD9E8/gI' \
        -e 's/#ffffff/#FFD9E8/gI' \
        -e 's/#3584e4/#CE4A7E/gI' \
        -e 's/#1c71d8/#A12D65/gI' \
        -e 's/#1a5fb4/#67253F/gI' \
        -e 's/#62a0ea/#FD5BA2/gI' \
        -e 's/#99c1f1/#FFD9E8/gI' {} +

      runHook postInstall
    '';
  };

  hyprmoniIcons = pkgs.stdenvNoCC.mkDerivation {
    pname = "hyprmoni-icons";
    version = "1.0.0";
    dontUnpack = true;
    nativeBuildInputs = [
      pkgs.gtk3
      pkgs.librsvg
    ];

    installPhase = ''
      runHook preInstall
      mkdir -p "$out/share/icons/Hyprmoni-icons"
      cp -R ${hyprlain}/src/gtkqtxdg/src/hyprlaicons/. "$out/share/icons/Hyprmoni-icons/"
      chmod -R u+w "$out/share/icons/Hyprmoni-icons"

      sed -i \
        -e 's/Hyprlaicons/Hyprmoni-icons/g' \
        -e 's/hyprlaicons/Hyprmoni-icons/g' \
        "$out/share/icons/Hyprmoni-icons/index.theme"

      scalable="$out/share/icons/Hyprmoni-icons/scalable/mimetypes"
      small="$out/share/icons/Hyprmoni-icons/16x16/mimetypes"

      find "$out/share/icons/Hyprmoni-icons" -type f -name '*.svg' -exec sed -i \
        -e 's/#1a5fb4/#67253F/gI' \
        -e 's/#204a87/#401929/gI' \
        -e 's/#1c71d8/#A12D65/gI' \
        -e 's/#3584e4/#CE4A7E/gI' \
        -e 's/#4a86cf/#CE4A7E/gI' \
        -e 's/#62a0ea/#FD5BA2/gI' \
        -e 's/#98c1f1/#FFD9E8/gI' \
        -e 's/#99c1f1/#FFD9E8/gI' \
        -e 's/#b3d3f9/#FFAA99/gI' {} +

      for name in \
        application-json application-ld+json application-toml application-xml \
        application-x-yaml application-yaml text-css text-javascript text-markdown \
        text-plain text-x-csrc text-x-c++src text-x-go text-x-java text-x-lua \
        text-x-markdown text-x-nix text-x-python text-x-rust text-x-toml \
        text-x-typescript text-x-yaml text-xml; do
        ln -sf text-x-generic.svg "$scalable/$name.svg"
      done

      for name in \
        application-javascript application-x-executable-script \
        application-x-shellscript text-x-script.python; do
        ln -sf text-x-script.svg "$scalable/$name.svg"
      done

      ln -sf text-html.svg "$scalable/application-xhtml+xml.svg"

      mkdir -p "$small"
      for svg in "$scalable"/*.svg; do
        name="$(basename "$svg" .svg)"
        rsvg-convert -w 16 -h 16 "$svg" -o "$small/$name.png"
      done

      gtk-update-icon-cache -f "$out/share/icons/Hyprmoni-icons"
      runHook postInstall
    '';
  };
in
{
  gtk = {
    enable = true;

    font = {
      name = "Mali";
      size = 12;
      package = ddlcFonts;
    };

    theme = {
      name = "Hyprmoni";
      package = hyprmoniGtkTheme;
    };

    iconTheme = {
      name = "Hyprmoni-icons";
      package = hyprmoniIcons;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  home.packages = [
    pkgs.gtk3
    pkgs.gtk4
    hyprmoniGtkTheme
    hyprmoniIcons
  ];
}
