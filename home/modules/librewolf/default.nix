{ config, pkgs, ... }:

{
  programs.librewolf = {
    enable = true;
    
    # Generate Profile Configurations
    profiles = {
      # Profile "paçoca": Persistent session and cookies
      pacoca = {
        id = 0;
        name = "paçoca";
        settings = {
          "browser.startup.homepage" = "https://www.startpage.com/";
          "privacy.resistFingerprinting" = true;
          "privacy.clearOnShutdown.history" = false;
          "privacy.clearOnShutdown.cookies" = false;
          "privacy.clearOnShutdown.sessions" = false;
          "privacy.sanitize.sanitizeOnShutdown" = false;
          "network.cookie.lifetimePolicy" = 0;
          "browser.sessionstore.resume_from_crash" = true;
        };
      };

      # Profile "bks": Persistent session and cookies
      bks = {
        id = 1;
        name = "bks";
        settings = {
          "browser.startup.homepage" = "https://www.startpage.com/";
          "privacy.resistFingerprinting" = true;
          "privacy.clearOnShutdown.history" = false;
          "privacy.clearOnShutdown.cookies" = false;
          "privacy.clearOnShutdown.sessions" = false;
          "privacy.sanitize.sanitizeOnShutdown" = false;
          "network.cookie.lifetimePolicy" = 0;
          "browser.sessionstore.resume_from_crash" = true;
        };
      };

      # Profile "fa": Hardened privacy (clears everything on shutdown)
      fa = {
        id = 2;
        name = "fa";
        settings = {
          "browser.startup.homepage" = "https://www.startpage.com/";
          "privacy.resistFingerprinting" = true;
          # Standard LibreWolf behavior: wipe everything when closed
          "privacy.clearOnShutdown.history" = true;
          "privacy.clearOnShutdown.cookies" = true;
          "privacy.sanitize.sanitizeOnShutdown" = true;
        };
      };
    };
  };

  # Custom .desktop file to force the Profile Manager on startup
  # This integrates with launchers like Wofi
  home.file.".local/share/applications/librewolf.desktop" = {
    text = ''
      [Desktop Entry]
      Name=LibreWolf
      Exec=librewolf -P
      Icon=librewolf
      Type=Application
      Terminal=false
      Categories=Network;WebBrowser;
    '';
    force = true;
  };
}
