#! /bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printnibiru
mainmenu() { echo -ne "

		$(printBCyan ' -->') $(printBCyan    '1) Управление')

		$(printBCyan ' -->') $(printBGreen    '2) Установить')
		$(printBCyan ' -->') $(printBYellow    '3) Обновить')
		$(printBCyan ' -->') $(printBRed    '4) Удалить')

		$(printBBlue ' <-- 5) Назад')
		$(printBRed        '     0) Выход')

 	Введите цифру: "

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
		echo $(printBCyan '"Bye bye."')
		exit
		;;
		*)
		clear
		printLogo
		printnibiru
		echo $(printRed 'Неверный запрос !')
		;;
	esac
}

install(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/install.sh)
}

control(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/control.sh)
}

update(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/update.sh)
}

delet(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/delet.sh)
}

back(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/Menu/menu.sh)
}

mainmenu