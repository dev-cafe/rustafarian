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

let src = fetchFromGitHub {
  owner = "mozilla";
  repo = "nixpkgs-mozilla";
  # commit from: 2019-09-04
  rev = "b52a8b7de89b1fac49302cbaffd4caed4551515f";
  sha256 = "1np4fmcrg6kwlmairyacvhprqixrk7x9h89k813safnlgbgqwrqb";
};
in
with import "${src.out}/rust-overlay.nix" pkgs pkgs;
stdenv.mkDerivation {
  name = "rustafarian";
  nativeBuildInputs = [
    # Note: to use use stable, just replace `nightly` with `stable`
    latest.rustChannels.nightly.rust

    # Example Build-time Additional Dependencies
    #pkgconfig
  ];

  buildInputs = [
    # Example Run-time Additional Dependencies
    #openssl
    pipenv
    travis
  ];

  # Set Environment Variables
  RUST_BACKTRACE = 1;
}
