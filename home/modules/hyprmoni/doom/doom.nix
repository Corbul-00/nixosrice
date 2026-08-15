{ pkgs, nix-doom-emacs-unstraightened, ... }:
{
  imports = [
    nix-doom-emacs-unstraightened.homeModule
  ];

  programs.doom-emacs = {
    enable = true;
    provideEmacs = true;           # installs "emacs" binary (not just "doom-emacs")
    doomDir = ./doom.d;
    emacs = pkgs.emacs-pgtk;       # correct option name — confirmed against source
    experimentalFetchTree = true;  # avoids "Cannot find Git revision" on modern Nix

    extraPackages = epkgs: [
      epkgs.treesit-grammars.with-all-grammars
    ];
  };

  # Unstraightened only wires the editor — it doesn't fetch LSP servers.
  # :tools lsp expects these on $PATH.
  home.packages = with pkgs; [
    nixd               # Nix LSP, for editing this very repo
    nixfmt-rfc-style
  ];
}
