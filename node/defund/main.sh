#! /bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printdefund
mainmenu() { echo -ne "

		$(printBCyan ' -->') $(printBCyan    '1) Управление')

		$(printBCyan ' -->') $(printBGreen    '2) Установить')
		$(printBCyan ' -->') $(printBYellow    '3) Обновить')
		$(printBCyan ' -->') $(printBRed    '4) Удалить')

		$(printBBlue ' <-- 5) Назад')
		$(printBRed        '     0) Выход')

	$(printCyan 'Введите цифру:')  "

read -r ans
	case $ans in
		1)
		control
		;;
		3)
		update
		;;
		2)
		install
		;;
		4)
		delet
		;;
		5)
		back
		;;
		0)
		echo $(printBCyan '	"Bye bye."')
		rm x-l1bra
		exit
		;;
		*)
		clear
		printLogo
		printdefund
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

install(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/defund/install.sh)
}

control(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/defund/control.sh)
}

update(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/defund/update.sh)
}

delet(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/defund/delet.sh)
}

back(){
./x-l1bra
}

mainmenu