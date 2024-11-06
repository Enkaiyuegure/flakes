{
  pkgs,
  myVars,
  nuenv,
  nixpkgs,
  flake-registry,
  lib,
  ...
} @ args: {
  nixpkgs.overlays =
    [
      nuenv.overlays.default
    ];

  # auto upgrade nix to the unstable version
  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/tools/package-management/nix/default.nix#L284
  # nix.package = pkgs.nixVersions.latest;
  # nix.package = pkgs.nixVersions.nix_2_22;

  environment.systemPackages = with pkgs; [
    vim # basic editor

    git # used by nix flakes
    git-lfs # used by huggingface models

    # archives
    zip
    xz
    zstd
    unzipNLS
    p7zip

    # Text Processing
    # Docs: https://github.com/learnbyexample/Command-line-text-processing
    gnugrep # GNU grep, provides `grep`/`egrep`/`fgrep`
    gnused # GNU sed, very powerful(mainly for replacing text in files)
    gawk # GNU awk, a pattern scanning and processing language
    jq # A lightweight and flexible command-line JSON processor

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    wget
    curl
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

    # misc
    file
    findutils
    which
    tree
    gnutar
    rsync
  ];

  users.users.${myVars.username} = {
    description = myVars.userFullName;
    openssh.authorizedKeys.keys = myVars.sshAuthorizedKeys;
  };

  nix = {
    channel.enable = true;

    # make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
    # discard all the default paths, and only use the one from this flake.
    nixPath = lib.mkForce [ "nixpkgs=${nixpkgs}" ];
    settings = {

      # https://github.com/NixOS/nix/issues/9574
      nix-path = lib.mkForce "nixpkgs=flake:nixpkgs";

      # enable flakes globally
      experimental-features = [ "nix-command" "flakes" "auto-allocate-uids" "cgroups" ];
      auto-allocate-uids = true;
      use-cgroups = true;
      auto-optimise-store = true; # Optimise syslinks
      accept-flake-config = false;
      flake-registry = "${flake-registry}/flake-registry.json";
      builders-use-substitutes = true;
      keep-derivations = true;
      keep-outputs = true;

      # substituers that will be considered before the official ones(https://cache.nixos.org)
      substituters = [
        # cache mirror located in China
        # status: https://mirrors.ustc.edu.cn/status/
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        # status: https://mirror.sjtu.edu.cn/
        "https://mirror.sjtu.edu.cn/nix-channels/store"

        "https://nix-community.cachix.org"
        # cuda-maintainer's cache server
        "https://cuda-maintainers.cachix.org"
        "https://cache.saumon.network/proxmox-nixos"
        "https://nix-gaming.cachix.org"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        "proxmox-nixos:nveXDuVVhFDRFx8Dn19f1WDEaNRJjPrF2CPD2D+m1ys="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      ];

      # given the users in this list the right to specify additional substituters via:
      #    1. `nixConfig.substituers` in `flake.nix`
      #    2. command line args `--options substituers http://xxx`
      trusted-users = [ "root" "@wheel" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };

  # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
    registry.nixpkgs.flake = nixpkgs;
    extraOptions = ''
      keep-outputs            = true
      keep-derivations        = true
    '';
  };

  environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
}
