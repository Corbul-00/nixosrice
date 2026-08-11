{ pkgs, ... }:

let
  frierenCursor = pkgs.callPackage ./default.nix { };
in
{
  # Shared by the default, pink and Hyprlain profiles only.
  home.pointerCursor = {
    enable = true;
    name = "Frieren";
    package = frierenCursor;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
