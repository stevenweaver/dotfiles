# Define some colors first:
red='\e[0;31m'
RED='\e[1;31m'
green='\e[0;32m'
GREEN='\e[1;32m'
yellow='\e[0;33m'
YELLOW='\e[1;33m'
blue='\e[0;34m'
BLUE='\e[1;34m'
WHITE='\e[1;37m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m'              # No Color


#-----------------------------------
# Source global definitions (if any)
#-----------------------------------

if [ -f /etc/bashrc ]; then
        . /etc/bashrc   # --> Read /etc/bashrc, if present.
fi

#-------------------------------------------------------------
# Automatic setting of $DISPLAY (if not set already)
# This works for linux - your mileage may vary.... 
# The problem is that different types of terminals give
# different answers to 'who am i'......
# I have not found a 'universal' method yet
#-------------------------------------------------------------

function get_xserver ()
{
    case $TERM in
	xterm )
            XSERVER=$(who am i | awk '{print $NF}' | tr -d ')''(' ) 
            # Ane-Pieter Wieringa suggests the following alternative:
            # I_AM=$(who am i)
            # SERVER=${I_AM#*(}
            # SERVER=${SERVER%*)}

            XSERVER=${XSERVER%%:*}
	    ;;
	aterm | rxvt)
 	# find some code that works here.....
	    ;;
    esac  
}

if [ -z ${DISPLAY:=""} ]; then
    get_xserver
    if [[ -z ${XSERVER}  || ${XSERVER} == $(hostname) ||
          ${XSERVER} == "unix" ]]; then
	DISPLAY=":0.0"		# Display on local host
    else		
	DISPLAY=${XSERVER}:0.0	# Display on remote host
    fi
fi

export DISPLAY

#---------------
# Some settings
#---------------

ulimit -S -c 0        # Don't want any coredumps
set -o notify
set -o noclobber
#set -o ignoreeof	# Disable CTR+D
set -o nounset
#set -o xtrace        # Useful for debuging
set -o vi

# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize	# Dynamic resizing 
shopt -s sourcepath
shopt -s no_empty_cmd_completion  # bash>=2.04 only
shopt -s cmdhist
shopt -s histappend histreedit histverify 	# Enable history appending instead of overwriting.
shopt -s extglob      # Necessary for programmable completion

# Disable options:
unset MAILCHECK       # I don't want my shell to warn me of incoming mail

export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTIGNORE="&:bg:fg:ll:h"
export HOSTFILE=$HOME/.hosts	# Put a list of remote hosts in ~/.hosts
export HISTFILESIZE=100000
export HISTCONTROL=eraseedups

# Add bin to path
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:/opt/local/bin/"


# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs


#---------------
# Shell prompt
#---------------

function powerprompt()
{
    _powerprompt()
    {
        LOAD=$(uptime|sed -e "s/.*: \([^,]*\).*/\1/" -e "s/ //g")
        TIME=$(date +%H:%M:%S)
DATE=$(date)
echo -ne "\033]0;[${USER}@${HOSTNAME}] $PWD load: $LOAD ${TIME}\007"
    }

    PROMPT_COMMAND=_powerprompt

    case $TERM in
        xterm*|rxvt*|Eterm|aterm|kterm|gnome )
if [ "$UID" == "0" ]; then
BLA="#"
else
BLA=">"
fi
PS1="\[$CYAN\][\$TIME \[$YELLOW\]- \[$RED\]\$LOAD\[$CYAN\]]\[$NC\]\n\[$GREEN\][\u@\h]\[$CYAN\] \w \[$BLA\]\[$NC\] "
# PS1="${cyan}[\h \#] \W $BLA $NC\[\033]0;[\u@\h] \w \$TIME \$LOAD\007\]"
# PS1="${cyan}[\$TIME \$LOAD]$NC\n[\h \#] \W > \[\033]0;[\u@\h] \w\007\]"
;;
        linux | screen )
            PS1="\[${cyan}\][\$TIME - \$LOAD]\[$NC\]\n[\h] \w > "
;;
        * )
            PS1="[\$TIME - \$LOAD]\n[\h] \w > "
;;
    esac
}

powerprompt # this is the default prompt - might be slow
                # If too slow, use fastprompt instead....



