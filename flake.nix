{
  outputs = {...}: {
    elisp-rice = {
      packages =
        [
          "xmind-org"
        ];
      tests = {
        buttercup.enable = true;
      };
    };
  };
}
