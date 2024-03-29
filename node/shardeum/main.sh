#! /bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printshardium
#
mainmenu() { echo -ne "
		$(printBCyan ' -->') $(printBGreen    '1) Управление')

		$(printBCyan ' -->') $(printBGreen    '2) Установить')
		$(printBCyan ' -->') $(printBYellow   '3) Обновить Validator')
		$(printBCyan ' -->') $(printBYellow   '4) Обновить CLI/GUI')

		$(printBCyan ' -->') $(printBRed    '5) Удалить')

		$(printBBlue ' <-- 6) Назад')
		$(printBRed        '     0) Выход')

 	Введите цифру: "

read -r ans
	case $ans in
		1)
		control
		;;

		2)
		install
		;;

		3)
		update
		;;

		4)
		updatecli
		;;

		5)
		delet
		;;

		6)
		back
		;;
		
		0)
		echo $(printBCyan '"Bye bye."')
		rm x-l1bra
		exit
		;;
		*)
		clear
		printLogo
		printshardium
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

install(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/shardeum/install.sh)
}

control(){
	source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/shardeum/control.sh)
}

delet(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/shardeum/delet.sh)
}

back(){
./x-l1bra
}

updatecli(){
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli update"
	mainmenu
}


#--------------ОБНОВЛЕНИЕ 1.1.6
update(){
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
	printLogo
	printshardium
	cd $HOME
	curl -O https://gitlab.com/shardeum/validator/dashboard/-/raw/main/installer.sh && chmod +x installer.sh && ./installer.sh
	echo -ne "
			    $(printBGreen    'Обновление завершено!')
			    Далее нужно выйти из скрипта и выполнить команды по очереди:
			    
			    $(printBYellow 'cd .shardeum && ./shell.sh')
			    
			    $(printBYellow 'operator-cli gui start')
			    
			    $(printBYellow 'operator-cli start')

			    Проверить работу ноды можно командой:
			    $(printBYellow 'pm2 list')"

	mainmenu

}


mainmenu