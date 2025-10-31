# yt-dlp.nix
{ ... }:

{
  programs.yt-dlp = {
    enable = false;
  };

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
