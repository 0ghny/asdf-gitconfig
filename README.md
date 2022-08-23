<div align="center">

# asdf-gitconfigs [![Build](https://github.com/0ghny/asdf-gitconfigs/actions/workflows/build.yml/badge.svg)](https://github.com/0ghny/asdf-gitconfigs/actions/workflows/build.yml) [![Lint](https://github.com/0ghny/asdf-gitconfigs/actions/workflows/lint.yml/badge.svg)](https://github.com/0ghny/asdf-gitconfigs/actions/workflows/lint.yml)


[gitconfigs](https://github.com/0ghny/gitconfigs) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [asdf-gitconfigs  ](#asdf-gitconfigs--)
- [Contents](#contents)
- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- **Optional**: `ASDF_GITCONFIGS_OVERWRITE_ARCH` if present you can specify arch to download an specific one.

# Install

Plugin:

```shell
asdf plugin add gitconfigs
# or
asdf plugin add gitconfigs https://github.com/0ghny/asdf-gitconfigs.git
```

gitconfigs:

```shell
# Show all installable versions
asdf list-all gitconfigs

# Install specific version
asdf install gitconfigs latest

# Set a version globally (on your ~/.tool-versions file)
asdf global gitconfigs latest

# Now gitconfigs commands are available
gitconfigs --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/0ghny/asdf-gitconfigs/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [0ghny](https://github.com/0ghny/)
