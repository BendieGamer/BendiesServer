{ pkgs }: {
  deps = [
    pkgs.tmux
    pkgs.temurin-jre-bin
    pkgs.caddy
    pkgs.bashInteractive
    pkgs.nodePackages.bash-language-server
    pkgs.man
    pkgs.jre8
  ];
}