#===============================================================
#
# ALIASES AND FUNCTIONS
#
# Arguably, some functions defined here are quite big
# (ie 'lowercase') but my workstation has 512Meg of RAM, so .....
# If you want to make this file smaller, these functions can
# be converted into scripts.
#
#===============================================================

#-------------------
# UCSD Aliases
#-------------------
alias starttest='~/Environments/Test/zinstance/bin/plonectl start'
alias stoptest='~/Environments/Test/zinstance/bin/plonectl stop'

alias capuchin='ssh capuchin -l sweaver'
alias database='ssh database -l sweaver'
alias diskfarm='ssh diskfarm -l sweaver'
alias gateway='ssh gateway -l sweaver'
alias gibbon='ssh gibbon -l sweaver'
alias lemur='ssh lemur -l sweaver'
alias mandrill='ssh mandrill -l sweaver'
alias mb='ssh monkeybusiness -l sweaver'
alias silverback='ssh silverback -l sweaver'
alias tamarin='ssh tamarin -l sweaver'
alias yeti='ssh yeti -l sweaver'

alias stageapp='ssh stageapp -l sweaver'
alias testapp='ssh testapp -l sweaver'

#-------------------
# Personal Aliases
#-------------------
alias sw='ssh ssh.phx.nearlyfreespeech.net -l maximumsteve_stevenweaver'
alias mpg123='mpg123-oss'
alias play='vlc -I ncurses *.mp3'
alias kf='killall firefox-bin'
alias suod='sudo'

#Preserve environment
alias sudo='sudo -E'


case $OSTYPE in
linux*|freebsd*)
    alias du='du -kh'
    alias df='df -kTh'
    alias grep='grep --colour=auto'
    alias more='less'
    alias rm='rm -i'
    alias cp='cp -i'
    alias mv='mv -i'
    alias mkdir='mkdir -p'
    alias ll='ls -la'
	;;
*)
	;;
esac

#-------------------
# ls Aliases
#-------------------

#eval "`dircolors -b`"
export CLICOLOR=1
#alias ls='ls -G'
alias ll='ls -la'               # recursive ls
alias la='ls -Al'               # show hidden files
alias lx='ls -lXB'              # sort by extension
alias lk='ls -lSr'              # sort by size
alias lc='ls -lcr'		        # sort by change time  
alias lu='ls -lur'		        # sort by access time   
alias lr='ls -lR'               # recursive ls
alias lt='ls -ltr'              # sort by date
alias lm='ls -al |more'         # pipe through 'more'
alias tree='tree -Csu'		    # nice alternative to 'ls'


#-------------------
# less Aliases
#-------------------

#export PAGER=less
#export LESSCHARSET='UTF-8'
#export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
       # Use this if lesspipe.sh exists.
#export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \
#:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

#-------------------
# Other Aliases
#-------------------

alias rohan='ssh rohan.sdsu.edu -l masc0053'
alias beep='echo -en \\007 && echo beep'
alias bbeep='echo -en \\007 && sleep 1 && echo -en \\007 && echo bbeep'
#alias it="PATH=$PATH:~it/bin sudo -H -u it bash"
alias h='history'
alias j='jobs -l'
alias which='type -a'
alias ..='cd ..'
#alias path='echo -e ${PATH//:/\\n}'
alias li='less -i'
#alias fetchmaild="fetchmail --daemon 60"
#alias lan='enscript -G -r -f Courier8'
#alias lan10='enscript -G -r -f Courier10'
#alias lan='enscript -G -r -f Courier8 -P merlot'
#alias lan2='enscript -G -2r'
#alias lan2='enscript -G -2r -P merlot'
#alias lan2-10='enscript -G -2r -f Courier10'
#alias print='enscript -G -f Courier8'
#alias print10='enscript -G -f Courier10'
#alias gs="gs -sDEVICE=x11"
#alias st="ssh-agent startx"
#alias sb="ssh-agent bash"
#alias sa="ssh-add ~/.ssh/id_dsa"
#alias sl="ssh -p 9999 localhost"
alias info="info --vi-keys"

