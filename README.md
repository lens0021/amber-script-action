# amber-script-action

[![Linter](https://github.com/lens0021/amber-script-action/actions/workflows/linter.yaml/badge.svg)](https://github.com/lens0021/amber-script-action/actions/workflows/linter.yaml)

Run arbitrary [Amber] script via GitHub Actions.
Inspired by [actions/github-script].

> [!NOTE]
> This is a [composite action] because I want less maintaining costs.
> There is a limitation of composite action itself:
>
> - Name of steps are not displayed. ([GitHub discussion](https://github.com/orgs/community/discussions/10985))

## Usage

See [action.yaml](action.yaml)

<!-- start usage -->

### Basic Parameters

```yaml
- uses: lens0021/amber-script-action@v1
  with:
    # The script to run.
    script: ""

    # The version to use.
    # Examples: 0.5.1-alpha, 0.4.0-alpha
    # Default: 0.5.1-alpha
    amber-version: ""

    # Whether to cache Amber binaries and the compiled bash scripts
    # Default: true
    enable-cache: ""

    # The path to store Amber binaries and the compiled bash scripts.
    # If empty string is given, the default path will be used.
    # Default: '~/.cache/amber-script-action'
    cache-path: ""
```

### Building from Source (Optional)

When you need to build Amber from source instead of using pre-built binaries:

```yaml
- uses: lens0021/amber-script-action@v1
  with:
    # Git repository URL to clone Amber from when building from source.
    # Default: https://github.com/amber-lang/amber.git
    amber-repository-url: ""

    # Git ref (commit SHA, branch, or tag) to build Amber from source.
    # If provided, this overrides 'amber-version' and builds from source.
    # Examples: main, v0.5.0-alpha, 3742194594cfdf18e034658d1f58a93b3143bbd7
    # Default: "" (uses pre-built binaries)
    amber-repository-ref: ""
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

## When to Use This Action

This action is designed for **light-weight inline scripting** directly in your workflow files.

If you need to **execute larger Amber programs from separate files**, use [lens0021/setup-amber] instead:

```yaml
- uses: lens0021/setup-amber@v2
  with:
    amber-version: 0.5.1-alpha
- run: amber your-script.ab
```

This approach gives you proper syntax highlighting, LSP integration, and keeps your workflow files concise.

## Error Handling

> [!IMPORTANT]
> Unlike regular `run:` steps, this action does **not** use `set -e` due to the nature of Amber's compiled output, which means that **commands will not automatically fail the workflow** when they return non-zero exit codes.

**With regular `run:` (uses `set -e` by default):**

```yaml
- name: This will fail the workflow
  run: |
    false  # This command fails, workflow stops here
    echo "This will not be executed"
```

**With `amber-script-action` (does NOT use `set -e`):**

```yaml
- name: This will NOT fail the workflow
  uses: lens0021/amber-script-action@v2
  with:
    script: |
      trust $ ls /nonexistent $ // This command fails, but execution continues
      echo "This WILL be executed"
```

**To explicitly fail on errors, use the `exit` builtin:**

```yaml
- uses: lens0021/amber-script-action@v2
  with:
    script: |
      $ ls /nonexistent $ failed(code) {
        echo "Command failed with exit code {code}"
        exit code // Explicitly exit to fail the workflow
      }
```

## Working with Outputs

The action supports setting outputs that can be used in subsequent workflow steps. Due to the nature of composite actions, outputs must be statically defined in the action metadata and cannot be dynamically created at runtime. To work around this constraint while providing maximum flexibility, all script outputs are collected into a single JSON object (`script_outputs`). This allows scripts to set any number of outputs with arbitrary names, which can then be extracted using `fromJSON()` in subsequent steps.

Write outputs to the `$AMBER_SCRIPT_OUTPUT` file using the same `key=value` format as `$GITHUB_OUTPUT`:

```yaml
- id: my-script
  uses: lens0021/amber-script-action@v2
  with:
    script: |
      const docs_path = "./docs"
      const version = "1.2.3"

      // Set outputs
      trust $ echo "docs_path={docs_path}" >> \$AMBER_SCRIPT_OUTPUT $
      trust $ echo "version={version}" >> \$AMBER_SCRIPT_OUTPUT $

      echo "Outputs set successfully"

- name: Use outputs
  run: |
    echo "Docs path: ${{ fromJSON(steps.my-script.outputs.script_outputs).docs_path }}"
    echo "Version: ${{ fromJSON(steps.my-script.outputs.script_outputs).version }}"
```

All outputs are returned as a single JSON object in the `script_outputs` output. To access individual values:

[amber]: https://amber-lang.com/
[actions/github-script]: https://github.com/actions/github-script
[composite action]: https://docs.github.com/en/actions/sharing-automations/creating-actions/creating-a-composite-action
[lens0021/setup-amber]: https://github.com/lens0021/setup-amber
