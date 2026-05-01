{ ... }:
{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14;
    };

    settings = {
      # === Kawaii Moe Pink Theme ===
      background = "#ffb6c1";           # Soft kawaii pink background (matches Waybar)
      background_opacity = "0.82";      # Slightly higher opacity than before for better readability
      dynamic_background_opacity = true;
      dim_opacity = "0.75";

      foreground = "#ff4d94";           # Main text = vibrant pink (same as Waybar border/text)

      cursor = "#ff4d94";               # Cursor matches the accent pink
      cursor_shape = "beam";

      selection_background = "#d8c2f0"; # Selection background = vibrant pink
      selection_foreground = "#ffffff"; # White text on selection for contrast

      # Tab bar styling
      tab_bar_style = "fade";
      tab_fade = "0.5 1 1 0";
      active_tab_background = "#ff4d94";   # Active tab = bright pink
      active_tab_foreground = "#ffffff";   # White text on active tab
      inactive_tab_background = "#ff8eb8"; # Softer pink for inactive tabs
      inactive_tab_foreground = "#4a1a2f"; # Darker rose for inactive text
      tab_bar_background = "#ffb6c1";      # Same as main background

      # Extra QoL settings
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      remember_window_size = true;

      # Optional: Better readability on pink background
      adjust_line_height = "110%";
    };
  };
}
