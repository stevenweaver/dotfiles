# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# sweaver edits

# aliases
alias history='history 1'
alias sw='ssh ssh.nearlyfreespeech.net -l maximumsteve_stevenweaver'
alias ssh='ssh -A'
alias vim='nvim'
alias jq='jq -C'
alias less='less -R'

if [ `uname` = "Darwin" ]; then
  alias make="make -j `sysctl -n hw.ncpu`"
else
  alias make="make -j `nproc`"
fi

# history
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
WORDCHARS="${WORDCHARS:s#/#}"
WORDCHARS="${WORDCHARS:s#.#}"

# backwards search functionality
bindkey '^i' expand-or-complete-prefix
bindkey '^R' history-incremental-search-backward
bindkey  '^K' up-line-or-history
bindkey  '^J' down-line-or-history
bindkey  '^H' beginning-of-line

zstyle ':completion:*' insert-tab false

# end sweaver edits

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dieter"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/usr/local/texlive/2016/bin/x86_64-darwin/:$PATH
export PATH=/usr/local/Cellar/tmux/2.3_3/bin:$PATH 
export PATH=/opt/homebrew/bin/:/usr/local/opt/python/bin/:$PATH 
export PATH=/$HOME/homebrew/bin/:/usr/local/opt/python/bin/:$PATH 
export PATH=/Users/sweaver/.deno/bin:$PATH
export PATH=/Users/sweaver/.local/bin:$PATH
export GOPATH=$HOME/go

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
export PATH=${PATH}:/Users/sweaver/edirect
export NCBI_API_KEY=4a0e37b29aa409ed7bbb92a5a8951cddd109
source ~/.profile

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/sweaver/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/sweaver/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/sweaver/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/sweaver/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

