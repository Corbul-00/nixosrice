{ pkgs, lib, ... }:

let
  palette = import ./palette.nix;

  hyprmoniTheme = pkgs.writeText "hyprmoni.theme.css" ''
    /**
     * @name Hyprmoni
     * @author Corbul-00 / NixOSRice
     * @description Hyprmoni Discord theme generated from the Hyprmoni Nix palette.
     */

    :root {
      /* Hyprmoni palette */
      --hyprmoni-void: ${palette.void};
      --hyprmoni-panel: ${palette.panel};
      --hyprmoni-wine: ${palette.wine};
      --hyprmoni-wine-dark: ${palette.wineDark};
      --hyprmoni-pink: ${palette.pink};
      --hyprmoni-hot-pink: ${palette.hotPink};
      --hyprmoni-blush: ${palette.blush};
      --hyprmoni-peach: ${palette.peach};
      --hyprmoni-muted: ${palette.muted};
      --hyprmoni-green: ${palette.green};

      /* Discord base surfaces */
      --background-primary: var(--hyprmoni-void) !important;
      --background-secondary: var(--hyprmoni-panel) !important;
      --background-secondary-alt: var(--hyprmoni-panel) !important;
      --background-tertiary: var(--hyprmoni-void) !important;
      --background-floating: var(--hyprmoni-panel) !important;
      --modal-background: var(--hyprmoni-panel) !important;
      --home-background: var(--hyprmoni-void) !important;
      --channeltextarea-background: var(--hyprmoni-panel) !important;

      /* Modern Discord background variables */
      --bg-base-primary: var(--hyprmoni-void) !important;
      --bg-base-secondary: var(--hyprmoni-panel) !important;
      --bg-base-tertiary: var(--hyprmoni-void) !important;
      --bg-surface-raised: var(--hyprmoni-panel) !important;
      --bg-surface-overlay: var(--hyprmoni-panel) !important;
      --bg-mod-faint: var(--hyprmoni-wine-dark) !important;

      /* Text */
      --text-normal: var(--hyprmoni-blush) !important;
      --text-muted: var(--hyprmoni-muted) !important;
      --text-link: var(--hyprmoni-peach) !important;
      --header-primary: var(--hyprmoni-blush) !important;
      --header-secondary: var(--hyprmoni-muted) !important;
      --interactive-normal: var(--hyprmoni-blush) !important;
      --interactive-hover: var(--hyprmoni-hot-pink) !important;
      --interactive-active: var(--hyprmoni-pink) !important;
      --interactive-muted: var(--hyprmoni-wine) !important;

      /* Accents / statuses */
      --brand-experiment: var(--hyprmoni-pink) !important;
      --brand-500: var(--hyprmoni-pink) !important;
      --brand-560: var(--hyprmoni-hot-pink) !important;
      --focus-primary: var(--hyprmoni-hot-pink) !important;
      --status-positive: #4f8a68 !important;
      --status-warning: var(--hyprmoni-peach) !important;
      --status-danger: var(--hyprmoni-hot-pink) !important;
      --status-danger-background: var(--hyprmoni-wine-dark) !important;

      /* Discord mention / hover surfaces */
      --background-mentioned: color-mix(in srgb, var(--hyprmoni-pink) 14%, transparent) !important;
      --background-mentioned-hover: color-mix(in srgb, var(--hyprmoni-pink) 20%, transparent) !important;
      --background-message-hover: color-mix(in srgb, var(--hyprmoni-panel) 88%, var(--hyprmoni-pink)) !important;
      --background-modifier-hover: color-mix(in srgb, var(--hyprmoni-pink) 12%, transparent) !important;
      --background-modifier-active: color-mix(in srgb, var(--hyprmoni-pink) 18%, transparent) !important;
      --background-modifier-selected: color-mix(in srgb, var(--hyprmoni-pink) 24%, transparent) !important;
      --background-modifier-accent: var(--hyprmoni-wine) !important;

      /* Font */
      --font-primary: "Mali", "AdwaitaMono Nerd Font", sans-serif !important;
      --font-display: "Mali", "AdwaitaMono Nerd Font", sans-serif !important;
      --font-code: "AdwaitaMono Nerd Font", monospace !important;
    }

    * {
      font-family: "Mali", "AdwaitaMono Nerd Font", sans-serif !important;
    }

    /* Keep the overall Discord silhouette close to Hyprmoni */
    body,
    #app-mount {
      background: var(--hyprmoni-void) !important;
      color: var(--hyprmoni-blush) !important;
    }

    /* Server rail */
    nav[aria-label="Servers sidebar"] {
      background: var(--hyprmoni-void) !important;
      border-right: 1px solid var(--hyprmoni-wine) !important;
    }

    /* Server icons */
    [class*="guilds"] {
      background: var(--hyprmoni-void) !important;
    }

    [class*="listItem"] [class*="wrapper"] {
      border-radius: 8px !important;
    }

    [class*="listItem"] [class*="wrapper"]:hover,
    [class*="listItem"] [class*="wrapper"][class*="selected"] {
      background: var(--hyprmoni-pink) !important;
    }

    /* DM / channel sidebar */
    [class*="sidebar"] {
      background: var(--hyprmoni-panel) !important;
      border-right: 1px solid var(--hyprmoni-wine) !important;
    }

    [class*="containerDefault_"],
    [class*="wrapperDefault_"] {
      border-radius: 0 !important;
    }

    [class*="modeSelected"] {
      background: var(--hyprmoni-wine-dark) !important;
    }

    [class*="modeSelected"] [class*="name"] {
      color: var(--hyprmoni-blush) !important;
    }

    [class*="modeSelected"] [class*="icon"] {
      color: var(--hyprmoni-hot-pink) !important;
    }

    [class*="modeUnread"] [class*="name"] {
      color: var(--hyprmoni-peach) !important;
    }

    /* Main content */
    main[class*="chatContent"],
    [class*="chat"],
    [class*="content"] {
      background: var(--hyprmoni-void) !important;
    }

    /* Top bars */
    [class*="title"],
    [class*="headerBar"] {
      background: var(--hyprmoni-panel) !important;
      border-bottom: 1px solid var(--hyprmoni-wine) !important;
    }

    /* Message list */
    [class*="messageList"] {
      background: var(--hyprmoni-void) !important;
    }

    [class*="message"] {
      color: var(--hyprmoni-blush) !important;
    }

    [class*="message"]:hover {
      background: color-mix(in srgb, var(--hyprmoni-panel) 88%, var(--hyprmoni-pink)) !important;
    }

    [class*="cozy"] [class*="username"] {
      color: var(--hyprmoni-peach) !important;
    }

    [class*="timestamp"] {
      color: var(--hyprmoni-muted) !important;
    }

    /* Links */
    a {
      color: var(--hyprmoni-peach) !important;
    }

    a:hover {
      color: var(--hyprmoni-hot-pink) !important;
    }

    /* Composer */
    [class*="channelTextArea"] {
      background: var(--hyprmoni-panel) !important;
      border: 1px solid var(--hyprmoni-wine) !important;
    }

    [class*="channelTextArea"]:focus-within {
      border-color: var(--hyprmoni-pink) !important;
      box-shadow: 0 0 0 1px var(--hyprmoni-pink) !important;
    }

    /* Buttons */
    button {
      color: var(--hyprmoni-blush) !important;
    }

    button:hover {
      color: var(--hyprmoni-hot-pink) !important;
    }

    [class*="lookFilled"][class*="colorBrand"],
    [class*="lookFilled"][class*="colorPrimary"] {
      background: var(--hyprmoni-pink) !important;
      color: var(--hyprmoni-void) !important;
    }

    [class*="lookFilled"][class*="colorBrand"]:hover,
    [class*="lookFilled"][class*="colorPrimary"]:hover {
      background: var(--hyprmoni-hot-pink) !important;
    }

    /* Mentions / replies */
    [class*="mentioned"] {
      background: color-mix(in srgb, var(--hyprmoni-pink) 14%, transparent) !important;
      border-left: 2px solid var(--hyprmoni-pink) !important;
    }

    /* User list / members */
    aside {
      background: var(--hyprmoni-panel) !important;
      border-left: 1px solid var(--hyprmoni-wine) !important;
    }

    /* Popouts / menus / modals */
    [role="dialog"],
    [role="menu"],
    [class*="popout"],
    [class*="menu"] {
      background: var(--hyprmoni-panel) !important;
      color: var(--hyprmoni-blush) !important;
      border-color: var(--hyprmoni-wine) !important;
    }

    [role="menuitem"]:hover {
      background: var(--hyprmoni-wine-dark) !important;
      color: var(--hyprmoni-blush) !important;
    }

    /* Search */
    [class*="searchBar"] {
      background: var(--hyprmoni-void) !important;
      border: 1px solid var(--hyprmoni-wine) !important;
    }

    [class*="searchBar"]:focus-within {
      border-color: var(--hyprmoni-pink) !important;
    }

    /* Scrollbars */
    ::-webkit-scrollbar {
      width: 8px !important;
      height: 8px !important;
    }

    ::-webkit-scrollbar-track {
      background: var(--hyprmoni-void) !important;
    }

    ::-webkit-scrollbar-thumb {
      background: var(--hyprmoni-wine) !important;
      border-radius: 0 !important;
      border: 2px solid var(--hyprmoni-void) !important;
    }

    ::-webkit-scrollbar-thumb:hover {
      background: var(--hyprmoni-pink) !important;
    }

    /* Selection */
    ::selection {
      background: var(--hyprmoni-pink) !important;
      color: var(--hyprmoni-void) !important;
    }

    /* Inputs */
    input,
    textarea {
      color: var(--hyprmoni-blush) !important;
    }

    input::placeholder,
    textarea::placeholder {
      color: var(--hyprmoni-muted) !important;
    }

    /* Vencord settings UI */
    [class*="vc-"],
    [class*="vc_"] {
      --brand-experiment: var(--hyprmoni-pink) !important;
    }
  '';

  activationScript = pkgs.writeShellScript "vesktop-hyprmoni-activate" ''
    set -euo pipefail

    config_dir="''${XDG_CONFIG_HOME:-$HOME/.config}/vesktop"
    settings_dir="$config_dir/settings"
    themes_dir="$config_dir/themes"
    settings_file="$settings_dir/settings.json"
    theme_file="$themes_dir/hyprmoni.theme.css"

    mkdir -p "$settings_dir" "$themes_dir"

    install -m 0644 ${hyprmoniTheme} "$theme_file"

    if [ ! -f "$settings_file" ]; then
      cat > "$settings_file" <<'EOF'
    {
      "useQuickCss": true,
      "enabledThemes": ["hyprmoni.theme.css"]
    }
    EOF
    else
      ${pkgs.jq}/bin/jq \
        '.useQuickCss = true | .enabledThemes = ((.enabledThemes // []) + ["hyprmoni.theme.css"] | unique)' \
        "$settings_file" > "$settings_file.tmp"
      mv "$settings_file.tmp" "$settings_file"
    fi
  '';
in
{
  home.packages = [
    pkgs.vesktop
  ];

  xdg.configFile."vesktop/settings/quickCss.css".text = ''
    /*
     * Hyprmoni keeps its actual theme in the generated local theme file.
     * This file only exists so Vencord's QuickCSS feature is enabled
     * declaratively without putting a giant mutable CSS blob in settings.
     */
  '';

  home.activation.vesktopHyprmoni = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ${activationScript}
  '';
}
