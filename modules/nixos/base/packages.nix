{pkgs, ...}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    fastfetch # due to discontinuation of neofetch, using fastfetch instead
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    just # justfile
    nushell # nushell

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    tcpdump # network sniffer
    lsof # list open files

    # ebpf related tools
    # https://github.com/bpftrace/bpftrace
    bpftrace # powerful tracing tool
    bpftop # monitor BPF programs
    bpfmon # BPF based visual packet rate monitor

    # system monitoring
    sysstat
    iotop
    iftop
    btop
    nmon
    sysbench

    # system tools
    psmisc # killall/pstree/prtstat/fuser/...
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    hdparm # for disk performance, command
    dmidecode # a tool that reads information about your system's hardware from the BIOS according to the SMBIOS/DMI standard
    parted

    # misc
    trash-cli
  ];

  # BCC - Tools for BPF-based Linux IO analysis, networking, monitoring, and more
  # https://github.com/iovisor/bcc
  programs.bcc.enable = true;

  nixpkgs.config = {
    programs.npm.npmrc = ''
      prefix = ''${HOME}/.npm-global
    '';
  };
}
