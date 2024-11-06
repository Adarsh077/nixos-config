{ config, lib, pkgs, ... }:
let
  unstable = import <unstable> {
    config.allowUnfree = true;
  };
in
{
  imports =
    [ 
      ./hardware-configuration.nix
      ./nvidia.nix
    ];

  nixpkgs.config.allowUnfree = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  users.users.adarsh = {
    isNormalUser = true;
    description = "Adarsh";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [];
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "adarsh";

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  programs.firefox.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts=[3001];
  };


  environment.systemPackages = with pkgs; [
    vim
    curl
    google-chrome
    unstable.vscode
    brave
    git
    mongodb-compass
    unstable.discord
    postman
    docker
    deja-dup
    keepassxc
    busybox
    spotify
    stripe-cli
    nodejs
    pnpm
    screenfetch
    unstable.lmstudio
    nvidia-container-toolkit
    mongodb-tools
    cypress
    zip
    qbittorrent
  ];

  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };



  virtualisation.docker.enable = true;
  hardware.nvidia-container-toolkit.enable = true;
  system.stateVersion = "24.05"; # Did you read the comment?
}
