# Oh my zsh config
# -----------------------------------------------------------
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Per-machine theme override: set ZSH_THEME in ~/.zshrc.local.early (untracked,
# optional) to differ from the default. Falls back to af-magic if absent.
[ -f "$HOME/.zshrc.local.early" ] && source "$HOME/.zshrc.local.early"
ZSH_THEME="${ZSH_THEME:-af-magic}"

plugins=(
  zsh-autosuggestions
  colored-man-pages
  command-not-found
  tmux
  jump
  python
  pip
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
# -----------------------------------------------------------

# Options
# -----------------------------------------------------------
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt correct
setopt multios
setopt globdots
setopt nullglob
# -----------------------------------------------------------

# Keybindings
# -----------------------------------------------------------
# For zsh-autosuggestions
bindkey '^ ' autosuggest-accept
bindkey '^g' autosuggest-toggle
# -----------------------------------------------------------

# Autocomplete
# -----------------------------------------------------------
autoload -Uz compinit
# -----------------------------------------------------------

# Aliases
# -----------------------------------------------------------
# Unalias git-gui so that we can use grip-grab
unalias gg 2>/dev/null

alias gl='git log --oneline --graph --decorate --all'
alias gs='git status'
alias gd='git diff'
alias ga='git add -u'
alias gaa='git add .'
alias gcm='git commit -m'
alias gpo='git push origin'

# Claude Code. Shadows /usr/bin/cc (the C compiler) at the interactive
# prompt only; build tooling invokes cc directly and is unaffected. Use
# \cc or `command cc` to reach the compiler if ever needed.
alias cc='claude'
# -----------------------------------------------------------

# Neovim config
# -----------------------------------------------------------
# The `nvim` and `lvim` commands are provided by shims in ~/.local/bin
# (symlinked from dotfiles/bin/). The shims read the pinned version from
# dotfiles/neovim/version and set NVIM_APPNAME appropriately.
export EDITOR="lvim"
# -----------------------------------------------------------

# Set path variables
# -----------------------------------------------------------
path+=$HOME/.local/bin
path+=$HOME/.cargo/bin
# -----------------------------------------------------------



# Conda
# -----------------------------------------------------------
# Miniforge install at ~/miniforge3, sourced on shell startup.
__conda_setup="$("$HOME/miniforge3/bin/conda" 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniforge3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

# Activate base only if no env was inherited from the parent shell. Keeps
# new terminals landing in (base) without clobbering subshells launched from
# inside an already-active env (e.g. nvim :terminal from a direnv project).
[ -z "${CONDA_DEFAULT_ENV:-}" ] && conda activate base

# Render $CONDA_DEFAULT_ENV as a prompt prefix. Conda's own PS1 mutation is
# disabled (changeps1: false) because it doesn't survive direnv's subshell
# activation, so we inject the prefix here in a theme-agnostic way.
setopt prompt_subst
RPROMPT='%F{yellow}${CONDA_DEFAULT_ENV:+($CONDA_DEFAULT_ENV) }%f'$RPROMPT
# -----------------------------------------------------------

# Node config
# -----------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# -----------------------------------------------------------


# Direnv
# -----------------------------------------------------------
# Must come AFTER conda init so direnvrc layouts can source conda.sh.
# Empty DIRENV_LOG_FORMAT silences the "loading .envrc / exporting ..." chatter
# (and the trailing blank line) on every cd.
export DIRENV_LOG_FORMAT=
if command -v direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi
# -----------------------------------------------------------

# Yazi config
# -----------------------------------------------------------
# 'y' opens yazi normally; 'yy' also resumes the shell in yazi's last
# working directory on exit.
alias y='yazi'
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
# -----------------------------------------------------------

# Machine-local overrides
# -----------------------------------------------------------
# Untracked, per-host config that shouldn't live in the repo (ssh-agent /
# keychain, secrets, box-specific tweaks). Sourced last so it can override
# anything above. Create ~/.zshrc.local on the relevant machine.
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
# -----------------------------------------------------------
