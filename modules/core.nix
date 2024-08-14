{ pkgs, userName, ... }:
{
  networking = {
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 5173 1420 3128 1080 ];
    hosts = {
      "185.199.109.133" = [ "raw.githubusercontent.com" ];
      "185.199.111.133" = [ "raw.githubusercontent.com" ];
      "185.199.110.133" = [ "raw.githubusercontent.com" ];
      "185.199.108.133" = [ "raw.githubusercontent.com" ];
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = false; # disable password login
    };
    openFirewall = true;
  };

  time.timeZone = "Asia/Shanghai";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ALL = "en_US.UTF-8";
      LANGUAGE = "en_US.UTF-8";
    };
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "C.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
      "zh_TW.UTF-8/UTF-8"
    ];
  };

  security.rtkit.enable = true;

  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    shells = with pkgs; [ fish ];
    systemPackages = with pkgs; [
      gcc
      clang
      git
      gdb
      neovim
      wget
      fastfetch
      eza
      p7zip
      atool
      unzip
      zip
      rar
      ffmpeg
      xdg-utils
      pciutils
      killall
      socat
    ];
  };

  services.dbus.enable = true;

  users.mutableUsers = false;
  programs.fish.enable = true;
  users.users.${userName} = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" ];
    packages = with pkgs; [
      firefox
      tree
    ];
  };

  security.polkit.enable = true;
  security.sudo = {
    enable = true;
    extraConfig = ''
      ${userName} ALL=(ALL) NOPASSWD:ALL
    '';
  };
  security.doas = {
    enable = true;
    extraConfig = ''
      permit nopass :wheel
    '';
  };
}
