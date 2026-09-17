{ ... }: {
  programs = {
    # git-credential-oauth.enable = true;
    git = {
      enable = true;
      settings = {
        user = {
          name = "1101101011";
          email = "ilardecharles@gmail.com";
        };
        init.defaultBranch = "main";
        pull.rebase = true;
        credential.helper = "oauth";
      };

      includes = [
        {
          condition = "gitdir:~/Projects/assessment/";
          contents = {
            user = {
              name = "sora11011";
              email = "charlesezrailarde@gmail.com";
            };
          };
        }
      ];
    };
    ssh = {
      enable = true;
      enableDefaultConfig = false;

      settings = {
        "*" = {
          ServerAliveInterval = 60;
          ServerAliveCountMax = 3;
        };

        "github-work" = {
          hostname = "github.com";
          user = "sora11011";
          identityFile = "~/.ssh/id_ed25519_assessment";
          identitiesOnly = true;
        };
      };
    };
  };
}
