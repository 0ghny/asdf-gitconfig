<div align="center">

# asdf-gitconfig [![Build](https://github.com/0ghny/asdf-gitconfig/actions/workflows/build.yml/badge.svg)](https://github.com/0ghny/asdf-gitconfig/actions/workflows/build.yml) [![Lint](https://github.com/0ghny/asdf-gitconfig/actions/workflows/lint.yml/badge.svg)](https://github.com/0ghny/asdf-gitconfig/actions/workflows/lint.yml)


[gitconfig](https://github.com/0ghny/gitconfig) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [asdf-gitconfig  ](#asdf-gitconfig--)
- [Contents](#contents)
- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- **Optional**: `ASDF_gitconfig_OVERWRITE_ARCH` if present you can specify arch to download an specific one.

# Install

Plugin:

```shell
asdf plugin add gitconfig
# or
asdf plugin add gitconfig https://github.com/0ghny/asdf-gitconfig.git
```

gitconfig:

```shell
# Show all installable versions
asdf list-all gitconfig

# Install specific version
asdf install gitconfig latest

# Set a version globally (on your ~/.tool-versions file)
asdf global gitconfig latest

# Now gitconfig commands are available
gitconfig --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/0ghny/asdf-gitconfig/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [0ghny](https://github.com/0ghny/)
