{ pkgs, ... }:

{
  services.dunst = {
    enable = true;
    package = pkgs.dunst;

    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        width = "(200, 400)";
        height = "(0, 600)";
        origin = "top-right";
        offset = "(10, 50)";
        notification_limit = 20;
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        transparency = 0;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        frame_width = 2;
        frame_color = "#CE7688";
        separator_color = "#CE7688";
        gap_size = 0;
        sort = "urgency_descending";
        font = "AdwaitaMono Nerd Font 12";
        markup = "full";
        format = "<b>%s</b>\\n%b";
        alignment = "center";
        vertical_alignment = "center";
        icon_theme = "Hyprlaicons";
        enable_recursive_icon_lookup = true;
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 96;
        history_length = 20;
        corner_radius = 0;
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };

      urgency_low = {
        background = "#000000";
        foreground = "#C1B48E";
        timeout = 10;
      };

      urgency_normal = {
        background = "#000000";
        foreground = "#C1B48E";
        timeout = 10;
      };

      urgency_critical = {
        background = "#965363";
        foreground = "#C1B48E";
        timeout = 0;
      };
    };
  };
}
