# yt-dlp.nix
{ pkgs, ... }:

let
  yt-dlp = pkgs.yt-dlp.overrideAttrs (oldAttrs: {
    version = "2025.11.12";
    src = pkgs.fetchFromGitHub {
      owner = "yt-dlp";
      repo = "yt-dlp";
      rev = "2025.11.12";
      hash = "sha256-Em8FLcCizSfvucg+KPuJyhFZ5MJ8STTjSpqaTD5xeKI=";
    };
  });
in

{
  home.packages = [ yt-dlp ];

  xdg.configFile."yt-dlp/config".text = ''
    # --cookies-from-browser firefox
    -f "bv*+ba/b"
    -o "~/Videos/%(extractor_key)s/%(uploader_id)s/%(timestamp>%Y-%m-%d_%H-%M)s_%(title)s_%(id)s.%(ext)s"
    --embed-thumbnail
    --embed-metadata
    --merge-output-format mkv
    --progress
  '';
}
