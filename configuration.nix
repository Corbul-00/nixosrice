{ config, lib, pkgs, ... }:

{

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

   nixpkgs.config.allowUnfree = true;

  #GPU SYNC
   hardware.nvidia.prime = {
     sync.enable = true;
     #I
     intelBusId= "PCI:00:02:0";
     #D
     nvidiaBusId = "PCI:01:00:0";
   };


  #Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  #Kernel

  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.extraModprobeConfig = ''
    options iwlwifi power_save=0
  '';

  boot.kernelParams = [
    "split_lock_detect=off"
  ];

  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
  };

  # Zram 
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };


  networking.hostName = "waifuroom"; 

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_GB.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "br-abnt2";
   };


  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
   services.pipewire = {
     enable = true;
     pulse.enable = true;
   };

  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.corbul = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "video" "audio" ]; # Enable ‘sudo’ for the user.

     #Fish

     shell = pkgs.fish;
     packages = with pkgs; [
       tree
     ];
   };

  programs.firefox.enable = true;
  
  fonts = {
    enableDefaultPackages = true;     # usually already true, but good to have
    fontconfig.enable     = true;     # enables font cache → very important
  };
  
  #Env-Variables 
  
  environment.variables = {
    NH_FLAKE = "/etc/nixos";
  };


  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim
    neovim
    ntfs3g
    #xfce.thunar
    kitty
    waybar
    wget
    winetricks
    wine
    wineWowPackages.staging
    protonup-ng
    protonup-qt
    protonplus
    zsh
    zsh-powerlevel10k
    zsh-autosuggestions
    meslo-lgs-nf
    git
    doas
    swww
    yazi
    btop
    cava
    cbonsai
    heroic
    mangohud
    cmatrix
    ani-cli
    mpv
    fzf
    termusic
    p7zip
    pavucontrol
    easyeffects
    hyprshot
    kdePackages.kleopatra
    waypaper
    fastfetch
    nerd-fonts.jetbrains-mono
    wofi
    networkmanagerapplet
    playerctl
    brightnessctl
    wireplumber
    gemini-cli
    discord
    imv
    termusic
    ffmpeg
    keepassxc
    protonmail-desktop
    protonvpn-gui
    (import ./home/modules/hashdating/default.nix { inherit pkgs; })
    (import ./home/modules/mybsc/default.nix { inherit pkgs; })
    kdePackages.gwenview
    stash
    librewolf
    obsidian
    direnv
    nix-direnv
    gh
    obs-studio
    libreoffice
    nix-output-monitor
    nvd
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    kdePackages.kdenlive
    teamspeak3
  ];

  #HYPRLAND_SDDM
  programs.hyprland = {
    enable = true; 
    withUWSM = true; 
  };
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
  
  #Thunar

  # Habilita o programa e sua integração no sistema
  programs.thunar.enable = true;

# Opcional: Adiciona plugins úteis (como extração de arquivos e controle de discos)
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

# Opcional, mas altamente recomendado: Suporte para lixeira, pen drives e miniaturas
services.gvfs.enable = true; # Montagem automática, lixeira e redes
services.tumbler.enable = true; # Geração de miniaturas para imagens e vídeos
  
  #NVIDIA_DO_DIABO
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true; 
    open = false;  
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  
  services.xserver.videoDrivers = [ "nvidia" ];

  #STEAM

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.steam.extraCompatPackages = with pkgs; [ proton-ge-bin ];
  programs.gamemode.enable = true;
  
  #NixHelper - NH

  programs.nh = {
    enable = true;
    flake = "/etc/nixos";

    clean.enable = true;
  };
  
  #Doas

  security.doas = {
    enable = true;
    extraRules = [{
      users = [ "corbul" ];
      keepEnv = true;
      persist = true;
    }];
 };

  #Shell
  programs.fish.enable = true;

  #Flakes experimental and direnv

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.direnv.enable = true;

  #AppImage Enable
   
  programs.appimage = {
      enable = true;
      binfmt = true;
    };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  #system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nix# Edit this configuration file to define what should be installed on
  # your system. Help is available in the configuration.nix(5) man page, on
  # https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}
