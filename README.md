# amber-script-action

[![Linter](https://github.com/lens0021/amber-script-action/actions/workflows/linter.yaml/badge.svg)](https://github.com/lens0021/amber-script-action/actions/workflows/linter.yaml)

Run arbitrary [Amber] script via GitHub Actions.
Inspired by [actions/github-script].

> [!NOTE]
> This is a [composite action] because I want less maintaining costs.
> There is a limitation of composite action itself:
>
> - Name of steps are not displayed. ([link](https://github.com/orgs/community/discussions/10985))

## Usage

See [action.yaml](action.yaml)

<!-- start usage -->

```yaml
- uses: lens0021/amber-script-action@v1
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

    # The path to store Amber binaries and the compiled bash scripts.
    # If empty string is given, the used path depends on the runner.
    # Default (Linux): '/home/runner/.amber-script-action'
    # Default (Mac): '/Users/runner/.amber-script-action'
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
      - uses: lens0021/amber-script-action@v1
        with:
          script: |
            const msg = "Hello World!"
            echo msg
            echo "The length of the previous message is {len msg}."
```

[amber]: https://amber-lang.com/
[actions/github-script]: https://github.com/actions/github-script
[composite action]: https://docs.github.com/en/actions/sharing-automations/creating-actions/creating-a-composite-action
