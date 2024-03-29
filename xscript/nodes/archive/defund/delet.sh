#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printdefund
#-----------------------------------------------------------------------------------------#

mainmenu() {
    echo -ne "
      $(printBYellow    'Пожалуйста, прежде чем перейти к следующему шагу! ')
      $(printBRed    'Все данные цепочки будут потеряны! ')
      $(printBRed    'Убедитесь, что вы сохранили свой priv_validator_key.json! ')

	  $(printBRed    'Вы действительно хотите удалить DeFund ') $(printBRedBlink '!!!')
	  
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
		printlogo
		printdefund
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

no(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/archive/defund/main.sh)
}

yes(){
clear
printlogo
printdefund
echo -ne "	

$(printBYellow 'Удаляем.....!')"
cd $HOME
sudo systemctl stop defundd
sudo systemctl disable defundd
sudo rm /etc/systemd/system/defundd.service
sudo systemctl daemon-reload
rm -f $(which defundd)
rm -rf $HOME/.defund
rm -rf $HOME/defund
submenu
}

submenu(){
	echo -ne "
	$(printBGreen    'DeFund полностью удален с вашего сервера ')$(printBGreenBlink '!!!')
	
	Нажмите Enter:  "
	read -r ans
	case $ans in
		*)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/archive/defund/main.sh)
		;;
	esac
}


mainmenu


