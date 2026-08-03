# /etc/nixos/modules/sddm.nix
{ config, pkgs, lib, ... }:

let
  ltmnight-sddm-theme = pkgs.stdenv.mkDerivation {
    pname = "ltmnight-sddm-theme";
    version = "1.2.0";

    src = pkgs.fetchFromGitHub {
      owner = "hyprltm";
      repo = "ltmnight-sddm-theme";
      rev = "main";
      sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Replace with actual hash upon build
    };

    postInstall = ''
      mkdir -p $out/share/sddm/themes/ltmnight
      cp -r ./* $out/share/sddm/themes/ltmnight/

      cat <<EOF > $out/share/sddm/themes/ltmnight/Themes/hyprltm.conf.user
      [General]
      Background="/home/corbul/sddm-wallpaper/background.jpg"
      PartialBlur="true"
      FormPosition="center"
      HideVirtualKeyboard="true"
      EOF
    '';
  };
in
{
  # 1. Enable SDDM service
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; # Change to false if using X11
    package = pkgs.kdePackages.sddm;
    theme = "ltmnight";

    # Extra dependencies required by Qt Quick / LTMNight
    extraPackages = with pkgs.kdePackages; [
      qtdeclarative
      qtsvg
      qtmultimedia
      qtvirtualkeyboard
      qt5compat
    ];
  };

  # 2. Make the theme available to the SDDM daemon
  environment.systemPackages = [
    ltmnight-sddm-theme
  ];
}
