{ pkgs, ... }:

pkgs.writeShellScriptBin "mybsc" ''
  # ─────────────────────────────────────────────────────────────
  #  mybsc — unified personal script launcher
  #  Usage:  mybsc <scriptname> [args...]
  #          mybsc ls
  # ─────────────────────────────────────────────────────────────

  SCRIPTS_DIR="/etc/nixos/home/modules/mybsc/scripts"

  # ── Shared speech bubble + ASCII art printer ─────────────────
  _say() {
    local ascii_file="$1"
    shift
    local INPUT_TEXT="$*"

    clear

    [ -z "$INPUT_TEXT" ] && INPUT_TEXT="..."

    local TEXT_LENGTH=''${#INPUT_TEXT}
    local BUBBLE_WIDTH=$(( TEXT_LENGTH + 2 ))
    [ $BUBBLE_WIDTH -lt 10 ] && BUBBLE_WIDTH=10

    local TOP_BORDER="  ┌─$(printf '%0.s─' $(seq 1 $BUBBLE_WIDTH))─┐"
    local BOTTOM_BORDER="  └─$(printf '%0.s─' $(seq 1 $BUBBLE_WIDTH))─┘"
    local TEXT_LINE="  │ $(printf '%-*s' $BUBBLE_WIDTH "$INPUT_TEXT") │"
    local STEM="   \\  "

    echo "$TOP_BORDER"
    echo "$TEXT_LINE"
    echo "$BOTTOM_BORDER"
    echo "$STEM"
    cat "$ascii_file"
    echo ""
  }

  # ── Built-in scripts ─────────────────────────────────────────

  _2bsay()        { _say ~/ASCII/2b.txt         "$@"; }
  _ahesay()       { _say ~/ASCII/ahegao.txt      "$@"; }
  _arwaifusay()   { _say ~/ASCII/arwaifu.txt     "$@"; }
  _boobsay()      { _say ~/ASCII/madjugs.txt     "$@"; }
  _bootysay()     { _say ~/ASCII/anmass.txt      "$@"; }
  _chadgsay()     { _say ~/ASCII/chadguy.txt     "$@"; }
  _crygirlsay()   { _say ~/ASCII/cryingirl.txt   "$@"; }
  _dmngrlf()      { _say ~/ASCII/demongyall.txt  "$@"; }
  _foxsay()       { _say ~/ASCII/foxchibi.txt    "$@"; }
  _frierensay()   { _say ~/ASCII/frieren.txt     "$@"; }
  _gojosay()      { _say ~/ASCII/gojo.txt        "$@"; }
  _nmaidsay()     { _say ~/ASCII/nazunamaid.txt  "$@"; }
  _ztsay()        { _say ~/ASCII/zerotwo.txt     "$@"; }

  _dgreet() {
    _say ~/ASCII/demongyall.txt "Welcome, Master."
    exec $SHELL -i
  }

  _hashdating() {
    echo "Enter the text to hash:"
    read text
    echo "Select the hash algorithm:"
    echo "1) SHA-256"
    echo "2) SHA-512"
    echo "3) SHA-1"
    echo "4) SHA-384"
    echo "5) SHA-224"
    echo "6) SHA-512/224"
    echo "7) SHA-512-256"
    echo "8) MD5"
    read -p "Enter your choice (1-8): " choice
    case $choice in
      1) echo -n "$text" | openssl dgst -sha256    ;;
      2) echo -n "$text" | openssl dgst -sha512    ;;
      3) echo -n "$text" | openssl dgst -sha1      ;;
      4) echo -n "$text" | openssl dgst -sha384    ;;
      5) echo -n "$text" | openssl dgst -sha224    ;;
      6) echo -n "$text" | openssl dgst -sha512-224;;
      7) echo -n "$text" | openssl dgst -sha512-256;;
      8) echo -n "$text" | openssl dgst -md5       ;;
      *) echo "Invalid choice"; exit 1             ;;
    esac
  }

  _drillafetch() {
    local QUOTES_FILE="/home/ayanolord/ASCII/drillafetch/quotes.txt"
    clear

    [[ ! -f "$QUOTES_FILE" ]] && {
      echo "No quotes found in ''${QUOTES_FILE}"
      exit 1
    }

    local line
    line=$(shuf -n 1 "$QUOTES_FILE")

    local quote rest artist song
    quote=$(echo "$line"  | cut -d_ -f1 | xargs)
    rest=$(echo "$line"   | cut -d_ -f2 | xargs)
    artist=$(echo "$rest" | sed 's/ - .*//' | xargs)
    song=$(echo "$rest"   | sed 's/.* - //' | xargs)

    local PADDING=4 MAX_WIDTH=70 MIN_WIDTH=40

    _wrap() {
      local text="$1" max="$2"
      local wline="" result=()
      for word in $text; do
        if [ ''${#wline} -eq 0 ]; then
          wline="$word"
        elif [ $(( ''${#wline} + ''${#word} + 1 )) -le $max ]; then
          wline="$wline $word"
        else
          result+=("$wline")
          wline="$word"
        fi
      done
      [ -n "$wline" ] && result+=("$wline")
      printf '%s\n' "''${result[@]}"
    }

    local quote_lines longest_quote=0
    mapfile -t quote_lines < <(_wrap "$quote" $(( MAX_WIDTH - PADDING*2 )))
    for l in "''${quote_lines[@]}"; do
      (( ''${#l} > longest_quote )) && longest_quote=''${#l}
    done

    local longest_content=$longest_quote
    (( ''${#artist} > longest_content ))             && longest_content=''${#artist}
    (( (''${#song} + 3) > longest_content ))         && longest_content=$(( ''${#song} + 3 ))

    local inner_width=$(( longest_content + PADDING*2 ))
    (( inner_width < MIN_WIDTH )) && inner_width=$MIN_WIDTH
    (( inner_width > MAX_WIDTH )) && inner_width=$MAX_WIDTH

    local top="   ╔$(printf '═%.0s' $(seq 1 $inner_width))╗"
    local bot="   ╚$(printf '═%.0s' $(seq 1 $inner_width))╝"
    local side="   ║"
    local empty="$side$(printf ' %.0s' $(seq 1 $inner_width)) $side"

    echo "$top"
    echo "$empty"
    for ql in "''${quote_lines[@]}"; do
      printf "%s %*s %s\n" "$side" "$inner_width" "$ql" "║"
    done
    echo "$empty"
    printf "%s %*s %s\n" "$side" "$inner_width" "$artist"  "║"
    printf "%s %*s %s\n" "$side" "$inner_width" "- $song"  "║"
    echo "$empty"
    echo "$bot"
    echo ""
  }

  _drillrr() {
    local MAIN_SCRIPT="$HOME/CobraS/DrillR/randompicker.py"
    if [[ -f "$MAIN_SCRIPT" ]]; then
      exec python "$MAIN_SCRIPT" "$@"
    else
      echo "Error: Drill R script not found at: $MAIN_SCRIPT"
      exit 1
    fi
  }

  _talktomonika() {
    local PROJECT_DIR="/home/ayanolord/CobraS/CBL/"
    cd "$PROJECT_DIR" || { echo "Directory not found: $PROJECT_DIR"; exit 1; }
    source CBL/bin/activate
    python cbl.py "$@"
  }

  _pacocar() {
    local CONFIG_FILE="$HOME/.pacoca-r.conf"

    _pc_load_config() {
      if [[ ! -f "$CONFIG_FILE" ]]; then
        FOLDER="$HOME/Pictures"
        EXTENSIONS="jpg png gif mp4 webm mkv avi"
        _pc_save_config
        echo "Initialized default config: Folder=$FOLDER, Extensions=$EXTENSIONS"
      else
        source "$CONFIG_FILE"
      fi
      if [[ -z "$FOLDER" || ! -d "$FOLDER" ]]; then
        FOLDER="$HOME/Pictures"
        echo "Warning: Invalid folder in config. Reset to default: $FOLDER"
      fi
      if [[ -z "$EXTENSIONS" ]]; then
        EXTENSIONS="jpg png gif mp4 webm mkv avi"
        echo "Warning: Invalid extensions in config. Reset to default."
      fi
      _pc_save_config
    }

    _pc_save_config() {
      echo "FOLDER=\"$FOLDER\""     > "$CONFIG_FILE"
      echo "EXTENSIONS=\"$EXTENSIONS\"" >> "$CONFIG_FILE"
    }

    _pc_open_random() {
      local find_args=()
      for ext in $EXTENSIONS; do
        find_args+=(-o -iname "*.$ext")
      done
      unset 'find_args[0]'
      local random_file
      random_file=$(find "$FOLDER" -type f \( "''${find_args[@]}" \) 2>/dev/null | shuf -n 1)
      if [[ -z "$random_file" ]]; then
        echo "Error: No matching files found in '$FOLDER' with extensions: $EXTENSIONS"
        exit 1
      fi
      xdg-open "$random_file" &>/dev/null &
      echo "Opened: $random_file"
    }

    _pc_set_folder() {
      echo "Current folder: $FOLDER"
      read -rp "Enter new folder path (or press Enter to keep current): " new_folder
      if [[ -n "$new_folder" ]]; then
        new_folder="''${new_folder/#\~/$HOME}"
        if [[ -d "$new_folder" ]]; then
          FOLDER="$new_folder"
          _pc_save_config
          echo "Folder updated to: $FOLDER"
        else
          echo "Error: '$new_folder' is not a valid directory."
          exit 1
        fi
      else
        echo "Folder unchanged."
      fi
    }

    _pc_set_fileformats() {
      echo "Current enabled extensions: $EXTENSIONS"
      read -rp "New extensions (space-separated, or Enter to keep): " new_extensions
      if [[ -n "$new_extensions" ]]; then
        if [[ "$new_extensions" =~ ^[a-zA-Z0-9\ ]+$ ]]; then
          EXTENSIONS="$new_extensions"
          _pc_save_config
          echo "Extensions updated to: $EXTENSIONS"
        else
          echo "Error: Invalid input."
          exit 1
        fi
      else
        echo "Extensions unchanged."
      fi
    }

    _pc_load_config
    case "''${1:-}" in
      "")           _pc_open_random   ;;
      -setfolder)   _pc_set_folder    ;;
      -fileformat)  _pc_set_fileformats ;;
      *)
        echo "Usage: mybsc paçoca-r [-setfolder | -fileformat]"
        exit 1
        ;;
    esac
  }

  # ── Built-in script registry (for ls) ────────────────────────
  BUILTIN_SCRIPTS=(
    "2bsay         — 2B says something (ASCII art)"
    "ahesay        — Ahegao says something"
    "arwaifusay    — AR Waifu says something"
    "boobsay       — Madjugs says something"
    "bootysay      — Anmass says something"
    "chadgsay      — Chad Guy says something"
    "crygirlsay    — Crying Girl says something"
    "dgreet        — Demon Girl greeter (runs a shell)"
    "dmngrlf       — Demon Girl says something"
    "drillafetch   — Random UK Drill quote fetcher"
    "drillrr       — Drill R random picker launcher"
    "foxsay        — Fox Chibi says something"
    "frierensay    — Frieren says something"
    "gojosay       — Gojo says something"
    "hashdating    — Interactive text hasher (SHA/MD5)"
    "nmaidsay      — Nazuna Maid says something"
    "paçoca-r      — Random media file opener"
    "talktomonika  — Launch TalkToMonika (CBL)"
    "ztsay         — Zero Two says something"
  )

  # ── ls: list builtins + any extra scripts in scripts dir ─────
  _ls() {
    echo ""
    echo "  ┌─────────────────────────────────────────────┐"
    echo "  │           mybsc — available scripts         │"
    echo "  └─────────────────────────────────────────────┘"
    echo ""
    echo "  [built-in]"
    for entry in "''${BUILTIN_SCRIPTS[@]}"; do
      echo "    mybsc $entry"
    done

    if [[ -d "$SCRIPTS_DIR" ]]; then
      local extras=()
      while IFS= read -r f; do
        [[ -x "$f" ]] && extras+=("$(basename "$f")")
      done < <(find "$SCRIPTS_DIR" -maxdepth 1 -type f)

      if [[ ''${#extras[@]} -gt 0 ]]; then
        echo ""
        echo "  [extra — from $SCRIPTS_DIR]"
        for s in "''${extras[@]}"; do
          echo "    mybsc $s"
        done
      fi
    fi
    echo ""
  }

  # ── Dispatcher ───────────────────────────────────────────────
  SUBCMD="''${1:-}"
  shift || true

  case "$SUBCMD" in
    "")           echo "Usage: mybsc <script> [args...]  |  mybsc ls" ;;
    ls)           _ls ;;
    2bsay)        _2bsay        "$@" ;;
    ahesay)       _ahesay       "$@" ;;
    arwaifusay)   _arwaifusay   "$@" ;;
    boobsay)      _boobsay      "$@" ;;
    bootysay)     _bootysay     "$@" ;;
    chadgsay)     _chadgsay     "$@" ;;
    crygirlsay)   _crygirlsay   "$@" ;;
    dgreet)       _dgreet            ;;
    dmngrlf)      _dmngrlf      "$@" ;;
    drillafetch)  _drillafetch       ;;
    drillrr)      _drillrr      "$@" ;;
    foxsay)       _foxsay       "$@" ;;
    frierensay)   _frierensay   "$@" ;;
    gojosay)      _gojosay      "$@" ;;
    hashdating)   _hashdating        ;;
    nmaidsay)     _nmaidsay     "$@" ;;
    "paçoca-r")   _pacocar      "$@" ;;
    talktomonika) _talktomonika "$@" ;;
    ztsay)        _ztsay        "$@" ;;
    *)
      # Check extras dir for unknown commands
      if [[ -d "$SCRIPTS_DIR" && -x "$SCRIPTS_DIR/$SUBCMD" ]]; then
        exec "$SCRIPTS_DIR/$SUBCMD" "$@"
      else
        echo "mybsc: unknown script '$SUBCMD'"
        echo "Run 'mybsc ls' to see available scripts."
        exit 1
      fi
      ;;
  esac
''
