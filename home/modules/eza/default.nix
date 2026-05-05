{ ... }:

{
  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;

    extraOptions = [
      "--group-directories-first"
      "--color=always"
      "--color-scale"
      "--color-scale-mode=gradient"
    ];

    enableFishIntegration = true;
  };

  xdg.configFile."eza/theme.yml".text = ''
    filenames: {}

    extensions:
      # Nix
      nix:    { foreground: "#c792ea" }  # light purple

      # Shell / scripts
      sh:     { foreground: "#89b4fa" }  # blue
      fish:   { foreground: "#89b4fa" }
      bash:   { foreground: "#89b4fa" }
      zsh:    { foreground: "#89b4fa" }

      # Systems / compiled
      rs:     { foreground: "#b4befe" }  # lavender
      c:      { foreground: "#b4befe" }
      cpp:    { foreground: "#b4befe" }
      h:      { foreground: "#cba6f7" }  # mauve purple
      o:      { foreground: "#6c7086" }  # muted

      # Web / scripting
      js:     { foreground: "#89b4fa" }
      ts:     { foreground: "#74c7ec" }  # sky blue
      jsx:    { foreground: "#89b4fa" }
      tsx:    { foreground: "#74c7ec" }
      py:     { foreground: "#cba6f7" }  # light purple
      lua:    { foreground: "#b4befe" }  # lavender

      # Config / data
      json:   { foreground: "#89dceb" }  # teal-blue
      toml:   { foreground: "#89dceb" }
      yaml:   { foreground: "#89dceb" }
      yml:    { foreground: "#89dceb" }
      ini:    { foreground: "#89dceb" }
      conf:   { foreground: "#89dceb" }
      env:    { foreground: "#a6e3a1" }

      # Docs
      md:     { foreground: "#74c7ec" }  # sky blue
      txt:    { foreground: "#cdd6f4" }  # soft white
      pdf:    { foreground: "#f38ba8" }  # muted red (stands out)
      org:    { foreground: "#74c7ec" }

      # Images
      png:    { foreground: "#cba6f7" }
      jpg:    { foreground: "#cba6f7" }
      jpeg:   { foreground: "#cba6f7" }
      gif:    { foreground: "#b4befe" }
      svg:    { foreground: "#89b4fa" }
      webp:   { foreground: "#cba6f7" }
      ico:    { foreground: "#b4befe" }

      # Video / audio
      mp4:    { foreground: "#f5c2e7" }  # pink-purple
      mkv:    { foreground: "#f5c2e7" }
      webm:   { foreground: "#f5c2e7" }
      mp3:    { foreground: "#cba6f7" }
      flac:   { foreground: "#cba6f7" }
      wav:    { foreground: "#cba6f7" }

      # Archives
      zip:    { foreground: "#fab387" }  # orange (stands out as special)
      tar:    { foreground: "#fab387" }
      gz:     { foreground: "#fab387" }
      zst:    { foreground: "#fab387" }
      xz:     { foreground: "#fab387" }
      7z:     { foreground: "#fab387" }

      # Binaries / build
      so:     { foreground: "#6c7086" }  # muted grey
      a:      { foreground: "#6c7086" }
      out:    { foreground: "#6c7086" }
      lock:   { foreground: "#585b70" }  # very muted
  '';
}
