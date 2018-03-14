#/bin/sh
# サーバーアクセスツール

function menu {
	# メニューカーソルの位置
	choice=0
	# メニューを配列
	menu=(
	"kusanagi@ftptest"
	"kusanagi@ftptest MySQL"
	"kusanagi@kusanagi"
	"kusanagi@kusanagi MySQL"
	)

	commands=(
	'screen -X eval "screen -t STG26p stg26p.sh"'
	'screen -X eval "screen -t STG26pMySQL stg26pmysql.sh"'
	'screen -X eval "screen -t 26p 26p.sh"'
	'screen -X eval "screen -t 26pMySQL 26pmysql.sh"'
	)
	tail=`expr ${#menu[@]} - 1` # メニューの末尾番号
	printf "\e[32mSERVER LIST Ready to Access\e[m\n"  >&2 # 緑色で "choose one"
	for _ in $(seq 0 $tail);do echo "";done
	
	# 無限ループ
	while true
	do
		# \e[<配列の長さ>A でメニューの数だけ上に移動
		printf "\e[${#menu[@]}A\e[m" >&2
	
		# メニューをそれぞれ出力する
		for i in $(seq 0 $tail);do
			if [ $choice = $i ]
			then # メニューが選択中なら
				# \e[1;31 (bold);(red)で
				# '> '
				# をprint
				# 続く文字列を \e[1;4 (bold);(underlined)にする
				printf "\e[1;31m>\e[m \e[1;4m" >&2
			else # メニューが選択中でなければ
				# 空白をprint
				printf "  " >&2
			fi
			printf "${menu[$i]}\e[m\n" >&2
		done
	
		# 一文字入力を読む
		read -sn1 answer
		if [ "$answer" = "^[" ]; then 
			read -sn2 answer
		fi
		case $answer in
			"j"|"[B")
				if [ $choice -lt $tail ]; then choice=`expr $choice + 1`; fi
				;;
			"k"|"[A")
				if [ $choice -gt 0 ]; then choice=`expr $choice - 1`; fi
				;;
			"")
				# 改行で決定
				echo ${menu[$choice]}
				eval ${commands[$choice]}
				return
				;;
		esac
	done
}

menu