#some ssh aliases, some just for historical ref....
#alias st="ssh-agent startx"
#alias asylum="ssh -o tisauthentication=yes -L 9999:asylum.yahoo.com:22 -l dekker@asylum.yahoo.com proxy.yahoo.com"
#alias ass="ssh -o tisauthentication=yes -L 9999:asylum.yahoo.com:22 -l dekker@asylum.yahoo.com proxy.yahoo.com"
#alias asp="ssh -o tisauthentication=yes -L 1080:socks.yahoo.com:1080 -l dekker@asylum.yahoo.com proxy.yahoo.com"
#alias univacsquid='ssh -o "GatewayPorts yes" -l dekker -L 3128:univac:3128 univac'
#alias darby='ssh -R 9999:gist.offix:22 darby.int'

#Starting commands because I'm lazy
#-----------------------------------------
# Environment dependent aliases/variables
#-----------------------------------------

function colcheck() {
  perl -e "print '-' x $COLUMNS, \"\n\";"
}

#----------------
# a few fun ones
#----------------

function xtitle ()
{
    case $TERM in
        xterm*|rxvt*|Eterm|aterm|kterm|gnome)
            echo -n -e "\033]0;$*\007" ;;
        *)  ;;
    esac
}

alias top='xtitle Processes on $HOSTNAME && top'
alias make='xtitle Making $(basename $PWD) ; make'
alias ncftp="xtitle ncFTP ; ncftp"
alias mutt="xtitle Mutt ; mutt"

#---------------
# and functions
#---------------

function man ()
{
    for i ; do
	xtitle The $(basename $1|tr -d .[:digit:]) manual
	command man -a "$i"
    done
}

#-----------------
# git acheivements 
#-----------------
export PATH="$PATH:~/git-achievements"
#alias git="git-achievements"


#-----------------------------------
# File & strings related functions:
#-----------------------------------

# Find a file with a pattern in name:
function ff()

{ find . -type f -iname '*'$*'*' -ls ; }
# Find a file with pattern $1 in name and Execute $2 on it:

function fe()
{ find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }
# find pattern in a set of filesand highlight them:

function fstr()
{
    OPTIND=1
    local case=""
    local usage="fstr: find string in files.
    Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
        i) case="-i " ;;
        *) echo "$usage"; return;;
        esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    local SMSO=$(tput smso)
    local RMSO=$(tput rmso)
    find . -type f -name "${2:-*}" -print0 |
    xargs -0 grep -sn ${case} "$1" 2>&- | \
    sed "s/$1/${SMSO}\0${RMSO}/gI" | more
}

function cuttail() # Cut last n lines in file, 10 by default.
{
    nlines=${2:-10}
    sed -n -e :a -e "1,${nlines}!{P;N;D;};N;ba" $1
}

