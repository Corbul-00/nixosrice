{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "ltmnight-sddm-theme";
  version = "1.2.0";

  src = pkgs.fetchFromGitHub {
    owner = "hyprltm";
    repo = "ltmnight-sddm-theme";
    rev = "main";
    sha256 = "sha256-to8+o0DgtrwR+pXUQy7+Fk+T3Zh8kKYqI552NAjVz/k="; # Will give hash mismatch on first build
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
}
