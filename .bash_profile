# linux
case $OSTYPE in
linux*)
	export PATH=/usr/local/bin:/usr/local/sbin:/bin:/usr/bin:/sbin:/usr/sbin:$HOME/bin:/usr/X11R6/bin
	;;
solaris*)
	export PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin:$HOME/bin:/usr/ccs/bin:/usr/ucb:/usr/bin/i86:/usr/openwin/bin
	export MANPATH=/usr/local/man:/usr/share/man:/usr/man
	;;
*)
	export PATH=/usr/local/bin:/usr/local/sbin:/bin:/usr/bin:/sbin:/usr/sbin:$HOME/bin:/usr/X11R6/bin
	;;
esac

export BASH_ENV=$HOME/.bashrc
export USERNAME=""
export MIBS=ALL
export CVS_RSH="ssh"
export CVSROOT=":ext:pdekker@gist.offix:/src/master"
export LYNX_CFG=$HOME/.lynx_config
export HOST=${HOSTNAME/.musicmatch.com/}
export RPMFTP=ftp://mirrors.kernel.org/redhat/redhat/linux/9/en/os/i386/RedHat/RPMS
EDITOR=vim
export EDITOR
umask 022
#PS1="[\t] \u@\h \# \$ "

[ -f ~/.bashrc ] && . ~/.bashrc
