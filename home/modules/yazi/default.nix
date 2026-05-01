{ config, pkgs, lib, ... }:
{
  programs.yazi = {
    enable = true;
    # No theme set — uses yazi's built-in defaults
    # (blue folders, default colors, stock appearance)
  };
}
