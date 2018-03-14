if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

case "$TERM" in
xterm*|kterm*|rxvt*)
;;
screen*)
    printf "\033P\033]0;ryo@iwahaseO\007\033\\"
    ## when terminal with screen
;;
esac

PATH=$HOME/bin:$PATH
export PATH
export GOPATH=$HOME/go

export PS1="[\@] \e[1;34m\u@\h\e[m \w > "
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad


alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ..='cd ..'
alias u='cd ..'
alias U='cd ..;ls'
alias ll='ls -l'
alias la='ls -aF'
alias lla='ls -al'
alias desktop='cd ~/Desktop'
alias tailf='tail -f'
alias updatedb='sudo /usr/libexec/locate.updatedb'
#alias furusatodir='cd ~/localdev/unimediainc/FS-furusato-wp'
#alias furusatowpcontdir='cd ~/localdev/unimediainc/FS-furusato-wp/wp-contents'
alias furusatodir='cd ~/localdev/iwahase-um/furusato'
alias furusatowpcontdir='cd ~/localdev/iwahase-um/furusato/wp-contents'
alias jokerzdir='cd ~/localdev/jokerz'

#alias furusatoCTags='ctags -R --langmap=PHP:+.inc --php-kinds=cfd -a -f ~/.vim/tags/furusato.tags ~/localdev/iwahase-um/furusato/'
alias furusatoCTags='ctags -R --exclude=*furusato/office --exclude=*furusato/office_test --exclude=*furusato/subsite_sample --exclude=*.js --langmap=PHP:+.inc --php-kinds=cfd -a -f ~/.vim/tags/furusato.tags ~/localdev/iwahase-um/furusato/'
## make own command for Perl realated things 2012/12 ##
function pmmethodlist() {
	[ -n "$1" ] && perl -MDevel::Symdump -M$1 -MData::Dumper -e "print Dumper([ Devel::Symdump->new("$1")->functions ])"
}
# check the version of perl module
alias pmversion='perl -le '"'"' for $module (@ARGV) { eval "use $module"; print "$module ", ${"$module\::VERSION"} || "not found" } '"'"
# grep the source code of perl module
function pmgrep() {
	[ -n "$1" ] && [ -n "$2" ] && grep -C3 -n "$1" `perldoc -l $2` | less -r;
}
alias pod=perldoc
complete -C perldoc-complete -o nospace -o default pod
alias pm_syntax_check='find ./ -type f -name "*pm" -exec perl -cw {} \; 2>&1 | grep "compilation errors"'
alias PL5LIB='echo $PERL5LIB'

## Docker for WP-kusanagi env 
## Docker Machine  kusanagi-machine has  192.168.99.100
#eval "$(docker-machine env kusanagi-machine)"
#DOCKER_IP=`docker-machine ip kusanagi-machine`
## mac 再起動とかのたびに必要なので alias
alias adddockerroute="sudo route add -net 172.17.0.0/16 $DOCKER_IP"
alias dockerip="docker ps -q | xargs docker inspect --format='{{.NetworkSettings.IPAddress}} -- {{.Name}}'"
# docker-machine って打つのめんどいので alias
alias dm='docker-machine'
alias dsk='docker-machine stop kusanagi-machine'

# modified 2016/07/08 git and branch matter
function parse_git_branch {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	echo "("${ref#refs/heads/}")"
}

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"

# PS1="$RED\$(date +%H:%M) \w\$(parse_git_branch)$GREEN\$ "
#PS1="[\t \u@\h:\w]\n\$(parse_git_branch)\$"
PS1="[\t \u@:\w]\$(parse_git_branch)\$"
# modified 2016/07/08 git and branch matter

function stg26p {
	PW="passphrase"
	expect -c "
	set timeout 5
	spawn env LANG=C /usr/bin/ssh stg_furupure
	expect \"Enter passphrase for key '/Users/iwahase_ryo/.ssh/id_rsa':\"
	send \"${PW}\n\"
	expect \"$\"
	interact
	exit 0
	"
}

function stg26pmysql {
	PW="passphrase"
	COMMAND="/usr/bin/mysql -h localhost -pPASSWORD -udbuser DBNAME --auto-rehash"
	expect -c "
	set timeout 5
	spawn env LANG=C /usr/bin/ssh stg_furupure
	expect \"Enter passphrase for key '/Users/iwahase_ryo/.ssh/id_rsa':\"
	send \"${PW}\n\"
	expect \"$\"
	send \"${COMMAND}\n\"
	expect \"MariaDB\"
	interact
	exit 0
	"
}

alias sl='serverlist.sh'
alias ssh_mysql_26p='screen -X eval "screen -t 26pMySQL 26pmysql.sh"'
alias ssh_mysql_stg26p='screen -X eval "screen -t STG26pMySQL stg26pmysql.sh"'
alias ssh_stg26p='ssh stg_furupure'
alias ssh_26p='ssh furupure'

alias vimtips='/usr/bin/vim -R ~/docs/mydocs/vimtips'
alias gittips='/usr/bin/vim -R ~/docs/mydocs/gittips'


## add 2016/08/18 git 補完
#source ~/.git-completion.bash

