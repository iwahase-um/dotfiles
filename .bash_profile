if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

if [ -d /usr/local/mysql/ ]; then
	PATH=$PATH:/usr/local/mysql/bin
fi
#if [ -d /usr/local/mariadb-10.0.21/ ]; then
#	PATH=$PATH:/usr/local/mariadb/bin
#fi

export LC_CTYPE='ja_JP.UTF-8'
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLDlLIBRARY_PATH

export PATH=${PATH}:/Applications/Julia-1.0.app/Contents/Resources/julia/bin
