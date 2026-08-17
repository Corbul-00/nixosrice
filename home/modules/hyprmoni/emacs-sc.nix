{ pkgs, ... }:

let
  emacsLauncher = pkgs.writeShellApplication {
    name = "hyprmoni-emacs";

    runtimeInputs = with pkgs; [
      coreutils
      libnotify
      rofi
    ];

    text = ''
      if [ "$#" -gt 0 ]; then
        dir="$1"
      else
        dir="$(rofi -dmenu -p "Emacs directory" \
          -theme-str 'entry { placeholder: "Path, empty = home"; }')"

        dir="''${dir:-$HOME}"
      fi

      if [ "$dir" = "~" ]; then
        dir="$HOME"
      elif [[ "$dir" == "~/"* ]]; then
        dir="$HOME/''${dir#~/}"
      elif [[ "$dir" != /* ]]; then
        dir="$HOME/$dir"
      fi

      if [ ! -d "$dir" ]; then
        notify-send "Doom Emacs" "Directory does not exist: $dir"
        exit 1
      fi

      exec emacs --chdir "$dir"
    '';
  };

in
{
  home.packages = [
    emacsLauncher
  ];
}
