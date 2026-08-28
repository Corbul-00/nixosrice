{ pkgs, ... }:

let
  palette = import ./palette.nix;
in
{
  programs.mpv = {
    enable = true;

    # Wrap mpv so MANGOHUD is forced off for it specifically, overriding
    # the session-wide MANGOHUD=1 set by programs.mangohud.enableSessionWide.
    # (Version-safe equivalent of extraMakeWrapperArgs, which this
    # home-manager revision doesn't have yet.)
    package = pkgs.symlinkJoin {
      name = "mpv-no-mangohud";
      paths = [ pkgs.mpv ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/mpv --set MANGOHUD 0
      '';
    };

    config = {
      # OSD / subtitle styling, matched to the hyprmoni palette.
      osd-color = palette.blush;
      osd-border-color = palette.wineDark;
      osd-font-size = 32;

      sub-color = palette.blush;
      sub-border-color = palette.wineDark;

      # Letterbox background instead of mpv's default black.
      background-color = palette.void;

      # Borderless client window — matches the rounding=0, clean-edge
      # look the rest of the rice uses.
      border = false;
    };

    bindings = {
      h = "playlist-prev";
      l = "playlist-next";
    };
  };
}
