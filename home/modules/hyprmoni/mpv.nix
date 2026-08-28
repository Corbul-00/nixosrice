{ ... }:

let
  palette = import ./palette.nix;
in
{
  programs.mpv = {
    enable = true;

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

    # Forces MANGOHUD=0 for mpv specifically, overriding the session-wide
    # MANGOHUD=1 set by programs.mangohud.enableSessionWide — mpv is fully
    # skipped instead of just having its overlay hidden.
    extraMakeWrapperArgs = [
      "--set"
      "MANGOHUD"
      "0"
    ];
  };
}
