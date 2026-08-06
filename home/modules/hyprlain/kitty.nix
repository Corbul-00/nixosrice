{ ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "AdwaitaMono Nerd Font";
      size = 14;
    };

    settings = {
      foreground = "#C1B48E";
      background = "#000000";
      background_opacity = "0.90";
      dynamic_background_opacity = true;
      selection_foreground = "#C1B48E";
      selection_background = "#804654";
      url_color = "#968C6E";
      cursor = "#804654";
      cursor_text_color = "#C1B48E";

      color0 = "#1A1A1A";
      color8 = "#2A2A2A";
      color1 = "#CE7688";
      color9 = "#CE7688";
      color2 = "#BA6A7B";
      color10 = "#BA6A7B";
      color3 = "#A05969";
      color11 = "#A05969";
      color4 = "#965363";
      color12 = "#965363";
      color5 = "#8E4E5D";
      color13 = "#8E4E5D";
      color6 = "#804654";
      color14 = "#804654";
      color7 = "#6F3D49";
      color15 = "#6F3D49";

      cursor_trail = 1;
      tab_bar_align = "center";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      remember_window_size = true;
    };

    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
    };
  };
}
