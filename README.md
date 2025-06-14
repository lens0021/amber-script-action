# amber-script-action

[![Linter](https://github.com/lens0021/amber-script-action/actions/workflows/linter.yaml/badge.svg)](https://github.com/lens0021/amber-script-action/actions/workflows/linter.yaml)

Run arbitrary Amber script via GitHub Actions.
Inspired by [actions/github-script].

## Usage

See [action.yaml](action.yaml)

<!-- start usage -->

```yaml
- uses: actions/checkout@v4
  with:
    # The script to run.
    script: ""

    # The version to use.
    # Examples: 0.4.0-alpha, 0.3.5-alpha
    # Default: 0.4.0-alpha
    amber-version: ""

    # Whether to cache Amber binaries and the compiled bash scripts
    # Default: true
    enable-cache: ""

    # The path to store Amber binaries and the compiled bash scripts
    # Default: '/home/runner/.amber-script-action'
    cache-path: ""
```

<!-- end usage -->

**Basic:**

```yaml
on: push

jobs:
  hello-world:
    runs-on: ubuntu-latest
    steps:
      - uses: lens0021/amber-script-action@main
        with:
          script: |
            const msg = "Hello World!"
            echo msg
            echo "The length of the previous message is {len msg}
```

[actions/github-script]: https://github.com/actions/github-script
