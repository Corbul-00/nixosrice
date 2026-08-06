{ pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;
    package = pkgs.hyprlock;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        grace = 0;
      };

      background = [
        {
          monitor = "";
          path = "$HOME/.config/assets/media/imgs/lain_wall.png";
          color = "rgb(000000)";
          blur_passes = 2;
          blur_size = 4;
          brightness = 0.55;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "300, 46";
          outline_thickness = 2;
          dots_size = 0.25;
          dots_spacing = 0.25;
          outer_color = "rgb(CE7688)";
          inner_color = "rgb(000000)";
          font_color = "rgb(C1B48E)";
          fade_on_empty = false;
          placeholder_text = "<i>connect to the Wired...</i>";
          hide_input = false;
          position = "0, -180";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] date +'%H:%M:%S'";
          color = "rgb(C1B48E)";
          font_size = 48;
          font_family = "AdwaitaMono Nerd Font";
          position = "0, 40";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "present day, present time";
          color = "rgb(CE7688)";
          font_size = 16;
          font_family = "AdwaitaMono Nerd Font";
          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
