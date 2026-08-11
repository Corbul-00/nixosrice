{ pkgs, ... }:

let
  assets = toString ./assets;
  customLockscreen = "${assets}/lockscreen.png";
  lockscreenPath =
    if builtins.pathExists customLockscreen then customLockscreen else "screenshot";
in
{
  programs.hyprlock = {
    enable = true;
    package = pkgs.hyprlock;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        grace = 0;
        immediate_render = true;
      };

      background = [
        {
          monitor = "";
          path = lockscreenPath;
          color = "rgb(0D0D0D)";
          blur_passes = 3;
          blur_size = 6;
          brightness = 0.42;
          contrast = 1.05;
          vibrancy = 0.15;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "360, 54";
          outline_thickness = 2;
          dots_size = 0.24;
          dots_spacing = 0.28;
          outer_color = "rgb(CE4A7E)";
          inner_color = "rgba(1B1B1Bdd)";
          font_color = "rgb(FFD9E8)";
          check_color = "rgb(FFAA99)";
          fail_color = "rgb(FD5BA2)";
          fade_on_empty = false;
          placeholder_text = "<i>Write your poem...</i>";
          fail_text = "<i>Let's try that again.</i>";
          hide_input = false;
          rounding = 0;
          position = "0, -175";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] date +'%H:%M'";
          color = "rgb(FD5BA2)";
          font_size = 64;
          font_family = "Mali SemiBold";
          position = "0, 70";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:60000] date +'%A, %d %B'";
          color = "rgb(FFD9E8)";
          font_size = 18;
          font_family = "Mali Medium";
          position = "0, 10";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "Welcome back, $USER.";
          color = "rgb(FFAA99)";
          font_size = 17;
          font_family = "Mali Medium";
          position = "0, -105";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
