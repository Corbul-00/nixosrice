{ pkgs, nix-doom-emacs-unstraightened, ... }:

{
  imports = [
    nix-doom-emacs-unstraightened.homeModule
  ];

  programs.doom-emacs = {
    enable = true;

    emacs = pkgs.emacs-pgtk;

    doomDir = ./doom;

    extraPackages = epkgs: with epkgs; [
      elcord
    ];

    extraBinPackages = with pkgs; [
      git
      ripgrep
      fd
      nodejs
      python3
    ];
  };
}
