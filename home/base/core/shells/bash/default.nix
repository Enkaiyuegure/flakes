{
  config,
  shellAliases,
  localBin,
  goBin,
  rustBin,
  ...
}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:${localBin}:${goBin}:${rustBin}"
    '';
  };
}
