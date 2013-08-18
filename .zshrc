#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#
#  Not all terminals support this and, of those that do,
#  not all provide facilities to test the support, hence
#  the user should decide based on the terminal type.  Most
#  terminals  support the  colours  black,  red,  green,
#  yellow, blue, magenta, cyan and white, which can be set
#  by name.  In addition. default may be used to set the
#  terminal's default foreground colour.  Abbreviations
#  are allowed; b or bl selects black.  
#
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
alias history='history 1'
WORDCHARS="${WORDCHARS:s#/#}"
WORDCHARS="${WORDCHARS:s#.#}"
export EDITOR=$(which vim)

# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix
bindkey '^R' history-incremental-search-backward

setopt appendhistory autocd nobeep extendedglob nomatch notify 
setopt autolist auto_menu
unsetopt listambiguous

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/sweaver/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

## completion system
_force_rehash() {
      (( CURRENT == 1 )) && rehash
          return 1  # Because we didn't really complete anything
}

zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete _approximate
zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )' # allow one error for every three characters typed in approximate completer
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~' # don't complete backup files as executables
zstyle ':completion:*:correct:*'       insert-unambiguous true             # start menu completion only if it could find no unambiguous initial string
zstyle ':completion:*:corrections'     format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}' #
zstyle ':completion:*:correct:*'       original true                       #
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}      # activate color-completion(!)
zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'  # format on completion
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select              # complete 'cd -<tab>' with menu
zstyle ':completion:*:history-words'   list false                          #
zstyle ':completion:*:history-words'   menu yes                            # activate menu
zstyle ':completion:*:history-words'   remove-all-dups yes                 # ignore duplicate entries
zstyle ':completion:*:history-words'   stop yes                            #
zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}'        # match uppercase from lowercase
zstyle ':completion:*:matches'         group 'yes'                         # separate matches into groups
zstyle ':completion:*'                 group-name ''
zstyle ':completion:*:messages'        format '%d'                         #
zstyle ':completion:*:options'         auto-description '%d'               #
zstyle ':completion:*:options'         description 'yes'                   # describe options in full
zstyle ':completion:*:processes'       command 'ps -au$USER'               # on processes completion complete all user processes
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters        # offer indexes before parameters in subscripts
zstyle ':completion:*'                 verbose true                        # provide verbose completion information
zstyle ':completion:*:warnings'        format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d' # set format for warnings
zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'       # define files to ignore for zcompile
zstyle ':completion:correct:'          prompt 'correct to: %e'             #
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'    # Ignore completion functions for commands you don't have:

# complete manual by their section
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select

# Completion caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path .zcache
zstyle ':completion:*:cd:*' ignore-parents parent pwd

zstyle ':completion::complete:cd::' tag-order local-directories
zstyle ':completion:*' menu select=2
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

CDPATH=.:~:~/git
PATH=$PATH:~/bin
PATH=/Users/sweaver/QtSDK/Desktop/Qt/4.8.1/gcc/bin:$PATH 

#I want my umask 0002 if I'm not root
if [[ $(whoami) = root ]]; then
    umask 0022
else
    umask 0002
fi

if [[ $(uname) = Darwin ]]; then
    alias ctags='/usr/local/bin/ctags'
else
    alias ctags='ctags'
fi

if [[ $(uname) = Darwin ]]; then
    alias ls='ls -G'
    alias dir='dir -G'
    alias vdir='vdir -G'
    alias grep='grep -G'
    alias egrep='egrep -G'
    alias fgrep='fgrep -G'
    alias egrep='egrep -G'
fi

#aliases
alias se='sudoedit'
alias  vi=$(which vim)
alias -- -='cd -'
alias  ...='../..'
alias  ....='../../..'
alias  .....='../../../..'
alias  ll='ls -lah'
alias  lt='ls -lath'
alias  sl='ls -lah'
alias  l='ls -la'
alias  lg='ls | grep -v /'
alias -g X='| xargs'
alias -g G='| egrep'

