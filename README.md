# amber-script-action

Run arbitrary Amber script via GitHub Actions.
Inspired by [actions/github-script].

## Usage

See [action.yml](action.yml)

<!-- start usage -->

```yaml
TODO auto-generate this
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
