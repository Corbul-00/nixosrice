{ pkgs, ... }:

{
  ltmnight-sddm-theme = pkgs.stdenv.mkDerivation {
    pname = "ltmnight-sddm-theme";
    version = "1.2.0";

    src = pkgs.fetchFromGitHub {
      owner = "hyprltm";
      repo = "ltmnight-sddm-theme";
      rev = "main";
      sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Update after first build attempt
    };

    postInstall = ''
      mkdir -p $out/share/sddm/themes/ltmnight
      cp -r ./* $out/share/sddm/themes/ltmnight/

      # Set user wallpaper and config options directly in the theme package
      cat <<EOF > $out/share/sddm/themes/ltmnight/Themes/hyprltm.conf.user
      [General]
      Background="/home/corbul/sddm-wallpaper/background.jpg"
      PartialBlur="true"
      FormPosition="center"
      HideVirtualKeyboard="true"
      EOF
    '';
  };
}
