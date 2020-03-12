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

#export PS1="[\@] \e[1;34m\u@\h\e[m \w > "
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

export LC_CTYPE='ja_JP.UTF-8'
alias cl='clear'
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

## Directory aliases BEGINS
## 旧ふるプレリポジトリ（オフィスは現役）
alias fpdir='cd /Users/iwahase_ryo/localdev/iwahase-um/furusato'
alias fpcontdir='cd /Users/iwahase_ryo/localdev/iwahase-um/furusato/wp-contents'
# 下記だと今までの作業ブランチがないから上記のディレクトリのままにする
#alias fpdir='cd /Users/iwahase_ryo/localdev/unimediainc/FS-furusato-wp'
#alias fpcontdir='cd /Users/iwahase_ryo/localdev/unimediainc/FS-furusato-wp/wp-contents'
alias jokerzdir='cd ~/localdev/jokerz'
# システム移行後のふるプレ開発リポジトリ（Rials）
alias fprailsdir='cd /Users/iwahase_ryo/localdev/unimediainc/FS-furupure-rails'
# ローカル環境ふるプレ開発リポジトリ（Rials）
alias fplocalrailsdir='cd /Users/iwahase_ryo/localdev/localdev.26p.jp/services/staging.26p.jp'
alias fpcsvdir='cd ~/docs/dev/26pjp/datas/csv'
alias giftcodecsvdir='cd /Users/iwahase_ryo/docs/dev/26pjp/datas/AmazonGiftCode'
alias RtoasterDataDir='cd ~/docs/dev/Web接客レコメンド/Rtoaster'
alias BlastMailCsvDir='cd ~/docs/dev/BlastMail/csv'
# 2020/03/05 頻繁に使用するテキスト系ファイルのシンボリックリンク格納ディレクトリ
alias scdir='cd ~/docs/shortcuts'
## Directory aliases ENDS

alias layoutscreen='screen -c ~/.screen/.screenrc.layout'
alias rmscreenall='screen -r -X quit' 

#alias furusatoCTags='ctags -R --langmap=PHP:+.inc --php-kinds=cfd -a -f ~/.vim/tags/furusato.tags ~/localdev/iwahase-um/furusato/'
alias furusatoCTags='ctags -R --exclude=*furusato/office --exclude=*furusato/office_test --exclude=*furusato/subsite_sample --exclude=*.js --langmap=PHP:+.inc --php-kinds=cfd -a -f ~/.vim/tags/furusato.tags ~/localdev/iwahase-um/furusato/'
# tags for perl tools
#alias localdevjokerzCTags='ctags -R --language-force=Perl --perl-types=c+f+p+s+d -a -f ~/.vim/tags/localdevjokerz.tags ~/localdev/jokerz/JKZ/'
alias localdevjokerzCTags='ctags -R --languages=Perl --perl-types=c+f+p+s+d -a -f ~/.vim/tags/localdevjokerz.tags /Users/iwahase_ryo/localdev/jokerz/JKZ/MyClass'

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

## COMMAND Aliases BEGINS
alias sl='fpsl.sh'
alias vimtips='/usr/bin/vim -R ~/docs/mydocs/vimtips'
alias gittips='/usr/bin/vim -R ~/docs/mydocs/gittips'
alias commandtips='/usr/bin/vim -R ~/docs/mydocs/commandtips'

# command to start local mysql server
function mysql.server() {
    arg="$1"
    sudo /usr/local/mysql/support-files/mysql.server $arg
}
alias localmysql='mysql -h localhost -uroot -p1qaz2wsx --auto-rehash'

alias updatedb='sudo /usr/libexec/locate.updatedb'
alias ldconfig-V='sudo update_dyld_shared_cache'

## COMMAND Aliases ENDS

## add 2016/08/18 git 補完
#source ~/.git-completion.bash


PATH="/Users/iwahase_ryo/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/iwahase_ryo/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/iwahase_ryo/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/iwahase_ryo/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/iwahase_ryo/perl5"; export PERL_MM_OPT;
## 2019/03/01 set local lib path
alias setPL5LIBLOCALENV='export PERL5LIB=/System/Library/Perl/5.18:/System/Library/Perl/Extras/5.18:$PERL5LIB:/Users/iwahase_ryo/localdev/jokerz/JKZ/MyClass'

## 2020/01/10 command for write out dot file(.gv) to your favorite file type
## file type could be [ pdf png jpg svg ps ]
## args are
## 1. dot file name without extension
## 2. new file type extension
## 3. -fn new file name if you want
## eg : my.dot mydot png will execute dot -Tpng mydot.gv -o mydot.png
#function my.dot() {
#  graphvizfile="$1"
#  newextension="$2"
#  execcmd=$(printf "dot -T%s %s -o %s.%s" $newextension $graphvizfile $graphvizfile $newextension ) 
#
#  echo "Going to Execute Command : $execcmd"
#  eval $execcmd
#  echo "Done"
#
###while getopts fn: ARG
###do
###    case $ARG in
###             fn) targetmonth=$OPTARG
###              ;;
###    esac
###done
##
#}
## 2020/02/10エラーがでるので一旦コメントアウト
#export -f my.dot

## ctagsの設定が今更うまく行かなかった原因判明
## 環境変数と登録パスが不十分だった
# PATHを設定して
#
# setPL5LIBLOCALENV
#
# 下記ライブラリ内を登録
# ctags -R --languages=Perl --perl-types=c+f+p+s+d -a -f ~/.vim/tags/localdevjokerz.tags /System/Library/Perl/5.18
# ctags -R --languages=Perl --perl-types=c+f+p+s+d -a -f ~/.vim/tags/localdevjokerz.tags /System/Library/Perl/Extras/5.18/darwin-thread-multi-2level
# ctags -R --languages=Perl --perl-types=c+f+p+s+d -a -f ~/.vim/tags/localdevjokerz.tags /System/Library/Perl/Extras/5.18
# これで localdev/jokerz/JKZ内更新
# ctags -R --languages=Perl --perl-types=c+f+p+s+d -a -f ~/.vim/tags/localdevjokerz.tags /Users/iwahase_ryo/localdev/jokerz/JKZ/MyClass
# set tags+=~/.vim/tags/localdevjokerz.tags

