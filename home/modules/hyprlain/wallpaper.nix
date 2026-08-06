{ pkgs, hyprlain, ... }:

let
  defaultWallpaper =
    "${hyprlain}/src/hyprland/src/assets/media/anim/bg_dark_anim_0_08.gif";

  hyprlainWallpapers = pkgs.writeShellApplication {
    name = "hyprlain-wallpapers";

    runtimeInputs = with pkgs; [
      coreutils
      gnugrep
      swww
      waypaper
    ];

    text = ''
      state_root=$(printenv XDG_STATE_HOME || true)
      if [[ -z "$state_root" ]]; then
        state_root="$HOME/.local/state"
      fi

      state_dir="$state_root/waypaper"
      state_file="$state_dir/hyprlain.ini"
      mkdir -p "$state_dir"

      if (( $# > 0 )) && [[ "$1" == "--restore" ]]; then
        if [[ ! -s "$state_file" ]] || ! grep -q '^wallpaper[[:space:]]*=' "$state_file"; then
          for _ in $(seq 1 20); do
            if swww query >/dev/null 2>&1; then
              exec swww img ${pkgs.lib.escapeShellArg defaultWallpaper}
            fi
            sleep 0.1
          done
          printf 'hyprlain-wallpapers: swww daemon did not become ready\n' >&2
          exit 1
        fi
      fi

      exec waypaper \
        --backend swww \
        --folder \
          ${pkgs.lib.escapeShellArg "${hyprlain}/src/hyprland/src/assets/media/anim"} \
          ${pkgs.lib.escapeShellArg "${hyprlain}/src/hyprland/src/assets/media/imgs"} \
        --state-file "$state_file" \
        "$@"
    '';
  };
in
{
  home.packages = [ hyprlainWallpapers ];
}
