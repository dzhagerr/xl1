#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printstarknet
#-----------------------------------------------------------------------------------------#
#СИСТЕМНЫЕ ТРЕБОВАНИЯ
echo -ne "
	$(printGreen  '-----------------------------------------')
	  $(printYellow 'Минимальные требования к оборудованию.')
 	$(printBCyan '| CPU: 2+ cores | RAM: 4 GB | Disk: 600 GB |')
	$(printGreen  '-----------------------------------------')
	  $(printYellow 'Рекомендуемые требования к оборудованию.')
 	$(printBCyan '| CPU: 4+ cores | RAM: 16 GB+ | Disk 2 TB |')
	$(printGreen  '-----------------------------------------')"
echo

mainmenu() {
	echo -ne "
	$(printCyan	'Вы действительно хотите начать установку') $(printCyanBlink '???')
	$(printGreen	' 1) Да')
	$(printRed	' 2) Нет')
	$(printCyan	'Введите цифру:') "
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
		printstarknet
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
        	;;
    esac
}


no(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/starknet/main.sh)
}
yes(){
clear
printlogo
printstarknet
echo

printBCyan "Пожалуйста подождите........" && sleep 1
printYellow "1. Oбновляем наш сервер........" && sleep 1
	sudo apt update && sudo apt upgrade --yes > /dev/null 2>&1
printGreen "Готово!" && sleep 1


printYellow "2. Устанавливаем дополнительные пакеты........" && sleep 1
sudo apt install curl git build-essential libssl-dev libffi-dev libgmp-dev  pkg-config  -y
printGreen "Готово!" && sleep 1


printYellow "3. Устанавливаем Rust........" && sleep 1
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo apt install cargo -y
source $HOME/.cargo/env
rustup update stable
printGreen "Готово!" && sleep 1

# printYellow "4. Устанавливаем Python........" && sleep 1
# sudo apt install python3.9 python3.9-venv python3.9-dev -y
# sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
# sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 2
# update-alternatives --list python3
# sudo update-alternatives --config python3
# printGreen "Готово!" && sleep 1

printYellow "5. Клонируем репозиторий с github........" && sleep 1
cd pathfinder
git clone --branch v0.8.2 https://github.com/eqlabs/pathfinder.git
printGreen "Готово!" && sleep 1

printYellow "7. Собираем ноду........" && sleep 1

cd pathfinder
cargo build --release --bin pathfinder
printGreen "Готово!" && sleep 1

printYellow "8. Создаем сервис файл и запускаем нодуу........" && sleep 1

	echo -ne "
$(printCyan 'Вставте API KEY и нажмите Enter') "
	read -r API_KEY
	echo "export API_KEY="$API_KEY"" >> ~/.bash_profile && source ~/.bash_profile
	echo

sudo tee /etc/systemd/system/starknetd.service > /dev/null <<EOF
[Unit]
Description=StarkNet
After=network.target
[Service]
Type=simple
User=root
WorkingDirectory=/root/pathfinder
ExecStart=/root/.cargo/bin/cargo run --release --bin pathfinder -- --ethereum.url https://eth-mainnet.alchemyapi.io/v2/"$API_KEY"'
Restart=always
RestartSec=10
Environment=RUST_BACKTRACE=1
[Install]
WantedBy=multi-user.target
EOF


printYellow "9. Запускаем ноду........" && sleep 2
sudo systemctl daemon-reload
sudo systemctl enable starknetd
sudo systemctl start starknetd 
cd $HOME
printGreen "Готово!"

printRed  =============================================================================== 
	echo -e "X-l1bra:                   ${CYAN} https://t.me/xl1bra ${NC}"
printRed  =============================================================================== 

submenu

}



submenu(){
echo -ne "
	$(printBGreen    'УСТАНОВКА ЗАВЕРШЕНА........') $(printBGreenBlink '!!!')
	
 		1) Просмотреть логи
 		2) В меню
 		
	$(printBCyan 'Нажмите Enter:')  "
	read -r ans
	case $ans in
		
		1)
		subsubmenu
		;;

		2)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/starknet/main.sh)
		;;
		
		*)
		printlogo
		printstarknet
		echo
		echo $(printBRed '	Неверный запрос !!!')
		submenu
		;;

	esac
}

subsubmenu(){
	echo -ne "
	$(printYellow    'Для того что бы остановить журнал логов надо нажать') $(printBCyan 'CTRL+C') $(printYellow '!!!')
	$(printBCyan 'Для продолжения нажмите Enter:')  "
		read -r ans
		case $ans in
			*)
			journalctl -u starknetd -f -o cat
			submenu
			;;
	esac
}

mainmenu
