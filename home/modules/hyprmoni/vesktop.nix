{ lib, ... }:

let
  palette = import ./palette.nix;

  /*
   * Discord's 2025+ Visual Refresh does not get all of its UI colors from
   * the older --background-* variables. A large amount of the gray UI is
   * produced from the --neutral-N-hsl scale.
   *
   * Vencord's own ClientTheme plugin detects those --neutral-N-hsl variables
   * and recolors the Visual Refresh by changing their hue/saturation while
   * preserving their lightness offsets.
   *
   * We do the same thing here, but with a deliberately Hyprmoni-specific
   * dark scale instead of Discord's gray scale.
   */

  /*
   * 1..58: light/mid neutral levels, mostly used by text, overlays and
   * secondary UI.
   *
   * 59..69: the actual dark UI surface scale.
   *
   * 70..100: deepest surfaces, separators and black-adjacent values.
   */
  neutralLightness = i:
    if i <= 58 then
      98.0 - ((i - 1) * 1.20)
    else if i <= 69 then
      11.0 - ((i - 59) * 0.59)
    else
      lib.max 1.2 (5.1 - ((i - 69) * 0.09));

  neutralSaturation = i:
    if i <= 58 then 18
    else if i <= 69 then 14
    else 12;

  neutralVars = lib.concatStringsSep "\n" (
    map
      (i:
        ''
          --neutral-${toString i}-hsl: 333 ${toString (neutralSaturation i)}% ${toString (neutralLightness i)}% !important;
          --neutral-${toString i}: hsl(var(--neutral-${toString i}-hsl) / 1) !important;
        '')
      (lib.range 1 100)
  );
