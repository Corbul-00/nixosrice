data_dir="$HOME/JustMonika-S"
phrases_file="$data_dir/phrases.txt"
sfw_dir="$data_dir/sfwimgs"
nsfw_dir="$data_dir/nsfwimgs"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/justmonika"
config_file="$config_dir/config"

show_help() {
  cat <<'HELP'
justmonika — print a random Monika phrase and open a random image with imv

Usage:
  justmonika                 Use the saved image mode
  justmonika -i sfw          Use an SFW image for this run
  justmonika -i nsfw         Use an NSFW image for this run
  justmonika -c              Configure the saved image mode
  justmonika -h              Show this help

Expected files:
  ~/JustMonika-S/phrases.txt
  ~/JustMonika-S/sfwimgs/
  ~/JustMonika-S/nsfwimgs/

Configuration choices:
  both    Randomly select from both image folders (default)
  sfw     Select only from sfwimgs
  nsfw    Select only from nsfwimgs

Blank lines in phrases.txt are ignored. Image folders may contain nested
directories. Supported formats: PNG, JPG/JPEG, GIF, WebP, BMP, AVIF and JXL.
HELP
}

die() {
  printf 'justmonika: %s\n' "$*" >&2
  exit 1
}

validate_mode() {
  case "$1" in
    both | sfw | nsfw) return 0 ;;
    *) return 1 ;;
  esac
}

read_saved_mode() {
  local key
  local value
  local saved_mode="both"

  if [[ -r "$config_file" ]]; then
    while IFS='=' read -r key value; do
      if [[ "$key" == "mode" ]] && validate_mode "$value"; then
        saved_mode="$value"
      fi
    done < "$config_file"
  fi

  printf '%s\n' "$saved_mode"
}

configure_mode() {
  local choice
  local new_mode

  printf '%s\n' \
    'Choose the default image mode:' \
    '  1) SFW and NSFW' \
    '  2) SFW only' \
    '  3) NSFW only'
  read -r -p 'Selection [1-3]: ' choice

  case "$choice" in
    1) new_mode="both" ;;
    2) new_mode="sfw" ;;
    3) new_mode="nsfw" ;;
    *) die "invalid selection: $choice" ;;
  esac

  install -d -m700 "$config_dir"
  printf 'mode=%s\n' "$new_mode" > "$config_file"
  chmod 600 "$config_file"
  printf 'Default image mode saved as: %s\n' "$new_mode"
}

random_index() {
  local count="$1"
  shuf -i "0-$((count - 1))" -n 1
}

requested_mode=""
configure=false

while getopts ':hci:' option; do
  case "$option" in
    h)
      show_help
      exit 0
      ;;
    c)
      configure=true
      ;;
    i)
      requested_mode="$OPTARG"
      ;;
    :)
      die "option -$OPTARG requires an argument; use -h for help"
      ;;
    \?)
      die "unknown option: -$OPTARG; use -h for help"
      ;;
  esac
done
shift $((OPTIND - 1))

[[ "$#" -eq 0 ]] || die "unexpected argument: $1; use -h for help"

if [[ "$configure" == true ]]; then
  [[ -z "$requested_mode" ]] || die "-c and -i cannot be used together"
  configure_mode
  exit 0
fi

if [[ -n "$requested_mode" ]]; then
  validate_mode "$requested_mode" || die "-i accepts only 'sfw' or 'nsfw'"
  [[ "$requested_mode" != "both" ]] || die "-i accepts only 'sfw' or 'nsfw'"
  mode="$requested_mode"
else
  mode="$(read_saved_mode)"
fi

[[ -f "$phrases_file" ]] || die "missing phrase file: $phrases_file"

phrases=()
while IFS= read -r phrase || [[ -n "$phrase" ]]; do
  phrase="${phrase%$'\r'}"
  [[ -n "${phrase//[[:space:]]/}" ]] || continue
  phrases+=("$phrase")
done < "$phrases_file"

[[ "${#phrases[@]}" -gt 0 ]] || die "no non-empty phrases found in $phrases_file"

search_dirs=()
case "$mode" in
  sfw)
    [[ -d "$sfw_dir" ]] || die "missing SFW image directory: $sfw_dir"
    search_dirs+=("$sfw_dir")
    ;;
  nsfw)
    [[ -d "$nsfw_dir" ]] || die "missing NSFW image directory: $nsfw_dir"
    search_dirs+=("$nsfw_dir")
    ;;
  both)
    [[ -d "$sfw_dir" ]] && search_dirs+=("$sfw_dir")
    [[ -d "$nsfw_dir" ]] && search_dirs+=("$nsfw_dir")
    [[ "${#search_dirs[@]}" -gt 0 ]] || \
      die "neither $sfw_dir nor $nsfw_dir exists"
    ;;
esac

images=()
mapfile -d '' -t images < <(
  find "${search_dirs[@]}" -type f \
    \( -iname '*.png' \
       -o -iname '*.jpg' \
       -o -iname '*.jpeg' \
       -o -iname '*.gif' \
       -o -iname '*.webp' \
       -o -iname '*.bmp' \
       -o -iname '*.avif' \
       -o -iname '*.jxl' \) \
    -print0
)

[[ "${#images[@]}" -gt 0 ]] || die "no supported images found for mode '$mode'"

phrase_index="$(random_index "${#phrases[@]}")"
image_index="$(random_index "${#images[@]}")"
selected_phrase="${phrases[$phrase_index]}"
selected_image="${images[$image_index]}"

printf '\n\033[38;2;253;91;162mMonika:\033[0m %s\n\n' "$selected_phrase"

# Start imv in a detached session so justmonika can return immediately.
setsid --fork imv -- "$selected_image" >/dev/null 2>&1
