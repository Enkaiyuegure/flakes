{pkgs, ...}: {
  home.packages = with pkgs; [
    mitmproxy # http/https proxy tool
    insomnia # REST client
    wireshark # network analyzer
  ] ++ (with pkgs.jetbrains; [
      # IDEs
      idea-ultimate
      clion
      rust-rover
      goland
      pycharm-professional
      webstorm
      phpstorm
  ]);
}