in
{
  programs.vesktop = {
    enable = true;

    vencord = {
      themes."hyprmoni.theme.css" = ''
        /**
         * Hyprmoni Vesktop Theme
         *
         * This theme is intentionally written around Discord's current
         * Visual Refresh design-token system rather than relying only on
         * old Discord class names.
         *
         * Hyprmoni palette:
         *   void      ${palette.void}
         *   panel     ${palette.panel}
         *   wine      ${palette.wine}
         *   wineDark  ${palette.wineDark}
         *   pink      ${palette.pink}
         *   hotPink   ${palette.hotPink}
         *   blush     ${palette.blush}
         *   peach     ${palette.peach}
         *   muted     ${palette.muted}
         *   green     ${palette.green}
         */

        /* ================================================================
         * HYPRMONI PALETTE
         * ================================================================ */

        :root,
        .theme-dark,
        .theme-light {
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

          /* Force Discord's Visual Refresh neutral scale away from gray. */
          ${neutralVars}

          /* ==============================================================
           * DISCORD SURFACE TOKENS
           * ============================================================== */

          --background-primary: var(--hyprmoni-void) !important;
          --background-secondary: var(--hyprmoni-panel) !important;
          --background-secondary-alt: var(--hyprmoni-panel) !important;
          --background-tertiary: var(--hyprmoni-void) !important;
          --background-floating: var(--hyprmoni-panel) !important;

          --background-base-lowest: var(--hyprmoni-void) !important;
          --background-base-lower: var(--hyprmoni-void) !important;
          --background-base-low: var(--hyprmoni-panel) !important;
          --background-base-tertiary: var(--hyprmoni-void) !important;
          --background-base-secondary: var(--hyprmoni-panel) !important;
          --background-base-primary: var(--hyprmoni-void) !important;

          --bg-base-primary: var(--hyprmoni-void) !important;
          --bg-base-secondary: var(--hyprmoni-panel) !important;
          --bg-base-tertiary: var(--hyprmoni-void) !important;

          --bg-surface-underlay: var(--hyprmoni-void) !important;
          --bg-surface-base: var(--hyprmoni-void) !important;
          --bg-surface-low: var(--hyprmoni-void) !important;
          --bg-surface-lowest: var(--hyprmoni-void) !important;
          --bg-surface-raised: var(--hyprmoni-panel) !important;
          --bg-surface-overlay: var(--hyprmoni-panel) !important;
          --bg-surface-high: var(--hyprmoni-panel) !important;
          --bg-surface-highest: var(--hyprmoni-panel) !important;

          --background-surface-high: var(--hyprmoni-panel) !important;
          --background-surface-highest: var(--hyprmoni-panel) !important;

          --channeltextarea-background: var(--hyprmoni-panel) !important;
          --chat-background: var(--hyprmoni-void) !important;
          --home-background: var(--hyprmoni-void) !important;

          --card-primary-bg: var(--hyprmoni-panel) !important;
          --card-secondary-bg: var(--hyprmoni-panel) !important;
          --card-primary-pressed-bg: var(--hyprmoni-wine-dark) !important;
          --card-secondary-pressed-bg: var(--hyprmoni-wine-dark) !important;

          --deprecated-card-bg: var(--hyprmoni-panel) !important;
          --deprecated-text-input-bg: var(--hyprmoni-void) !important;

          /* ==============================================================
           * BORDERS
           * ============================================================== */

          --border-subtle: var(--hyprmoni-wine) !important;
          --border-normal: var(--hyprmoni-wine) !important;
          --border-strong: var(--hyprmoni-pink) !important;
          --border-muted: var(--hyprmoni-wine-dark) !important;
          --border-focus: var(--hyprmoni-hot-pink) !important;

          --input-border-default: var(--hyprmoni-wine) !important;
          --input-border-hover: var(--hyprmoni-pink) !important;
          --input-border-focus: var(--hyprmoni-hot-pink) !important;

          --chat-border: var(--hyprmoni-wine) !important;
          --background-modifier-accent: var(--hyprmoni-wine) !important;

          /* ==============================================================
           * INTERACTIONS
           * ============================================================== */

          --background-modifier-hover: color-mix(
            in srgb,
            var(--hyprmoni-pink) 10%,
            transparent
          ) !important;

          --background-modifier-active: color-mix(
            in srgb,
            var(--hyprmoni-pink) 17%,
            transparent
          ) !important;

          --background-modifier-selected: color-mix(
            in srgb,
            var(--hyprmoni-pink) 22%,
            transparent
          ) !important;

          --background-mentioned: color-mix(
            in srgb,
            var(--hyprmoni-pink) 13%,
            transparent
          ) !important;

          --background-mentioned-hover: color-mix(
            in srgb,
            var(--hyprmoni-pink) 18%,
            transparent
          ) !important;

          --background-message-hover: color-mix(
            in srgb,
            var(--hyprmoni-panel) 88%,
            var(--hyprmoni-pink)
          ) !important;

          --bg-mod-faint: var(--hyprmoni-wine-dark) !important;
          --bg-mod-subtle: var(--hyprmoni-wine-dark) !important;
          --bg-mod-normal: var(--hyprmoni-wine) !important;
          --bg-mod-strong: var(--hyprmoni-wine) !important;

          /* ==============================================================
           * BUTTON / CONTROL TOKENS
           * ============================================================== */

          --button-secondary-background: var(--hyprmoni-panel) !important;
          --button-secondary-background-hover: var(--hyprmoni-wine-dark) !important;
          --button-secondary-background-active: var(--hyprmoni-wine) !important;
          --button-secondary-text: var(--hyprmoni-blush) !important;

          --control-secondary-background-default: var(--hyprmoni-panel) !important;
          --control-secondary-background-hover: var(--hyprmoni-wine-dark) !important;
          --control-secondary-background-active: var(--hyprmoni-wine) !important;
          --control-secondary-background-disabled: var(--hyprmoni-void) !important;

          --control-secondary-border-default: var(--hyprmoni-wine) !important;
          --control-secondary-border-hover: var(--hyprmoni-pink) !important;
          --control-secondary-border-active: var(--hyprmoni-hot-pink) !important;

          --control-secondary-text-default: var(--hyprmoni-blush) !important;
          --control-secondary-text-hover: var(--hyprmoni-hot-pink) !important;
          --control-secondary-text-active: var(--hyprmoni-blush) !important;

          --control-primary-background-default: var(--hyprmoni-pink) !important;
          --control-primary-background-hover: var(--hyprmoni-hot-pink) !important;
          --control-primary-background-active: var(--hyprmoni-wine) !important;

          --control-primary-border-default: var(--hyprmoni-pink) !important;
          --control-primary-border-hover: var(--hyprmoni-hot-pink) !important;
          --control-primary-border-active: var(--hyprmoni-pink) !important;

          --control-primary-text-default: var(--hyprmoni-void) !important;
          --control-primary-text-hover: var(--hyprmoni-void) !important;
          --control-primary-text-active: var(--hyprmoni-blush) !important;

          --control-critical-primary-background-default: var(--hyprmoni-hot-pink) !important;
          --control-critical-primary-background-hover: var(--hyprmoni-pink) !important;
          --control-critical-primary-text-default: var(--hyprmoni-void) !important;

          --control-connected-background-default: var(--hyprmoni-green) !important;
          --control-connected-background-hover: var(--hyprmoni-wine-dark) !important;

          --control-icon-only-background-hover: var(--hyprmoni-wine-dark) !important;
          --control-icon-only-background-active: var(--hyprmoni-wine) !important;
          --control-icon-only-border-hover: var(--hyprmoni-pink) !important;
          --control-icon-only-border-active: var(--hyprmoni-hot-pink) !important;
          --control-icon-only-icon-default: var(--hyprmoni-muted) !important;
          --control-icon-only-icon-hover: var(--hyprmoni-blush) !important;

          --button-filled-brand-background: var(--hyprmoni-pink) !important;
          --button-filled-brand-background-hover: var(--hyprmoni-hot-pink) !important;
          --button-filled-brand-text: var(--hyprmoni-void) !important;

          /* ==============================================================
           * BRAND
           * ============================================================== */

          --brand-500: var(--hyprmoni-pink) !important;
          --brand-560: var(--hyprmoni-hot-pink) !important;
          --brand-experiment: var(--hyprmoni-pink) !important;
          --control-brand-foreground: var(--hyprmoni-pink) !important;
          --control-brand-foreground-new: var(--hyprmoni-pink) !important;
          --focus-primary: var(--hyprmoni-hot-pink) !important;

          /* ==============================================================
           * TEXT / ICONS
           * ============================================================== */

          --text-default: var(--hyprmoni-blush) !important;
          --text-normal: var(--hyprmoni-blush) !important;
          --text-strong: var(--hyprmoni-blush) !important;
          --text-subtle: var(--hyprmoni-muted) !important;
          --text-muted: var(--hyprmoni-muted) !important;
          --text-link: var(--hyprmoni-peach) !important;
          --text-brand: var(--hyprmoni-pink) !important;

          --header-primary: var(--hyprmoni-blush) !important;
          --header-secondary: var(--hyprmoni-muted) !important;

          --interactive-normal: var(--hyprmoni-blush) !important;
          --interactive-hover: var(--hyprmoni-hot-pink) !important;
          --interactive-active: var(--hyprmoni-pink) !important;
          --interactive-muted: var(--hyprmoni-muted) !important;

          --icon-primary: var(--hyprmoni-blush) !important;
          --icon-secondary: var(--hyprmoni-muted) !important;
          --icon-tertiary: var(--hyprmoni-muted) !important;
          --icon-muted: var(--hyprmoni-muted) !important;
          --icon-brand: var(--hyprmoni-pink) !important;

          --channels-default: var(--hyprmoni-muted) !important;
          --channel-icon: var(--hyprmoni-muted) !important;

          /* ==============================================================
           * RADIUS
           *
           * Discord's newest UI has hard-coded radii in some components,
           * so variables alone are not enough. Explicit selectors below
           * finish the square/clean Hyprmoni look.
           * ============================================================== */

          --radius-xxs: 0px !important;
          --radius-xs: 0px !important;
          --radius-sm: 0px !important;
          --radius-md: 0px !important;
          --radius-lg: 0px !important;
          --radius-xl: 0px !important;
          --radius-primary: 0px !important;
          --radius-secondary: 0px !important;
        }

        /* ================================================================
         * HARD RESET OF DISCORD VISUAL-REFRESH GRAY SURFACES
         * ================================================================ */

        body,
        #app-mount,
        [class*="appMount"],
        [class*="app_"],
        [class*="base_"],
        [class*="bg_"] {
          background: var(--hyprmoni-void) !important;
          color: var(--hyprmoni-blush) !important;
        }

        [class*="guilds"] {
          background: var(--hyprmoni-void) !important;
          border-right: 1px solid var(--hyprmoni-wine) !important;
        }

        [class*="sidebar"] {
          background: var(--hyprmoni-panel) !important;
          border-right: 1px solid var(--hyprmoni-wine) !important;
        }

        [class*="contentRegion"],
        [class*="contentRegionScroller"],
        [class*="chatContent"],
        [class*="chat"] {
          background: var(--hyprmoni-void) !important;
        }

        [class*="membersWrap"],
        [class*="members"] {
          background: var(--hyprmoni-panel) !important;
        }

        [class*="panels"] {
          background: var(--hyprmoni-panel) !important;
          border-top: 1px solid var(--hyprmoni-wine) !important;
          border-radius: 0 !important;
        }

        /* ================================================================
         * FRIENDS / HOME
         * ================================================================ */

        [class*="tabBody"],
        [class*="peopleColumn"],
        [class*="peopleList"],
        [class*="nowPlayingColumn"],
        [class*="friendsTable"] {
          background: var(--hyprmoni-void) !important;
        }

        [class*="tabBar"] {
          background: var(--hyprmoni-panel) !important;
          border-bottom: 1px solid var(--hyprmoni-wine) !important;
          border-radius: 0 !important;
        }

        [class*="tabBar"] [class*="item"] {
          background: transparent !important;
          color: var(--hyprmoni-muted) !important;
          border-radius: 0 !important;
          box-shadow: none !important;
        }

        [class*="tabBar"] [class*="item"]:hover {
          background: var(--hyprmoni-wine-dark) !important;
          color: var(--hyprmoni-blush) !important;
          border-radius: 0 !important;
        }

        [class*="tabBar"] [class*="item"][class*="selected"],
        [class*="tabBar"] [class*="item"][class*="active"],
        [role="tab"][aria-selected="true"] {
          background: var(--hyprmoni-wine-dark) !important;
          color: var(--hyprmoni-blush) !important;
          border-radius: 0 !important;
          border-bottom: 2px solid var(--hyprmoni-pink) !important;
          box-shadow: none !important;
        }

        /* The "Online" / "Add Friend" style controls visible in Home. */
        [class*="friend"] button,
        [class*="friends"] button,
        [class*="people"] button {
          border-radius: 0 !important;
        }

        [class*="friends"] [class*="selected"],
        [class*="friends"] [class*="active"] {
          border-radius: 0 !important;
          background: var(--hyprmoni-wine-dark) !important;
        }

        /* ================================================================
         * ACTIVE NOW CARDS
         * ================================================================ */

        [class*="nowPlayingColumn"] [class*="item"],
        [class*="nowPlayingColumn"] [class*="card"],
        [class*="nowPlayingColumn"] [class*="container"],
        [class*="activeNow"],
        [class*="activity"] {
          background: var(--hyprmoni-panel) !important;
          border-color: var(--hyprmoni-wine) !important;
          border-radius: 0 !important;
          box-shadow: none !important;
        }

        /* ================================================================
         * SEARCH
         * ================================================================ */

        [class*="searchBar"],
        [class*="searchBox"],
        [class*="searchPage"],
        [class*="searchResult"] {
          background: var(--hyprmoni-void) !important;
          border: 1px solid var(--hyprmoni-wine) !important;
          border-radius: 0 !important;
          box-shadow: none !important;
        }

        [class*="searchBar"]:focus-within,
        [class*="searchBox"]:focus-within {
          border-color: var(--hyprmoni-pink) !important;
          box-shadow: 0 0 0 1px var(--hyprmoni-pink) !important;
        }

        /* ================================================================
         * INPUTS / COMPOSER
         * ================================================================ */

        input,
        textarea,
        [role="textbox"] {
          background: var(--hyprmoni-void) !important;
          color: var(--hyprmoni-blush) !important;
          border-color: var(--hyprmoni-wine) !important;
          border-radius: 0 !important;
          box-shadow: none !important;
        }

        input:focus,
        textarea:focus,
        [role="textbox"]:focus {
          border-color: var(--hyprmoni-pink) !important;
          outline: none !important;
        }

        input::placeholder,
        textarea::placeholder {
          color: var(--hyprmoni-muted) !important;
        }

        [class*="channelTextArea"],
        [class*="scrollableContainer"] {
          background: var(--hyprmoni-panel) !important;
          border-color: var(--hyprmoni-wine) !important;
          border-radius: 0 !important;
          box-shadow: none !important;
        }

        [class*="channelTextArea"]:focus-within {
          border-color: var(--hyprmoni-pink) !important;
        }

        /* ================================================================
         * BUTTONS
         * ================================================================ */

        button,
        [role="button"] {
          border-radius: 0 !important;
          box-shadow: none !important;
        }

        button[class*="lookFilled"][class*="colorBrand"],
        button[class*="lookFilled"][class*="colorPrimary"],
        [class*="button"][class*="brand"] {
          background: var(--hyprmoni-pink) !important;
          border: 1px solid var(--hyprmoni-pink) !important;
          color: var(--hyprmoni-void) !important;
          border-radius: 0 !important;
          box-shadow: none !important;
        }

        button[class*="lookFilled"][class*="colorBrand"]:hover,
        button[class*="lookFilled"][class*="colorPrimary"]:hover,
        [class*="button"][class*="brand"]:hover {
          background: var(--hyprmoni-hot-pink) !important;
          border-color: var(--hyprmoni-hot-pink) !important;
        }

        /* Any generic secondary button which still receives Discord gray. */
        button[class*="colorSecondary"],
        button[class*="colorGrey"],
        button[class*="colorGray"] {
          background: var(--hyprmoni-panel) !important;
          color: var(--hyprmoni-blush) !important;
          border: 1px solid var(--hyprmoni-wine) !important;
          border-radius: 0 !important;
        }

        button[class*="colorSecondary"]:hover,
        button[class*="colorGrey"]:hover,
        button[class*="colorGray"]:hover {
          background: var(--hyprmoni-wine-dark) !important;
          border-color: var(--hyprmoni-pink) !important;
        }

        /* ================================================================
         * CHANNELS / SERVER RAIL
         * ================================================================ */

        [class*="containerDefault"],
        [class*="wrapperDefault"],
        [class*="wrapperHovered"],
        [class*="wrapperSelected"],
        [class*="modeSelected"] {
          border-radius: 0 !important;
        }

        [class*="modeSelected"] {
          background: var(--hyprmoni-wine-dark) !important;
          border-left: 2px solid var(--hyprmoni-pink) !important;
        }

        [class*="modeSelected"] [class*="name"],
        [class*="modeSelected"] [class*="icon"] {
          color: var(--hyprmoni-blush) !important;
        }

        [class*="modeUnread"] [class*="name"] {
          color: var(--hyprmoni-peach) !important;
        }

        [class*="listItem"] [class*="wrapper"]:hover {
          background: var(--hyprmoni-wine-dark) !important;
          border-radius: 0 !important;
        }

        /* ================================================================
         * MESSAGES
         * ================================================================ */

        [class*="messageList"] {
          background: var(--hyprmoni-void) !important;
        }

        [class*="message"]:hover {
          background: color-mix(
            in srgb,
            var(--hyprmoni-panel) 88%,
            var(--hyprmoni-pink)
          ) !important;
        }

        [class*="message"] [class*="username"] {
          color: var(--hyprmoni-peach) !important;
        }

        [class*="timestamp"] {
          color: var(--hyprmoni-muted) !important;
        }

        /* ================================================================
         * EMBEDS / YOUTUBE / LINK PREVIEWS
         * ================================================================ */

        [class*="embed"],
        [class*="embedWrapper"],
        [class*="embedInner"],
        [class*="attachment"],
        [class*="wrapper"][class*="embed"],
        [class*="cardPrimary"],
        [class*="cardSecondary"],
        [class*="card"] {
          background: var(--hyprmoni-panel) !important;
          border-color: var(--hyprmoni-wine) !important;
          border-radius: 0 !important;
          box-shadow: none !important;
        }

        [class*="embed"] [class*="title"] {
          background: transparent !important;
          border: 0 !important;
        }

        [class*="embed"] a {
          color: var(--hyprmoni-peach) !important;
        }

        /* ================================================================
         * POPOUTS / MENUS / MODALS
         * ================================================================ */

        [role="menu"],
        [role="dialog"],
        [role="tooltip"],
        [class*="popout"],
        [class*="contextMenu"],
        [class*="menu"] {
          background: var(--hyprmoni-panel) !important;
          color: var(--hyprmoni-blush) !important;
          border: 1px solid var(--hyprmoni-wine) !important;
          border-radius: 0 !important;
          box-shadow: 0 10px 24px rgb(0 0 0 / 45%) !important;
        }

        [role="menuitem"],
        [class*="menuItem"] {
          border-radius: 0 !important;
          color: var(--hyprmoni-blush) !important;
        }

        [role="menuitem"]:hover,
        [class*="menuItem"]:hover {
          background: var(--hyprmoni-wine-dark) !important;
          color: var(--hyprmoni-blush) !important;
        }

        /* ================================================================
         * USER / PROFILE CARDS
         * ================================================================ */

        [class*="userPopout"],
        [class*="profilePopout"],
        [class*="profilePanel"],
        [class*="userProfileModal"] {
          background: var(--hyprmoni-panel) !important;
          border: 1px solid var(--hyprmoni-wine) !important;
          border-radius: 0 !important;
          box-shadow: none !important;
        }

        /* Avatars remain circular by design. */
        [class*="avatar"],
        img[class*="avatar"],
        [class*="avatarDecoration"] {
          border-radius: 50% !important;
        }

        /* ================================================================
         * VENCORD
         * ================================================================ */

        [class*="vc-"],
        [class*="vc_"] {
          --brand-experiment: var(--hyprmoni-pink) !important;
          --text-brand: var(--hyprmoni-pink) !important;
          --text-link: var(--hyprmoni-peach) !important;
        }

        .vc-btn-base,
        .vc-btn-primary,
        .vc-btn-secondary,
        .vc-text-btn-base {
          border-radius: 0 !important;
          box-shadow: none !important;
        }

        /* ================================================================
         * TEXT / LINKS / MISC
         * ================================================================ */

        a {
          color: var(--hyprmoni-peach) !important;
        }

        a:hover {
          color: var(--hyprmoni-hot-pink) !important;
        }

        ::selection {
          background: var(--hyprmoni-pink) !important;
          color: var(--hyprmoni-void) !important;
        }

        /* Discord frequently uses these as generic gray separators. */
        hr,
        [class*="divider"],
        [class*="separator"] {
          border-color: var(--hyprmoni-wine) !important;
        }

        /* Flat Hyprmoni scrollbar */
        ::-webkit-scrollbar {
          width: 8px !important;
          height: 8px !important;
        }

        ::-webkit-scrollbar-track {
          background: var(--hyprmoni-void) !important;
        }

        ::-webkit-scrollbar-thumb {
          background: var(--hyprmoni-wine) !important;
          border: 2px solid var(--hyprmoni-void) !important;
          border-radius: 0 !important;
        }

        ::-webkit-scrollbar-thumb:hover {
          background: var(--hyprmoni-pink) !important;
        }
      '';

      settings = {
        useQuickCss = true;
        enabledThemes = [ "hyprmoni.theme.css" ];
      };
    };
  };
}
