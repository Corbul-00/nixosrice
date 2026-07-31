{ config, pkgs, ... }:
{
  home.file.".config/Bionus/Grabber/themes/Waifuroom/style.css".source =
    ./grabber.css;
}