function lowercase()  # move filenames to lowercase
{
    for file ; do
        filename=${file##*/}
        case "$filename" in
        */*) dirname==${file%/*} ;;
        *) dirname=.;;
        esac
        nf=$(echo $filename | tr A-Z a-z)
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
        else
            echo "lowercase: $file not changed."
        fi
    done
}

function swap()         # swap 2 filenames around
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

#-----------------------------------
# Process/system related functions:
#-----------------------------------

function my_ps()
{ ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }

function pp()
{ my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }

# This function is roughly the same as 'killall' on linux
# but has no equivalent (that I know of) on Solaris
function killps()   # kill by process name
{
   local pid pname sig="-TERM"   # default signal
   if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
       echo "Usage: killps [-SIGNAL] pattern"
       return;
   fi
   if [ $# = 2 ]; then sig=$1 ; fi
   for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} ) ; do
       pname=$(my_ps | awk '$1~var { print $5 }' var=$pid )
       if ask "Kill process $pid <$pname> with signal $sig?"
           then kill $sig $pid
       fi
   done
}

function my_ip() # get IP adresses
{
    MY_IP=$(/sbin/ifconfig ppp0 | awk '/inet/ { print $2 } ' | \
sed -e s/addr://)
    MY_ISP=$(/sbin/ifconfig ppp0 | awk '/P-t-P/ { print $3 } ' | \
sed -e s/P-t-P://)
}

function ii()   # get current host related info
{
  echo -e "\nYou are logged on ${RED}$HOSTNAME"
  echo -e "\nAdditionnal information:$NC " ; uname -a
  echo -e "\n${RED}Users logged on:$NC " ; w -h
  echo -e "\n${RED}Current date :$NC " ; date
  echo -e "\n${RED}Machine stats :$NC " ; uptime
  echo -e "\n${RED}Memory stats :$NC " ; free
  my_ip 2>&- ;
  echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP:-"Not connected"}
  echo -e "\n${RED}ISP Address :$NC" ; echo ${MY_ISP:-"Not connected"}
  echo
}

# Misc utilities:

function repeat()       # repeat n times command
{
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do  # --> C-like syntax
        eval "$@";
    done
}

function ask()
{
    echo -n "$@" '[y/n] ' ; read ans
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}

#=======================================================================
#
# PROGRAMMABLE COMPLETION - ONLY SINCE BASH-2.04
# Most are taken from the bash 2.05 documentation and from Ian McDonalds
# 'Bash completion' package
#  (http://www.caliban.org/bash/index.shtml#completion)
# You will in fact need bash-2.05a for some features
#
#=======================================================================

if [ "${BASH_VERSION%.*}" \< "2.05" ]; then
   echo "You will need to upgrade to version 2.05 \
for programmable completion"
   return
fi

shopt -s extglob        # necessary
set +o nounset          # otherwise some completions will fail

complete -A hostname   rsh rcp telnet rlogin r ftp ping disk
complete -A export     printenv
complete -A variable   export local readonly unset
complete -A enabled    builtin
complete -A alias      alias unalias
complete -A function   function
complete -A user       su mail finger

complete -A helptopic  help     # currently same as builtins
complete -A shopt      shopt
complete -A stopped -P '%' bg
complete -A job -P '%'     fg jobs disown

complete -A directory  mkdir rmdir
complete -A directory   -o default cd

# Compression
complete -f -o default -X '*.+(zip|ZIP)'  zip
complete -f -o default -X '!*.+(zip|ZIP)' unzip
complete -f -o default -X '*.+(z|Z)'      compress
complete -f -o default -X '!*.+(z|Z)'     uncompress
complete -f -o default -X '*.+(gz|GZ)'    gzip
complete -f -o default -X '!*.+(gz|GZ)'   gunzip
complete -f -o default -X '*.+(bz2|BZ2)'  bzip2
complete -f -o default -X '!*.+(bz2|BZ2)' bunzip2
# Postscript,pdf,dvi.....
complete -f -o default -X '!*.ps'  gs ghostview ps2pdf ps2ascii
complete -f -o default -X '!*.dvi' dvips dvipdf xdvi dviselect dvitype
complete -f -o default -X '!*.pdf' acroread pdf2ps
complete -f -o default -X '!*.+(pdf|ps)' gv
complete -f -o default -X '!*.texi*' makeinfo texi2dvi texi2html texi2pdf
complete -f -o default -X '!*.tex' tex latex slitex
complete -f -o default -X '!*.lyx' lyx
complete -f -o default -X '!*.+(htm*|HTM*)' lynx html2ps
# Multimedia
complete -f -o default -X '!*.+(jp*g|gif|xpm|png|bmp)' xv gimp
complete -f -o default -X '!*.+(mp3|MP3)' mpg123 mpg321
complete -f -o default -X '!*.+(ogg|OGG)' ogg123

complete -f -o default -X '!*.pl'  perl perl5

# This is a 'universal' completion function - it works when commands have
# a so-called 'long options' mode , ie: 'ls --all' instead of 'ls -a'

_get_longopts () 
{ 
    $1 --help | sed  -e '/--/!d' -e 's/.*--\([^[:space:].,]*\).*/--\1/'| \
grep ^"$2" |sort -u ;
}

_longopts_func ()
{
    case "${2:-*}" in
	-*)	;;
	*)	return ;;
    esac

    case "$1" in
	\~*)	eval cmd="$1" ;;
	*)	cmd="$1" ;;
    esac
    COMPREPLY=( $(_get_longopts ${1} ${2} ) )
}
complete  -o default -F _longopts_func configure bash
complete  -o default -F _longopts_func wget id info a2ps ls recode


