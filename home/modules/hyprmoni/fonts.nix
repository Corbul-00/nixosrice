{ pkgs, ... }:

let
  ddlcFonts = pkgs.google-fonts.override {
    fonts = [
      "Mali"
      "Nunito"
    ];
  };
in
{
  fonts.fontconfig.enable = true;

  home.packages = [
    ddlcFonts
    pkgs.nerd-fonts.adwaita-mono
    pkgs.nerd-fonts.symbols-only
    pkgs.font-awesome_6
  ];
}
