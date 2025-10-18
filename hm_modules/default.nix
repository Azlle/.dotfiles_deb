# default.nix
{ ... }:

{
  imports = [
    ./.config
    ./programs
    ./zatta.nix
  ];
}
