# Hosts

1. `dashao`: 
  - Which means "大韶", a significant piece of ritual music from the ancient Zhou Dynasty in China.
  - My main desktop, R7 7840hs, 64GiB, 2TiB(raid1)
  - HP Zbook Power 15.6 inch G10 A

## How to add a new host

1. Under `hosts/`
   1. Create a new folder under `hosts/` with the name of the new host.
   2. Create & add the new host's `hardware-configuration.nix` to the new folder, and add the new
      host's `configuration.nix` to `hosts/<name>/default.nix`.
   3. If the new host need to use home-manager, add its custom config into `hosts/<name>/home.nix`.
1. Under `outputs/`
   1. Add a new nix file named `outputs/<system-architecture>/src/<name>.nix`.
   2. Copy the content from one of the existing similar host, and modify it to fit the new host.
      1. Usually, you only need to modify the `name` and `tags` fields.
   3. [Optional] Add a new unit test file under `outputs/<system-architecture>/tests/<name>.nix` to
      test the new host's nix file.
   4. [Optional] Add a new integration test file under
      `outputs/<system-architecture>/integration-tests/<name>.nix` to test whether the new host's
      nix config can be built and deployed correctly.
1. Under `vars/networking.nix`
   1. Add the new host's static IP address.
   1. Skip this step if the new host is not in the local network or is a mobile device.

