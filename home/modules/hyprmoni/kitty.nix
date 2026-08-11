{ ... }:

let
  palette = import ./palette.nix;
in
{
  programs.kitty = {
    enable = true;

    font = {
      name = "AdwaitaMono Nerd Font";
      size = 14;
    };

    settings = {
      foreground = palette.blush;
      background = palette.void;
      background_opacity = "0.88";
      dynamic_background_opacity = true;
      dim_opacity = "0.72";

      selection_foreground = palette.void;
      selection_background = palette.pink;
      url_color = palette.peach;
      cursor = palette.hotPink;
      cursor_text_color = palette.void;

      color0 = palette.void;
      color8 = palette.panel;
      color1 = palette.pink;
      color9 = palette.hotPink;
      color2 = palette.green;
      color10 = "#4D6B5A";
      color3 = palette.peach;
      color11 = "#FFD0C5";
      color4 = palette.wine;
      color12 = "#A63A68";
      color5 = palette.pink;
      color13 = palette.hotPink;
      color6 = "#A12D65";
      color14 = "#C04B7A";
      color7 = palette.blush;
      color15 = "#FFFFFF";

      tab_bar_style = "separator";
      tab_bar_align = "center";
      tab_bar_background = palette.void;
      active_tab_foreground = palette.void;
      active_tab_background = palette.pink;
      inactive_tab_foreground = palette.blush;
      inactive_tab_background = palette.wineDark;
      tab_separator = " │ ";

      cursor_trail = 1;
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      remember_window_size = true;
      window_padding_width = 7;
    };

    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
    };
  };
}
