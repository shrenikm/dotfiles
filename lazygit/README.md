## Config

`$LG_CONFIG_FILE` (set in `zsh/.zshrc`) layers two files:

- `config.yml` — committed base / shared defaults.
- `~/.config/lazygit/config.local.yml` — optional, untracked, per-machine override.

## Per-machine override

Create `~/.config/lazygit/config.local.yml` — e.g. a distinct border color to tell boxes apart:

```yaml
gui:
  theme:
    activeBorderColor: [magenta, bold]
```
