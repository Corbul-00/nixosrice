{ config, lib, pkgs, ... }:
{
  home.file.".config/Bionus/Grabber/themes/Waifuroom/style.css".source =
    ./grabber.css;

  # settings.ini is read *and* rewritten by Grabber itself, so it can't be
  # a home.file symlink like style.css — this patches just the one line
  # into the real, mutable file instead, each time you switch generations.
  home.activation.grabberTheme = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    settingsFile="$HOME/.config/Bionus/Grabber/settings.ini"
    if [ -f "$settingsFile" ]; then
      run ${pkgs.gnused}/bin/sed -i \
        -e 's/^theme=.*/theme=Waifuroom/' \
        "$settingsFile"
    fi
  '';
}
