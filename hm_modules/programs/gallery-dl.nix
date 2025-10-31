# gl-dl.nix
{ pkgs, config, ... }:

{
  programs.gallery-dl = {
    enable = false;
  };

  xdg.configFile."gallery-dl/config.json".text = ''
    {
      "cache": {
        "file": "~/gallery-dl/cache.sqlite3"
      },
      "extractor": {
        "base-directory": "~/gallery-dl/",
        "pixiv": {
          "directory": [
            "{category}",
            "{user[id]}_{user[account]}",
            "{series[id]}_{series[title]}",
            "{num_series:>03}.{title}"
          ],
          "filename": "{id}_p{num}.{extension}",
          "refresh-token": "placeholder"
        }
      }
    }
  '';
}

