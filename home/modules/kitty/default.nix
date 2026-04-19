{ ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14;
    };

    settings = {
      background             = "#2d1338";
      background_opacity     = "0.7";
      dynamic_background_opacity = true;
      dim_opacity            = "0.75";

      foreground             = "#d8c2f0";
      cursor                 = "#8b5cf6";
      selection_background   = "#8b5cf6";
      selection_foreground   = "#ffffff";

      tab_bar_style          = "fade";
      tab_fade               = "0.5 1 1 0";
      active_tab_background  = "#8b5cf6";
      inactive_tab_background = "#2a2a6e";
      tab_bar_background     = "#2a2a6e";
    };

    # Optional QoL additions (no visual change)
    settings = {
      # ... previous ones ...
      confirm_os_window_close = 0;
      enable_audio_bell       = false;
      remember_window_size    = true;
    };
  };
}
