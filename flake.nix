{
  description = "FIXME: Your package description";

  inputs = {
    melpa = {
      url = "github:melpa/melpa";
      flake = false;
    };

    nomake = {
      url = "github:emacs-twist/nomake";
    };
  };

  outputs =
    { self
    , nomake
    , ...
    } @ inputs:
    nomake.lib.mkFlake {
      src = ./.;
      localPackages = [
        "xmind-org"
      ];
      scripts.test = {
        description = "Run tests";
        compile = true;
        extraPackages = [
          "buttercup"
        ];
        text = ''
          emacs -batch -l buttercup -f buttercup-run-discover "$PWD"
        '';
      };
    };
}
