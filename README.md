# rustafarian

Musings with Rust and Python with [PyO3]

## How to work with this repo

There currently is some redundancy when it comes to specifying dependencies.
This originates from a number of factors:
1. Rust and Python have different ways of managing dependencies.
2. I use Nix to ensure I have reproducible development environments. This
   clashes massively with Python dependency management.
3. We also want to make this usable when Conda orchestrates the Python
   environment.

- `Cargo.toml`. This specifies the Rust dependencies: first and foremost
[PyO3]. TODO: Maybe specify non-dev Python deps here?
- `pyproject.toml`. This specifies that the build system for the Python project
is [maturin]. In the future we might include more stuff here, depending on
which packaging/environment manager tool takes hold in the Python world.
- `Pipfile`. This is used to set up the Python environment correctly. TODO
Should this list all deps (non-dev + dev)?
- `environment.yml`. Same as `Pipfile`, but for Conda.

In addition:
- `shell.nix` This specifies the Nix shell to create.
- `.envrc` Automates the whole thing.

In a real-world repository `shell.nix` and `.envrc` would not be checked in,
but rather tracked in a "stash branch" using [`git-along`]


### Copyright

Copyright (c) 2018, Charles J. C. Scott, Roberto Di Remigio
Licensed under [MPL v2.0](LICENSE.md).

[PyO3]: https://github.com/PyO3/pyo3
[maturin]: https://github.com/PyO3/maturin
[`git-along`]: https://github.com/nyarly/git-along
