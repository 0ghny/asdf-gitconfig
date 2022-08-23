# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test gitconfigs https://github.com/0ghny/asdf-gitconfigs.git "gitconfigs --help"
```

Tests are automatically run in GitHub Actions on push and PR.
