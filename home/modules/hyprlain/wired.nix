{ pkgs, hyprlain, ... }:

let
  wired = pkgs.writeShellApplication {
    name = "wired";

    runtimeInputs = with pkgs; [
      cbonsai
      cmatrix
      coreutils
      fastfetch
      findutils
      jq
      kitty
      rofi
      tplay
    ];

    text = ''
      quotes_path=${pkgs.lib.escapeShellArg "${hyprlain}/src/hyprland/src/assets/quotes.json"}
      media_root=${pkgs.lib.escapeShellArg "${hyprlain}/src/hyprland/src/assets/media"}

      show_help() {
        cat <<'HELP'
Usage: wired [MODE]

With no MODE, Hyprlain chooses a random Wired scene.

Modes:
  fastfetch, 1   Lain Fastfetch screen
  quote, 3       Random Lain quote in Rofi
  matrix, 4      CMatrix scene
  bonsai, 5      WIRED bonsai with a random quote
  media          Random Hyprlain GIF/image rendered as terminal ASCII
  camera, 0      Render /dev/video0 as terminal ASCII
  help           Show this help
HELP
      }

      quote_count=$(jq 'length' "$quotes_path")
      quote_index=$((RANDOM % quote_count))
      quote=$(jq -r --argjson index "$quote_index" '.[$index]' "$quotes_path")

      mode=""
      if (( $# > 0 )); then
        mode="$1"
      fi
      if [[ -z "$mode" ]]; then
        mode=$((1 + RANDOM % 10))
      fi

      play_media() {
        local media
        local render_mode

        media=$(find "$media_root/anim" "$media_root/imgs" -type f | shuf -n 1)
        if [[ -z "$media" ]]; then
          printf 'wired: no media found under %s\n' "$media_root" >&2
          exit 1
        fi

        render_mode=$((RANDOM % 4))
        case "$render_mode" in
          0)
            kitty --class wired --title "W I R E D" \
              -e tplay --loop-playback --allow-frame-skip "$media"
            ;;
          1)
            kitty --class wired --title "W I R E D" \
              -e tplay --loop-playback --allow-frame-skip --gray "$media"
            ;;
          2)
            kitty --class wired --title "W I R E D" \
              -e tplay --loop-playback --allow-frame-skip --char-map WIRED "$media"
            ;;
          3)
            kitty --class wired --title "W I R E D" \
              -e tplay --loop-playback --allow-frame-skip --gray --char-map WIRED "$media"
            ;;
        esac
      }

      case "$mode" in
        0|camera)
          if [[ ! -e /dev/video0 ]]; then
            printf 'wired: /dev/video0 does not exist\n' >&2
            exit 1
          fi
          kitty --class wired --title "W I R E D // CAMERA" \
            -e tplay --allow-frame-skip /dev/video0
          ;;
        1|fastfetch|fetch)
          kitty --class wired --title "W I R E D // SYSTEM" \
            --hold -e fastfetch
          ;;
        3|quote)
          rofi -e "$quote"
          ;;
        4|matrix)
          kitty --class wired --title "$quote" -e cmatrix -br
          ;;
        5|bonsai)
          kitty --class wired --title "W I R E D // BONSAI" \
            -e cbonsai -l -t 0.005 -i -w 2 -c wired -k 0,1,2,12 -M 10 -L 64 -m "$quote"
          ;;
        2|6|7|8|9|10|media)
          play_media
          ;;
        help|-h|--help)
          show_help
          ;;
        *)
          printf 'wired: unknown mode: %s\n\n' "$mode" >&2
          show_help >&2
          exit 2
          ;;
      esac
    '';
  };
in
{
  home.packages = [ wired ];
}
