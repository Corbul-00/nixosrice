{ pkgs, ... }:

let
  palette = import ./palette.nix;
in
{
  services.dunst = {
    enable = true;
    package = pkgs.dunst;

    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        width = "(280, 430)";
        height = "(0, 600)";
        origin = "top-right";
        offset = "(10, 42)";
        notification_limit = 12;
        progress_bar = true;
        progress_bar_height = 8;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 390;
        transparency = 8;
        separator_height = 2;
        padding = 12;
        horizontal_padding = 12;
        frame_width = 2;
        frame_color = palette.pink;
        separator_color = palette.wine;
        gap_size = 4;
        sort = "urgency_descending";
        font = "Mali Medium 12";
        markup = "full";
        format = "<b>%s</b>\\n%b";
        alignment = "left";
        vertical_alignment = "center";
        icon_theme = "Hyprmoni-icons";
        enable_recursive_icon_lookup = true;
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 72;
        history_length = 20;
        corner_radius = 0;
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };

      urgency_low = {
        background = palette.panel;
        foreground = palette.blush;
        timeout = 8;
      };

      urgency_normal = {
        background = palette.panel;
        foreground = palette.blush;
        timeout = 10;
      };

      urgency_critical = {
        background = palette.wine;
        foreground = palette.blush;
        frame_color = palette.hotPink;
        timeout = 0;
      };
    };
  };
}
