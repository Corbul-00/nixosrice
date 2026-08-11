{ pkgs, ... }:

{
  home.packages = [ pkgs.rofi ];

  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      show-icons: true;
      modes: [drun, run, window];
      combi-modes: [drun, run];
      fixed-num-lines: false;
      display-drun: "Applications";
      display-run: "Command";
      display-window: "Open windows";
      matching: "fuzzy";
      drun-display-format: "{name}";
    }

    * {
      void: #0D0D0DEE;
      panel: #1B1B1BF2;
      wine: #67253F;
      wine-dark: #401929;
      pink: #CE4A7E;
      hot-pink: #FD5BA2;
      blush: #FFD9E8;
      peach: #FFAA99;
      background-color: transparent;
      text-color: @blush;
      font: "Mali Medium 15";
    }

    window {
      width: 42%;
      border: 2px;
      border-color: @pink;
      border-radius: 0px;
      background-color: @void;
      padding: 8px;
    }

    mainbox {
      background-color: transparent;
      children: [ inputbar, message, listview ];
      spacing: 8px;
    }

    inputbar {
      background-color: @panel;
      border: 2px;
      border-color: @wine;
      border-radius: 0px;
      padding: 10px;
      spacing: 8px;
      children: [ prompt, entry ];
    }

    prompt {
      text-color: @hot-pink;
      str: "Just Monika >";
    }

    entry {
      text-color: @blush;
      placeholder: "Search the club...";
      placeholder-color: @wine;
    }

    message {
      padding: 8px;
      border: 1px;
      border-color: @wine;
      background-color: @panel;
      text-color: @peach;
    }

    listview {
      lines: 10;
      columns: 1;
      fixed-height: false;
      scrollbar: true;
      spacing: 3px;
      background-color: transparent;
    }

    element {
      padding: 9px;
      spacing: 10px;
      border: 1px;
      border-color: transparent;
      border-radius: 0px;
      background-color: @panel;
      text-color: @blush;
    }

    element selected.normal {
      border-color: @hot-pink;
      background-color: @pink;
      text-color: @void;
    }

    element-icon {
      size: 26px;
      background-color: transparent;
    }

    element-text {
      background-color: transparent;
      text-color: inherit;
      vertical-align: 0.5;
    }

    scrollbar {
      width: 5px;
      handle-color: @pink;
      background-color: @wine-dark;
      border-radius: 0px;
    }
  '';
}
