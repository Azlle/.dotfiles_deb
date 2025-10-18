# gl-dl.nix
{ pkgs, config, ... }:

{
  programs.gallery-dl = {
    enable = true;

    settings = {
      extractor = {
        base-directory = "~/gallery-dl/";
        pixiv = {
          refresh-token = "GET_YOUR_OWN_TOKEN";
          directory = [
            "{category}"
            "{user[id]}_{user[account]}"
            "{series[id]}_{series[title]}"
            "{num_series:>03}.{title}"
          ];
          filename = "{id}_p{num}.{extension}";
        };
      };

      # use a custom cache file location
      cache = {
        file = "~/gallery-dl/cache.sqlite3";
      };
    };
  };
}

