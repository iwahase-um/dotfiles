#/bin/sh
# server list == sl
function menu {
	# メニューカーソルの位置
	choice=0
	# メニューを配列でずらっと
	menu=(
    "RUN COMMAND:Update GS(MonthlyOrderSummaryDetail)"
    "\e[36mNW\e[m kusanagi@kusanagi71"
	"\e[36mNW\e[m RDS@db-furusato"
	"\e[36mNW\e[m RDS@db-furusato[READ ONLY]"
	"\e[36mNW\e[m RDS@db-furusato-stg"
	"\e[36mNW\e[m RDS@db-furusato-dev"
	"\e[36mNW\e[m rvuser@bfurusato"
	"\e[36mNW\e[m rvuser@wfurusato1"
	"\e[36mNW\e[m rvuser@wfurusato2"
	"\e[36mNW\e[m rvuser@wfurusato3"
	"\e[36mNW\e[m rvuser@wfurusato4"
	"\e[36mNW\e[m rvuser@wfurusato5"
	"\e[36mNW\e[m iwahase@batch-furusato"
	"\e[36mNW\e[m iwahase@app-furusato1"
	"\e[36mNW\e[m iwahase@app-furusato2"
	"\e[36mNW\e[m iwahase@app-furusato3"
	"\e[36mNW\e[m iwahase@app-furusato-stg"
	"\e[36mNW\e[m iwahase@app-furusato-dev"
    "kusanagi@kusanagi71"
	"RDS@db-furusato"
	"RDS@db-furusato[READ ONLY]"
	"RDS@db-furusato-stg"
	"RDS@db-furusato-dev"
	"rvuser@bfurusato"
	"rvuser@wfurusato1"
	"rvuser@wfurusato2"
	"rvuser@wfurusato3"
	"rvuser@wfurusato4"
	"rvuser@wfurusato5"
	"iwahase@batch-furusato"
	"iwahase@app-furusato1"
	"iwahase@app-furusato2"
	"iwahase@app-furusato3"
	"iwahase@app-furusato-stg"
	"iwahase@app-furusato-dev"
	)

	commands=(
    'updateGS.sh'
    'screen -X eval "screen -t kusanagi71 ssh furupure"'
	'screen -X eval "screen -t RDS-furusato amz.26pmysql.sh"'
	'screen -X eval "screen -t RDS-furusato[RO] amz.26pmysqlRO.sh"'
	'screen -X eval "screen -t RDS-furusato-stg amz.stg26pmysql.sh"'
	'screen -X eval "screen -t RDS-furusato-dev amz.dev26pmysql.sh"'
	'screen -X eval "screen -t bfurusato ssh bfurusato"'
	'screen -X eval "screen -t wfurusato1 ssh wfurusato1"'
	'screen -X eval "screen -t wfurusato2 ssh wfurusato2"'
	'screen -X eval "screen -t wfurusato3 ssh wfurusato3"'
	'screen -X eval "screen -t wfurusato4 ssh wfurusato4"'
	'screen -X eval "screen -t wfurusato5 ssh wfurusato5"'
    'screen -X eval "screen -t batch-furusato ssh batch-furusato"'
	'screen -X eval "screen -t app-furusato1 ssh app-furusato1"'
	'screen -X eval "screen -t app-furusato2 ssh app-furusato2"'
	'screen -X eval "screen -t app-furusato3 ssh app-furusato3"'
	'screen -X eval "screen -t app-furusato-stg ssh app-furusato-stg"'
	'screen -X eval "screen -t app-furusato-dev ssh app-furusato-dev"'
    'ssh furupure'
	'amz.26pmysql.sh'
	'amz.26pmysqlRO.sh'
	'amz.stg26pmysql.sh'
	'amz.dev26pmysql.sh'
	'ssh bfurusato'
	'ssh wfurusato1'
	'ssh wfurusato2'
	'ssh wfurusato3'
	'ssh wfurusato4'
	'ssh wfurusato5'
    'ssh batch-furusato'
	'ssh app-furusato1'
	'ssh app-furusato2'
	'ssh app-furusato3'
	'ssh app-furusato-stg'
	'ssh app-furusato-dev'
	)
    cowsaycmd="/usr/local/bin/cowsay -f bud-frogs furusato web database batch servers"
	tail=`expr ${#menu[@]} - 1` # メニューの末尾番号
    eval $cowsaycmd
	printf "\e[32mReady to Access\e[m \e[36mNW\e[m:\e[1mNew Window\e[m\n"  >&2 # 緑色で "choose one"
	# 下のループの先頭でメニューの数だけ上ってくるので、
	# メニューの数だけ下改行しておく
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
			# メニューをprintし、graphic modeを閉じる
			printf "${menu[$i]}\e[m\n" >&2
		done
	
		# 一文字入力を読む
		read -sn1 answer
		# エスケープコードが打たれたら
		if [ "$answer" = "^[" ]; then # (^[はctrl+V ctrl+[とかで入力してね)
			# 残りのエスケープコードを読む
			read -sn2 answer
			# アローキーなら^[[A, B, C, Dってなるよ
		fi
		case $answer in
			"j"|"[B")
				# j, 下アローキーで下に移動（choice+1）
				# choiceの最大値はメニュー配列の末尾番号なので超えないように
				if [ $choice -lt $tail ]; then choice=`expr $choice + 1`; fi
				;;
			"k"|"[A")
				# k, 上アローキーで上に移動（choice-1）
				# choiceの最小値は0なので超えないように
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

