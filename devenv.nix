{ pkgs, config, ... }:
{
  imports = [
    ./devenv/modules/python.nix
  ];

  languages.python.interpreter = pkgs.python310;
  languages.python.pyprojectOverrides = import ./overrides.nix { inherit pkgs; };

  packages = [
    config.languages.python.uv.package
    config.outputs.python.virtualenv
  ];

  enterShell = ''
    unset PYTHONPATH
    export UV_NO_SYNC=1
    export UV_PYTHON_DOWNLOADS=never
    export REPO_ROOT=$(git rev-parse --show-toplevel)
  '';

  git-hooks.hooks.treefmt = {
    enable = true;
    settings.formatters = [
      pkgs.nixfmt-rfc-style
    ];
  };
}
