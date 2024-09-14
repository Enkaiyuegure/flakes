{ lib }: {
  userName = "enkai";
  userFullname = "Enkaiyuegure";
  userEmail = "enkaiyuegure@outlook.com";
  networking = import ./networking.nix { inherit lib; };
  # Public Keys that can be used to login to all my PCs, and servers.
  #
  # Since its authority is so large, we must strengthen its security:
  # 1. The corresponding private key must be:
  #    1. Generated locally on every trusted client via:
  #      ```bash
  #      # KDF: bcrypt with 256 rounds, takes 2s on Apple M2):
  #      # Passphrase: digits + letters + symbols, 12+ chars
  #      ssh-keygen -t ed25519 -a 256 -C "enkai@xxx" -f ~/.ssh/xxx`
  #      ```
  #    2. Never leave the device and never sent over the network.
  # 2. Or just use hardware security keys like Yubikey/CanoKey.
  sshAuthorizedKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE7+CvR7E+SBRqyrDnpjM5VzbYJssQXCiP4araLoKbiG enkai@zbook"
  ];
}
