with import (builtins.fetchGit {
  name = "nixpkgs-unstable-2020-01-11";
  url = "https://github.com/NixOS/nixpkgs-channels";
  ref = "nixpkgs-unstable";
  # Commit hash for nixpkgs-unstable as of 2020-01-11
  # `git ls-remote https://github.com/nixos/nixpkgs-channels nixpkgs-unstable`
  rev = "7e8454fb856573967a70f61116e15f879f2e3f6a";
}) {
  overlays = [(self: super: {})];
};

let
  srcPoetry = fetchFromGitHub {
    owner = "nix-community";
    repo = "poetry2nix";
    # Commit hash for master as of 2020-01-15
    # `git ls-remote https://github.com/nix-community/poetry2nix.git master`
    rev = "2751a7fa0dd675b95e43a14699c2891143c247ec";
    sha256 = "035w0nz20v7ah5l2gvdn6nr6wp28y3ljx7j9vlh83mgf2wjimgv7";
  };
  srcRust = fetchFromGitHub {
    owner = "mozilla";
    repo = "nixpkgs-mozilla";
    # Commit hash for master as of 2019-10-10
    # `git ls-remote https://github.com/mozilla/nixpkgs-mozilla master`
    rev = "d46240e8755d91bc36c0c38621af72bf5c489e13";
    sha256 = "0icws1cbdscic8s8lx292chvh3fkkbjp571j89lmmha7vl2n71jg";
  };
in
  with import "${srcPoetry.out}/overlay.nix" pkgs pkgs;
  with import "${srcRust.out}/rust-overlay.nix" pkgs pkgs;

let
  pythonEnv = poetry2nix.mkPoetryEnv {
    python = python3;
    poetrylock = ./poetry.lock;
  };
  rustEnv = ((rustChannelOf {
    date = "2019-08-01";
    channel = "nightly";
  }).rust.override {
    extensions = [
      "rls-preview"
      "rust-analysis"
      "rustfmt-preview"
    ];
  });
in
  mkShell {
    name = "rustafarian";
    nativeBuildInputs = [
      poetry
      pythonEnv
      rustEnv
    ];

    # Set Environment Variables
    RUST_BACKTRACE = 1;
    RUST_LIB_BACKTRACE = 1;
    shellHook = ''
      unset SSL_CERT_FILE
      local venv=$(poetry env info -p)

      if [[ -z $venv || ! -d $venv ]]; then
        poetry env use ${pythonEnv.out}/bin/python &>> /dev/null
        venv=$(poetry env info -p)
      fi

      export VIRTUAL_ENV="$venv"
    '';
}
