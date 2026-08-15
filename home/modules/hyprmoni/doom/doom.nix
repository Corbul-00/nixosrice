# home/modules/hyprmoni/doom/doom.nix
{ pkgs, nix-doom-emacs-unstraightened, ... }:
let
  # Doom inserts the dashboard banner at native pixel size (no scaling),
  # so we pre-resize a copy instead of pointing it at the raw wallpaper.
  #
  # >>> Change this number to resize the banner. <
  doomBannerWidth = 420;

  doomBanner = pkgs.runCommand "doom-banner.png"
    { nativeBuildInputs = [ pkgs.imagemagick ]; }
    ''
      convert ${../assets/doombg.png} -resize ${toString doomBannerWidth}x doom-banner.png
      cp doom-banner.png $out
    '';
in
{
  imports = [
    nix-doom-emacs-unstraightened.homeModule
  ];

  programs.doom-emacs = {
    enable = true;
    provideEmacs = true;
    doomDir = ./doom.d;
    emacs = pkgs.emacs-pgtk;
    experimentalFetchTree = true;

    extraPackages = epkgs: [
      epkgs.treesit-grammars.with-all-grammars
    ];
  };

  # Deployed at a fixed runtime path config.el points fancy-splash-image at.
  # The original full-res doombg.png in assets/ is untouched.
  xdg.configFile."hyprmoni/assets/doom-banner.png".source = doomBanner;

  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
  ];
}
