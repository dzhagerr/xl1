#! /bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printcelestia

mainmenu() {
    echo -ne "
    
	  $(printBRed    'Вы действительно хотите удалить Nibiru ') $(printBRedBlink '!!!')
	  
		$(printRed   '1) Да')
		$(printGreen '2) Нет')
		
	  $(printBCyan 'Введите цифру:') "
	read -r ans
	case $ans in
		1)
		yes
		;;
		2)
		no
		;;

		*)
		clear
		printLogo
		printcelestia
		echo -ne "
		
		    $(printRed '	Неверный запрос !')
		    "
		mainmenu
		;;
	esac
}

no(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/celestia/main.sh)
}

yes(){
clear
printLogo
printcelestia
echo -ne "	

$(printBYellow 'Удаляем.....!')"
systemctl stop celestia-appd.service && rm -rf /etc/systemd/system/celestia-appd.service && rm -rf celestia-app && rm -rf .celestia-app
submenu
}

submenu(){
	echo -ne "
	$(printBGreen    'Celestia полностью удалена с вашего сервера ')$(printBGreenBlink '!!!')
	
	Нажмите Enter:  "
	read -r ans
	case $ans in
		*)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/celestia/main.sh)
		;;
	esac
}


mainmenu
