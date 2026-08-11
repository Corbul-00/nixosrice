{ pkgs, ... }:

let
  hyprmoniWallpapers = pkgs.writeShellApplication {
    name = "hyprmoni-wallpapers";

    runtimeInputs = with pkgs; [
      coreutils
      findutils
      gnugrep
      swww
      waypaper
    ];

    text = ''
      assets_root="$HOME/.config/hyprmoni/assets"
      wallpaper_dir="$assets_root/wallpapers"

      state_root="$(printenv XDG_STATE_HOME || true)"
      if [[ -z "$state_root" ]]; then
        state_root="$HOME/.local/state"
      fi

      state_dir="$state_root/waypaper"
      state_file="$state_dir/hyprmoni.ini"
      mkdir -p "$state_dir" "$wallpaper_dir"

      wait_for_swww() {
        for _ in $(seq 1 30); do
          if swww query >/dev/null 2>&1; then
            return 0
          fi
          sleep 0.1
        done
        printf 'hyprmoni-wallpapers: swww daemon did not become ready\n' >&2
        return 1
      }

      first_wallpaper=""
      if [[ -f "$wallpaper_dir/default.png" ]]; then
        first_wallpaper="$wallpaper_dir/default.png"
      else
        first_wallpaper="$(
          find "$wallpaper_dir" -maxdepth 1 -type f \
            \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \
               -o -iname '*.webp' -o -iname '*.gif' \) \
            -print | sort | head -n 1
        )"
      fi

      if (( $# > 0 )) && [[ "$1" == "--restore" ]]; then
        wait_for_swww

        if [[ -s "$state_file" ]] && grep -q '^wallpaper[[:space:]]*=' "$state_file"; then
          exec waypaper \
            --backend swww \
            --folder "$wallpaper_dir" \
            --state-file "$state_file" \
            --restore
        fi

        if [[ -n "$first_wallpaper" ]]; then
          exec swww img "$first_wallpaper" \
            --transition-type fade \
            --transition-duration 1.2
        fi

        exec swww clear 0D0D0D
      fi

      exec waypaper \
        --backend swww \
        --folder "$wallpaper_dir" \
        --state-file "$state_file" \
        "$@"
    '';
  };
in
{
  home.packages = [ hyprmoniWallpapers ];
}
