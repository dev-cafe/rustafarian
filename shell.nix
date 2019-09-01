with import (builtins.fetchGit {
  name = "nixos-19.03";
  url = "https://github.com/NixOS/nixpkgs-channels";
  ref = "nixos-19.03";
  # Commit hash for nixos-19.03 as of 2019-08-18
  # `git ls-remote https://github.com/nixos/nixpkgs-channels nixos-19.03`
  rev = "67135fbcc5d5d28390c127ef519b09a362ef2466";
}) {
  overlays = [(self: super:
    {
      python3 = super.python3.override {
        packageOverrides = py-self: py-super: {
          python-language-server = py-super.python-language-server.override {
            providers = [
              "rope"
              "pyflakes"
              "mccabe"
              "pycodestyle"
              "pydocstyle"
            ];
          };
        };
      };
    }
  )];
};

stdenv.mkDerivation {
  name = "PyO3-sandbox";
  buildInputs = [
    rustup

    # Python dev-packages
    python3Packages.black
    python3Packages.epc
    python3Packages.importmagic
    python3Packages.ipython
    python3Packages.isort
    python3Packages.jedi
    python3Packages.mypy
    python3Packages.pyls-black
    python3Packages.pyls-isort
    python3Packages.pyls-mypy
    python3Packages.pytest
    python3Packages.python-language-server

    lldb
    openssl
    pkgconfig
    travis
  ];

  # Set Environment Variables
  RUST_BACKTRACE = 1;
  src = null;
  shellHook = ''
  SOURCE_DATE_EPOCH=$(date +%s)
  '';
}
