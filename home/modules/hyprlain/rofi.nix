{ pkgs, ... }:

{
  home.packages = [ pkgs.rofi-wayland ];

  # A repaired, self-contained version of the upstream Rofi appearance. It
  # avoids optional Arch plugins (rofi-calc/rofi-emoji), so drun is reliable.
  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      show-icons: true;
      modes: [drun, run, window];
      combi-modes: [drun, run];
      fixed-num-lines: false;
      display-drun: "Applications";
      matching: "fuzzy";
    }

    * {
      background: #000000;
      background-alt: #1A1A1A;
      foreground: #C1B48E;
      accent: #CE7688;
      accent-dark: #804654;
      selected: #2A2A2A;
      font: "AdwaitaMono Nerd Font 13";
    }

    window {
      width: 42%;
      border: 2px;
      border-color: @accent;
      border-radius: 0px;
      background-color: @background;
      padding: 0px;
    }

    mainbox {
      background-color: transparent;
      children: [ inputbar, message, listview ];
    }

    inputbar {
      background-color: @background-alt;
      text-color: @foreground;
      padding: 10px;
      spacing: 8px;
      children: [ prompt, entry ];
    }

    prompt {
      text-color: @accent;
    }

    entry {
      text-color: @foreground;
      placeholder: "present day, present time...";
      placeholder-color: @accent-dark;
    }

    message {
      padding: 8px;
      background-color: @background;
      text-color: @foreground;
    }

    listview {
      lines: 10;
      columns: 1;
      fixed-height: false;
      scrollbar: true;
      spacing: 0px;
      background-color: @background;
    }

    element {
      padding: 8px;
      spacing: 10px;
      background-color: transparent;
      text-color: @foreground;
    }

    element selected.normal {
      background-color: @selected;
      text-color: @accent;
    }

    element-icon {
      size: 24px;
      background-color: transparent;
    }

    element-text {
      background-color: transparent;
      text-color: inherit;
      vertical-align: 0.5;
    }

    scrollbar {
      width: 4px;
      handle-color: @accent;
      background-color: @background-alt;
    }
  '';
}
