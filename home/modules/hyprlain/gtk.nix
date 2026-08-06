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
    pname = "hyprlaicons-hyprlain-palette";
    version = "ffb81b7";
    dontUnpack = true;
    nativeBuildInputs = [ pkgs.gtk3 pkgs.librsvg ];
    installPhase = ''
      runHook preInstall
      mkdir -p "$out/share/icons/Hyprlaicons"
      cp -R ${hyprlain}/src/gtkqtxdg/src/hyprlaicons/. "$out/share/icons/Hyprlaicons/"
      chmod -R u+w "$out/share/icons/Hyprlaicons"

      scalable="$out/share/icons/Hyprlaicons/scalable/mimetypes"
      small="$out/share/icons/Hyprlaicons/16x16/mimetypes"

      # Hyprlaicons contains several Adwaita-blue MIME drawings.  Keep the
      # artwork, but translate its blue ramp to Hyprlain's dusty-pink ramp.
      find "$scalable" -type f -name '*.svg' -exec sed -i \
        -e 's/#1a5fb4/#804654/gI' \
        -e 's/#204a87/#5D333C/gI' \
        -e 's/#1c71d8/#965363/gI' \
        -e 's/#3584e4/#BA6A7B/gI' \
        -e 's/#4a86cf/#BA6A7B/gI' \
        -e 's/#62a0ea/#CE7688/gI' \
        -e 's/#98c1f1/#D3A0AA/gI' \
        -e 's/#99c1f1/#D3A0AA/gI' \
        -e 's/#b3d3f9/#C1B48E/gI' {} +

      # GIO asks for MIME-specific names such as application-json.  Upstream
      # does not ship all of them, so it otherwise falls back to blue Adwaita
      # icons.  Point common text/config/source types at the themed generic art.
      for name in \
        application-json application-ld+json application-toml application-xml \
        application-x-yaml application-yaml text-css text-javascript text-markdown \
        text-plain text-x-csrc text-x-c++src text-x-go text-x-java text-x-lua \
        text-x-markdown text-x-nix text-x-python text-x-rust text-x-toml \
        text-x-typescript text-x-yaml text-xml; do
        ln -s text-x-generic.svg "$scalable/$name.svg"
      done

      for name in \
        application-javascript application-x-executable-script \
        application-x-shellscript text-x-script.python; do
        ln -s text-x-script.svg "$scalable/$name.svg"
      done

      ln -s text-html.svg "$scalable/application-xhtml+xml.svg"

      # Re-render the 16px cache so compact/list views use the same palette.
      for svg in "$scalable"/*.svg; do
        name="$(basename "$svg" .svg)"
        rsvg-convert -w 16 -h 16 "$svg" -o "$small/$name.png"
      done

      gtk-update-icon-cache -f "$out/share/icons/Hyprlaicons"
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
