{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "ltmnight-sddm-theme";
  version = "1.2.0";

  src = pkgs.fetchFromGitHub {
    owner = "hyprltm";
    repo = "ltmnight-sddm-theme";
    rev = "main";
    sha256 = "sha256-to8+o0DgtrwR+pXUQy7+Fk+T3Zh8kKYqI552NAjVz/k="; 
  };

  postInstall = ''
    mkdir -p $out/share/sddm/themes/ltmnight
    cp -r ./* $out/share/sddm/themes/ltmnight/

    cat <<EOF > $out/share/sddm/themes/ltmnight/Themes/hyprltm.conf.user
    [General]
    Background="/etc/nixos/modules/sddm/background.jpg"
    PartialBlur="true"
    FormPosition="center"
    HideVirtualKeyboard="true"
    EOF
  '';
}
