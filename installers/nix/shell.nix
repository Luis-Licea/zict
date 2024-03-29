# vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab filetype=nix
# Run nix-shell to activate this environment in NixOS.
{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  name = "Zict Development Shell";
  buildInputs = with pkgs; [
    xdg-user-dirs
    bash
    gnused
    coreutils
    zim-tools
    curl
  ];
}