show-colors() {
    for line in {0..17}; do
        for col in {0..15}; do
            code=$(( $col * 18 + $line ));
            printf $'\e[38;05;%dm %03d' $code $code;
        done;
        echo;
    done
}

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD
setopt CORRECT

## keep background processes at full speed
#setopt NOBGNICE
## restart running processes on exit
#setopt HUP

## history
#setopt APPEND_HISTORY
## for sharing history between zsh processes
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

## never ever beep ever
setopt NO_BEEP

setopt nonomatch            # do not print error on non matched patterns
## automatically decide when to page a list of completions
#LISTMAX=0

## disable mail checking
#MAILCHECK=0

autoload -U colors && colors
# set some colors
for COLOR in RED GREEN YELLOW WHITE BLACK CYAN BLUE PURPLE; do
    eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'         
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done                                                 
PR_RESET="%{${reset_color}%}";                       

setopt prompt_subst
 
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git cvs svn
# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stangedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
## check-for-changes can be really slow.
## you should disable it, if you work with large repositories
zstyle ':vcs_info:*:prompt:*' check-for-changes true            # slower, but lets us show changes to working/index
zstyle ':vcs_info:*:prompt:*' unstagedstr "${PR_BRIGHT_YELLOW}*${PR_RESET}"             # unstaged changes string: red *
zstyle ':vcs_info:*:prompt:*' stagedstr "${PR_BRIGHT_YELLOW}+${PR_RESET}"            # staged changes string: yellow +
zstyle ':vcs_info:*:prompt:*' formats  " ${PR_RED}%s${PR_RESET}:${magenta}(%b${PR_RESET}%c%u${magenta})${PR_RESET}"              "%a"
zstyle ':vcs_info:*:prompt:*' actionformats  " ${PR_RED}%s${PR_RESET}:${magenta}(%b|%a)${PR_RESET}"              "%a"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""                             "%~"
zstyle ':vcs_info:*:prompt:*' branchformat  "%b:%r"              ""

BLUE_DIAMOND="%B%F{blue}◆%f%b"
YELLOW_DIAMOND="%B%F{yellow}◆%f%b"
GREEN_DIAMOND="%B%F{green}◆%f%b"
RED_DIAMOND="%B%F{red}◆%f%b"
RED_RARROW="%B%F{red}▶%f%b"
RED_LARROW="%B%F{red}◀%f%b"
RED_STAR="%B%F{red}✱%b%f"

if [[ $(whoami) = root ]]; then
    PROMPT_LINE="%B%F{red}%n@%M%f%b"
else
    PROMPT_LINE="%B%F{cyan}%n%f@%B%F{cyan}%m%b%f"
fi

precmd(){

    local exit_status=$?

    vcs_info 'prompt'

    # now lets change the color of the path if its not writable
    if [[ -w $PWD ]]; then
        PR_PWDCOLOR="%F{white}"
    else
        PR_PWDCOLOR="${PR_BRIGHT_RED}"
    fi  

    # exit code, print it if its not 0
    if [[ $exit_status -ne 0 ]]; then
        EXIT_STATUS=" %B%F{red}◆%f%b %B%F{white}Exit Code:%b%f %B%F{yellow}${exit_status}%b%f"
    else
        EXIT_STATUS=""
    fi  

#PROMPT LINE
#${PR_BRIGHT_YELLOW}%D{%R.%S %a %b %d %Y}${PR_RESET}\
LINE1_PROMPT="\
%B%F{cyan}%f%b\
%B%F{white}%D{%R.%S}%b%f\
${EXIT_STATUS}\
%(1j. %B%F{cyan}◆%f%b %B%F{yellow}Jobs: %j%f%b.)\
${PR_BATTERY}\
%B%F{cyan}%f%b"
###################
LINE1=${(e%)LINE1_PROMPT}
print -- "$LINE1"
}

zle -N edit-command-line
bindkey -M vicmd v edit-command-line

PROMPT='${PROMPT_LINE}%B%F{white}:%f%b${PR_PWDCOLOR}%~${PR_RESET}${vcs_info_msg_0_}%(!.%B%F{red}%#%f%b.%F{cyan}%f%b '
