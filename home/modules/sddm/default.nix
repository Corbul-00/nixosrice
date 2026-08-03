{ config, pkgs, lib, ... }:

let
  # 1. Fetch the exact upstream SDDM theme source declaratively
  ltmnight-sddm-theme = pkgs.stdenv.mkDerivation {
    pname = "ltmnight-sddm-theme";
    version = "1.2.0";

    src = pkgs.fetchFromGitHub {
      owner = "hyprltm";
      repo = "ltmnight-sddm-theme";
      # Pin to a specific git commit / tag for 100% reproducibility
      rev = "main";
      sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; 
      # TIP: On your first `nixos-rebuild switch`, replace the above hash 
      # with the actual hash Nix outputs in the error message.
    };

    # Override theme config during build time to point to your user wallpaper
    # and enable partial background blur
    postInstall = ''
      mkdir -p $out/share/sddm/themes/ltmnight
      cp -r ./* $out/share/sddm/themes/ltmnight/

      # Create user config override
      cat <<EOF > $out/share/sddm/themes/ltmnight/Themes/hyprltm.conf.user
      [General]
      Background="/home/YOUR_USERNAME/sddm-wallpaper/background.jpg"
      PartialBlur="true"
      FormPosition="center"
      HideVirtualKeyboard="true"
      EOF
    '';
  };
in
{
  # 2. Enable SDDM Display Manager (using Qt6 / KDE Packages)
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; # Set to false if using X11
    package = pkgs.kdePackages.sddm;
    
    # Selected theme name matching folder name in derivation
    theme = "ltmnight";

    # Extra dependencies required by Qt Quick / LTMNight theme
    extraPackages = with pkgs.kdePackages; [
      qtdeclarative
      qtsvg
      qtmultimedia
      qtvirtualkeyboard
      qt5compat
    ];
  };

  # 3. Add derivation to system environment packages so SDDM can resolve /usr/share/sddm/themes/
  environment.systemPackages = [
    ltmnight-sddm-theme
  ];
}
