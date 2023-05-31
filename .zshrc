NPM_PACKAGES="${HOME}/.npm-packages/bin"
export PATH="$NPM_PACKAGES:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="pygmalion"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  npm
  zsh-autosuggestions
  zsh-syntax-highlighting
)

if [ -f $ZSH/oh-my-zsh.sh ]; then
  source $ZSH/oh-my-zsh.sh
fi

# User configuration

#unsetopt share_history
#umask 022
export EDITOR=vimx

alias v="gvim -v --servername orig"
#alias vim="vimx"
alias r="ranger"
alias :q="exit"
alias ll="ls -lh --color=auto"
alias la="ls -lha --color=auto"
alias grp="grep --exclude-dir=\"node_modules\" -RFn"
alias gck="git checkout"
alias gitpush="git push && gck master && git pull && git merge dev --no-ff --no-edit && git push && gck dev"
alias gitlog="git log --all --decorate --oneline --graph"
alias gd="git diff HEAD"
alias gs="git status"

if [ -f ~/.zshrc-additional ]; then
  source ~/.zshrc-additional
fi
