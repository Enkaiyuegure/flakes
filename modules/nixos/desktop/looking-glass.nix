{ myVars, pkgs, ... }:
let
  inherit (myVars) username;
in
{
  # Add a file for looking-glass to use later. This will allow for viewing the guest VM's screen in a
  # performant way.
  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 ${username} qemu-libvirtd -"
  ];

  # Add virt-manager and looking-glass to use later.
  environment.systemPackages = with pkgs; [
    looking-glass-client
  ];
}
