#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo
#-----------------------------------------------------------------------------------------#

#-----------------------------Шапка скрипта-----------------------------------------#
echo " $(printBMagenta '=|    Дата    |========================================')"
#-----------------------------------------------------------------------------------#

#-----------------------------Лента новостей-----------------------------------------#
	echo " $(printBMagenta '=')""$(printBYellow '| 13.07.2023 |') Shardeum update Sphinx Validator 1.5.2 "
	echo " $(printBMagenta '=')""$(printBYellow '| 03.07.2023 |') Shardeum update Sphinx Validator 1.5.1 "
	echo " $(printBMagenta '=')""$(printBYellow '| 29.06.2023 |') Starknet update validator v6.3."
	echo " $(printBMagenta '=')""$(printBYellow '| 22.06.2023 |') Shardeum! Добавлен автоматический запуск валидатора."
	echo " $(printBMagenta '=')""$(printBYellow '| 19.06.2023 |') Добавлен смартконтракт zkSync в раздел смартконтрактов."
	echo " $(printBMagenta '=')""$(printBYellow '| 16.06.2023 |') Добален просмотр IP сервера в основном меню."
	echo " $(printBMagenta '=')""$(printBYellow '| 14.06.2023 |') Переделано основное меню, добавлены смартконтракты"
	echo " $(printBMagenta '=')""$(printBYellow '| 12.06.2023 |') Добалена установка и запуск прокси на сервере"
	echo " $(printBMagenta '=')""$(printBYellow '| 11.06.2023 |') Добавлен системный монитор"
#-----------------------------------------------------------------------------------#
echo " $(printBMagenta '=|            |========================================')"
#-----------------------------------------------------------------------------------#

#-----------------------------Основное меню-----------------------------------------#
	mainmenu() { 
		echo
		echo "$(printBCyan '              <--') $(printBGreen    '1)')  Назад"

		echo "$(printBRed        '                  0)  Выход')"
		echo
		echo -ne "$(printBGreen ' Введите цифру:') $(printYellowBlink '-->') "
	#-------------------------Свойства меню-------------------------#
		read -r ans
			case $ans in
			#----------Назад---------#
				1)
				back
				;;
			#----------Выход---------#
				0)
				echo $(printBCyan '	"Bye bye."') && exit
				;;
			#----------Неверный запрос---------#
				*)
				clear && printLogo
				echo " $(printCyanBlink '                 =====================')"
				echo " $(printRed  '================')$(printCyanBlink ' = ')$(printBRed 'Неверный запрос! ')$(printCyanBlink ' = ')$(printRed  '================')"
				echo " $(printCyanBlink '                 =====================')"
				mainmenu
				;;
			#-------------------#
		esac
		}

	back(){
	./x-l1bra
	}
#-----------------------------------------------------------------------------------------#
mainmenu
