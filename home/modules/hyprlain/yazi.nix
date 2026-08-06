{ ... }:

let
  black = "#000000";
  beige = "#C1B48E";
  pink = "#CE7688";
  rose = "#BA6A7B";
  muted = "#965363";
  darkRose = "#5D333C";

  icon = name: text: fg: { inherit name text fg; };
in
{
  # Yazi is enabled globally in modules/yazi/default.nix.  Keeping this theme
  # inside the Hyprlain import means the default desktop remains unchanged.
  programs.yazi.theme = {
    mgr = {
      cwd = { fg = pink; };
      hovered = { fg = black; bg = rose; bold = true; };
      preview_hovered = { underline = true; };
      find_keyword = { fg = pink; bold = true; italic = true; underline = true; };
      find_position = { fg = beige; bg = "reset"; bold = true; };
      symlink_target = { fg = muted; italic = true; };
      marker_copied = { fg = pink; bg = pink; };
      marker_cut = { fg = muted; bg = muted; };
      marker_marked = { fg = beige; bg = beige; };
      marker_selected = { fg = rose; bg = rose; };
      count_copied = { fg = black; bg = pink; };
      count_cut = { fg = black; bg = muted; };
      count_selected = { fg = black; bg = beige; };
      border_symbol = "│";
      border_style = { fg = darkRose; };
      syntect_theme = "";
    };

    tabs = {
      active = { fg = black; bg = rose; bold = true; };
      inactive = { fg = beige; bg = darkRose; };
      sep_inner = { open = ""; close = ""; };
      sep_outer = { open = ""; close = ""; };
    };

    mode = {
      normal_main = { fg = black; bg = rose; bold = true; };
      normal_alt = { fg = rose; bg = darkRose; };
      select_main = { fg = black; bg = beige; bold = true; };
      select_alt = { fg = beige; bg = darkRose; };
      unset_main = { fg = black; bg = muted; bold = true; };
      unset_alt = { fg = muted; bg = darkRose; };
    };

    status = {
      overall = { fg = beige; bg = black; };
      sep_left = { open = ""; close = ""; };
      sep_right = { open = ""; close = ""; };
      perm_sep = { fg = darkRose; };
      perm_type = { fg = rose; };
      perm_read = { fg = beige; };
      perm_write = { fg = pink; };
      perm_exec = { fg = muted; };
      progress_label = { fg = beige; bold = true; };
      progress_normal = { fg = pink; bg = darkRose; };
      progress_error = { fg = beige; bg = muted; };
    };

    which = {
      cols = 3;
      mask = { bg = black; };
      cand = { fg = pink; };
      rest = { fg = muted; };
      desc = { fg = beige; };
      separator = "  ";
      separator_style = { fg = darkRose; };
    };

    confirm = {
      border = { fg = pink; };
      title = { fg = beige; };
      content = { fg = beige; };
      list = { fg = rose; };
      btn_yes = { fg = black; bg = pink; bold = true; };
      btn_no = { fg = beige; bg = darkRose; };
      btn_labels = [ "  [Y]es  " "  (N)o  " ];
    };

    spot = {
      border = { fg = pink; };
      title = { fg = beige; };
      tbl_col = { fg = rose; };
      tbl_cell = { fg = beige; bg = darkRose; };
    };

    notify = {
      title_info = { fg = pink; };
      title_warn = { fg = beige; };
      title_error = { fg = muted; };
      icon_info = "";
      icon_warn = "";
      icon_error = "";
    };

    pick = {
      border = { fg = pink; };
      active = { fg = black; bg = rose; bold = true; };
      inactive = { fg = beige; };
    };

    input = {
      border = { fg = pink; };
      title = { fg = beige; };
      value = { fg = beige; };
      selected = { fg = black; bg = rose; };
    };

    cmp = {
      border = { fg = pink; };
      active = { fg = black; bg = rose; bold = true; };
      inactive = { fg = beige; };
      icon_file = "";
      icon_folder = "";
      icon_command = "";
    };

    tasks = {
      border = { fg = pink; };
      title = { fg = beige; };
      hovered = { fg = pink; underline = true; };
    };

    help = {
      on = { fg = pink; };
      run = { fg = rose; };
      desc = { fg = beige; };
      hovered = { fg = black; bg = rose; bold = true; };
      footer = { fg = black; bg = pink; };
    };

    filetype.rules = [
      { mime = "inode/directory"; fg = rose; }
      { mime = "image/*"; fg = beige; }
      { mime = "{audio,video}/*"; fg = muted; }
      { mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}"; fg = muted; }
      { mime = "application/{pdf,doc,rtf}"; fg = pink; }
      { mime = "text/*"; fg = beige; }
      { name = "*"; is = "orphan"; fg = black; bg = muted; }
      { name = "*"; is = "exec"; fg = pink; bold = true; }
      { name = "*"; is = "dummy"; fg = black; bg = muted; }
      { name = "*/"; is = "dummy"; fg = black; bg = muted; }
      { name = "*"; fg = beige; }
      { name = "*/"; fg = rose; }
    ];

    # These entries override Yazi's built-in rainbow colors while preserving
    # recognizable Nerd Font glyphs.  In particular, Nix's blue snowflake is
    # retained as a Nix glyph but recolored to the Hyprlain accent.
    icon.prepend_exts = [
      (icon "nix" "" pink)
      (icon "json" "" rose)
      (icon "json5" "" rose)
      (icon "jsonc" "" rose)
      (icon "html" "" pink)
      (icon "htm" "" pink)
      (icon "css" "" rose)
      (icon "scss" "" rose)
      (icon "xml" "󰗀" muted)
      (icon "toml" "" rose)
      (icon "yaml" "" rose)
      (icon "yml" "" rose)
      (icon "md" "" beige)
      (icon "mdx" "" beige)
      (icon "txt" "󰈙" beige)
      (icon "conf" "" muted)
      (icon "ini" "" muted)
      (icon "cfg" "" muted)
      (icon "sh" "" pink)
      (icon "bash" "" pink)
      (icon "zsh" "" pink)
      (icon "fish" "" pink)
      (icon "py" "" rose)
      (icon "lua" "" rose)
      (icon "js" "" beige)
      (icon "mjs" "" beige)
      (icon "cjs" "" beige)
      (icon "ts" "" rose)
      (icon "tsx" "" rose)
      (icon "jsx" "" rose)
      (icon "rs" "" pink)
      (icon "go" "" rose)
      (icon "c" "" muted)
      (icon "h" "" muted)
      (icon "cpp" "" muted)
      (icon "hpp" "" muted)
      (icon "lock" "" muted)
      (icon "desktop" "" rose)
    ];

    icon.prepend_files = [
      (icon "flake.nix" "" pink)
      (icon "flake.lock" "" muted)
      (icon "package.json" "" rose)
      (icon "package-lock.json" "" muted)
      (icon ".gitignore" "" muted)
      (icon ".env" "" beige)
    ];
  };
}
