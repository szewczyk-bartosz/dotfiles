# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# For steam
#{lib, ...}:
#{
#}

{ lib, config, pkgs, ... }:
{

  ####################
  # 1 - Hardware
  ####################

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];



  ####################
  # 2 - Boot
  ####################
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = ["amdgpu"];
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        useOSProber = true;
      };
    };
  };



  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 30d";
    };
  };


  ####################
  # 3 - Networking
  ####################
  # TODO: Consider wireless connections (networkmanager might be enough but idk)
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;




  ####################
  # 4 - MPD
  ####################
  services.mpd.user = "bartosz";
  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.bartosz.uid}";
  };

  services.mpd = {
    enable = true;
    musicDirectory = "/home/bartosz/Music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
  };



  ####################
  # 5 - System Packages
  ####################
  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    brave
    firefox
    neofetch
    kitty
    clipboard-jh
    hyprpaper
    hyprpanel
    rofi-wayland
    wlroots
    git
  ];

  fonts.packages = with pkgs; [
    nerdfonts
  ];



  ####################
  # 6 - Hyprland
  ####################
  programs.hyprland.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.wlr.enable = true;







  ####################
  # 7 - Locale
  ####################
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };


  ####################
  # 8 - XServer (X)
  ####################
  # N/A



  
  ####################
  # 9 - Audio
  ####################
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };







  ####################
  # 10 - Users
  ####################
  users.users.bartosz = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
    ];
  };




  ####################
  # 11 - Acceleration
  ####################
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };



  ####################
  # 12 - Other
  ####################
  console.keyMap = "uk";
  services.printing.enable = true;

  ####################
  # 12 - Enable flakes
  ####################

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
