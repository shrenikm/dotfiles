## Setup Instructions

Install [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)

Create symlinks to the required locations

```bash
ln -s $(pwd)/zsh/.zshrc ~/.zshrc
```

Custom plugins:

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

## Local overrides (untracked, per-machine)

- `~/.zshrc.local.early` — sourced before oh-my-zsh; set `ZSH_THEME` here for a per-machine theme (falls back to af-magic if absent).
- `~/.zshrc.local` — sourced last; machine-local env/secrets (e.g. `export CONDA_ENVS_DIRS=...`).