_make_targets ()
{
    local mdef makef gcmd cur prev i

    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}

    # if prev argument is -f, return possible filename completions.
    # we could be a little smarter here and return matches against
    # `makefile Makefile *.mk', whatever exists
    case "$prev" in
        -*f)    COMPREPLY=( $(compgen -f $cur ) ); return 0;;
    esac

    # if we want an option, return the possible posix options
    case "$cur" in
        -)      COMPREPLY=(-e -f -i -k -n -p -q -r -S -s -t); return 0;;
    esac

    # make reads `makefile' before `Makefile'
    if [ -f makefile ]; then
        mdef=makefile
    elif [ -f Makefile ]; then
        mdef=Makefile
    else
        mdef=*.mk               # local convention
    fi

    # before we scan for targets, see if a makefile name was specified
    # with -f
    for (( i=0; i < ${#COMP_WORDS[@]}; i++ )); do
        if [[ ${COMP_WORDS[i]} == -*f ]]; then
            eval makef=${COMP_WORDS[i+1]}      # eval for tilde expansion
            break
        fi
    done

        [ -z "$makef" ] && makef=$mdef

    # if we have a partial word to complete, restrict completions to
    # matches of that word
    if [ -n "$2" ]; then gcmd='grep "^$2"' ; else gcmd=cat ; fi

    # if we don't want to use *.mk, we can take out the cat and use
    # test -f $makef and input redirection
    COMPREPLY=( $(cat $makef 2>/dev/null | \
    awk 'BEGIN {FS=":"} /^[^.#   ][^=]*:/ {print $1}' \
    | tr -s ' ' '\012' | sort -u | eval $gcmd ) )
}

complete -F _make_targets -X '+($*|*.[cho])' make gmake pmake

_killall ()
{
    local cur prev
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}

    # get a list of processes (the first sed evaluation
    # takes care of swapped out processes, the second
    # takes care of getting the basename of the process)
    COMPREPLY=( $( /usr/bin/ps -u $USER -o comm  | \
        sed -e '1,1d' -e 's#[]\[]##g' -e 's#^.*/##'| \
        awk '{if ($0 ~ /^'$cur'/) print $0}' ))

    return 0
}

complete -F _killall killall killps


# A meta-command completion function for commands like sudo(8), which
# need to first complete on a command,
# then complete according to that command's own
# completion definition - currently not quite foolproof
# (e.g. mount and umount don't work properly),
# but still quite useful --
# By Ian McDonald, modified by me.

_my_command()
{
    local cur func cline cspec
    
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}

    if [ $COMP_CWORD = 1 ]; then
	COMPREPLY=( $( compgen -c $cur ) )
    elif complete -p ${COMP_WORDS[1]} &>/dev/null; then
	cspec=$( complete -p ${COMP_WORDS[1]} )
	if [ "${cspec%%-F *}" != "${cspec}" ]; then
	    # complete -F <function>
	    #
	    # COMP_CWORD and COMP_WORDS() are not read-only,
	    # so we can set them before handing off to regular
	    # completion routine
	
	    # set current token number to 1 less than now
	    COMP_CWORD=$(( $COMP_CWORD - 1 ))
	    # get function name
	    func=${cspec#*-F }
	    func=${func%% *}
	    # get current command line minus initial command
	    cline="${COMP_LINE#$1 }"
	    # split current command line tokens into array
		COMP_WORDS=( $cline )
	    $func $cline
	elif [ "${cspec#*-[abcdefgjkvu]}" != "" ]; then
          # complete -[abcdefgjkvu]
          #func=$( echo $cspec | sed -e 's/^.*\(-[abcdefgjkvu]\).*$/\1/' )
          func=$( echo $cspec | sed -e 's/^complete//' -e 's/[^ ]*$//' )
	    COMPREPLY=( $( eval compgen $func $cur ) )
	elif [ "${cspec#*-A}" != "$cspec" ]; then
	    # complete -A <type>
	    func=${cspec#*-A }
	func=${func%% *}
	COMPREPLY=( $( compgen -A $func $cur ) )
	fi
    else
	COMPREPLY=( $( compgen -f $cur ) )
    fi
}


complete -o default -F _my_command nohup exec eval \
trace truss strace sotruss gdb
complete -o default -F _my_command command type which man nice

# for tmux: export 256color
[ -n "$TMUX" ] && export TERM=xterm-256color

# Local Variables:
# mode:shell-script
# sh-shell:bash
# End:
