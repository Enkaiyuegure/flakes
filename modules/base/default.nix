{
  pkgs,
  myVars,
  nuenv,
  emacs-overlay,
  kickstart-nix-nvim,
  neovim-nightly-overlay,
  nixpkgs,
  lib,
  ...
} @ args: {
  nixpkgs.overlays =
    [
      nuenv.overlays.default
      #(import emacs-overlay)
      emacs-overlay.overlays.default
      kickstart-nix-nvim.overlays.default
      neovim-nightly-overlay.overlays.default
    ];

  # auto upgrade nix to the unstable version
  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/tools/package-management/nix/default.nix#L284
  # nix.package = pkgs.nixVersions.latest;
  # nix.package = pkgs.nixVersions.nix_2_22;

  environment.systemPackages = with pkgs; [
    git # used by nix flakes
    git-lfs # used by huggingface models

    # archives
    zip
    xz
    zstd
    unzipNLS
    p7zip
    rar
    unrar

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
    thefuck
  ];

  users.users.${myVars.username} = {
    description = myVars.userFullName;
    openssh.authorizedKeys.keys = myVars.sshAuthorizedKeys;
  };

  nix.settings = {
    # enable flakes globally
    experimental-features = [ "nix-command" "flakes" "auto-allocate-uids" "cgroups" ];

    # given the users in this list the right to specify additional substituters via:
    #    1. `nixConfig.substituers` in `flake.nix`
    #    2. command line args `--options substituers http://xxx`
    trusted-users = [ "root" "@wheel" ];

    # substituers that will be considered before the official ones(https://cache.nixos.org)
    substituters = [
      # cache mirror located in China
      # status: https://mirrors.ustc.edu.cn/status/
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      # status: https://mirror.sjtu.edu.cn/
      "https://mirror.sjtu.edu.cn/nix-channels/store"

      "https://nix-community.cachix.org"
      "https://pre-commit-hooks.cachix.org"
    ];

    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
    ];
    builders-use-substitutes = true;
  };

  # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
  nix.registry.nixpkgs.flake = nixpkgs;

  environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";

  # make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
  # discard all the default paths, and only use the one from this flake.
  nix.nixPath = lib.mkForce [ "nixpkgs=${nixpkgs}" ];

  # https://github.com/NixOS/nix/issues/9574
  nix.settings.nix-path = lib.mkForce "nixpkgs=flake:nixpkgs";
}
