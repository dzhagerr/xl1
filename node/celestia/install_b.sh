#! /bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printcelestia
echo -ne "
	$(printGreen  '-----------------------------------------')
	  $(printYellow 'Минимальные требования к оборудованию.')
		     $(printBCyan '4CPU 8RAM 200GB')
	$(printGreen  '-----------------------------------------')
	$(printYellow 'Рекомендуемые требования к оборудованию.')
		     $(printBCyan '8CPU 16RAM 500GB')
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
		printLogo
		printcelestia
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
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
echo
echo
read -r -p "Enter node moniker:" MONIKER


printBCyan "Пожалуйста подождите........" && sleep 1
printYellow "1. Oбновляем наш сервер........" && sleep 1
	sudo apt update > /dev/null 2>&1
printGreen "Готово!" && sleep 1


printYellow "2. Устанавливаем дополнительные пакеты........" && sleep 1
	sudo apt install -y make clang pkg-config libssl-dev build-essential git gcc lz4 chrony unzip curl jq ncdu htop net-tools lsof fail2ban wget -y > /dev/null 2>&1
printGreen "Готово!" && sleep 1


printYellow "3. Задаем переменные........" && sleep 1
CHAIN_ID="mocha"
CHAIN_DENOM="utia"
BINARY_NAME="celestia-appd"
BINARY_VERSION_TAG="v0.11.0"
IDENTITY="8F3C23EC3306B513"
echo -e "Node moniker:       ${CYAN}$MONIKER${NC}"
echo -e "Chain id:           ${CYAN}$CHAIN_ID${NC}"
echo -e "Chain demon:        ${CYAN}$CHAIN_DENOM${NC}"
echo -e "Binary version tag: ${CYAN}$BINARY_VERSION_TAG${NC}"
echo -e "IDENTITY:           ${CYAN}$IDENTITY${NC}"
printGreen "Готово!" && sleep 1


printYellow "4. Устанавливаем go........" && sleep 1
	source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/scripts/go_1.19.4.sh)
echo "$(go version)"
printGreen "Готово!" && sleep 1


printYellow "5. Скачиваем и устанавливаем бинарник........"
	cd $HOME || return
	rm -rf celestia-app
	git clone https://github.com/celestiaorg/celestia-app.git
	cd celestia-app || return
	git checkout v0.11.0
	make install
	celestia-appd version # 0.11.0
printGreen "Готово!" && sleep 1


printYellow "6. Инициализируем ноду........" && sleep 1
	celestia-appd config keyring-backend test
	celestia-appd config chain-id $CHAIN_ID
	celestia-appd init "$MONIKER" --chain-id $CHAIN_ID
	curl -s https://raw.githubusercontent.com/celestiaorg/networks/master/mocha/genesis.json > $HOME/.celestia-app/config/genesis.json
	curl -s https://snapshots3-testnet.nodejumper.io/celestia-testnet/addrbook.json > $HOME/.celestia-app/config/addrbook.json
printGreen "Готово!" && sleep 1


printYellow "7. Добавляем сиды и пиры........" && sleep 1
SEEDS=$(curl -sL https://raw.githubusercontent.com/celestiaorg/networks/master/mocha/seeds.txt | tr -d '\n')
PEERS=$(curl -sL https://raw.githubusercontent.com/celestiaorg/networks/master/mocha/peers.txt | tr -d '\n')
	sed -i 's|^seeds *=.*|seeds = "'$SEEDS'"|; s|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.celestia-app/config/config.toml
printGreen "Готово!" && sleep 1

printYellow "8. Настраиваем прунинг........" && sleep 1
PRUNING_INTERVAL=$(shuf -n1 -e 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97)
	sed -i 's|^pruning *=.*|pruning = "custom"|g' $HOME/.celestia-app/config/app.toml
	sed -i 's|^pruning-keep-recent  *=.*|pruning-keep-recent = "100"|g' $HOME/.celestia-app/config/app.toml
	sed -i 's|^pruning-interval *=.*|pruning-interval = "'$PRUNING_INTERVAL'"|g' $HOME/.celestia-app/config/app.toml
	sed -i 's|^snapshot-interval *=.*|snapshot-interval = 2000|g' $HOME/.celestia-app/config/app.toml
	sed -i 's|^minimum-gas-prices *=.*|minimum-gas-prices = "0.0001utia"|g' $HOME/.celestia-app/config/app.toml
	sed -i 's|^prometheus *=.*|prometheus = true|' $HOME/.celestia-app/config/config.toml
printGreen "Готово!" && sleep 1


printYellow "9. Cоздаем сервис файл........"
sudo tee /etc/systemd/system/celestia-appd.service > /dev/null << EOF
[Unit]
Description=Celestia Validator Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which celestia-appd) start
Restart=on-failure
RestartSec=10
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
EOF
printGreen "Готово!" && sleep 1


#printYellow "11. Подгружаем последний снапшот........"
#celestia-appd tendermint unsafe-reset-all --home $HOME/.celestia-app --keep-addr-book
#SNAP_NAME=$(curl -s https://snapshots3-testnet.nodejumper.io/celestia-testnet/ | egrep -o ">mocha.*\.tar.lz4" | tr -d ">")
#curl https://snapshots3-testnet.nodejumper.io/celestia-testnet/${SNAP_NAME} | lz4 -dc - | tar -xf - -C $HOME/.celestia-app
#printGreen "Готово."

printYellow "10. Запускаем ноду........" && sleep 2
sudo systemctl daemon-reload
sudo systemctl enable celestia-appd
sudo systemctl start celestia-appd

printGreen "Готово!"
printBCyan "УСТАНОВКА ЗАВЕРШЕНА"

printRed  =============================================================================== 
	echo -e "X-l1bra:                   ${CYAN} https://t.me/xl1bra ${NC}"
printRed  =============================================================================== 

submenu

}


submenu(){
echo -ne "
$(printGreen    'Установка завершена.')
		1) Просмотреть логи
		2) Проверить синхронизацию
		3) В меню
Нажмите Enter:  "
	read -r ans
	case $ans in
		1) 
		subsubmenu
		;;

		2)
		echo
		curl -s localhost:26657/status
		submenu
		;;

		3) 
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/celestia/main.sh)
		;;

		*)
		clear
		printLogo
		printcelestia
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

subsubmenu(){
	echo -ne "
	$(printYellow    'Для того что бы остановить журнал логов надо нажать') $(printBCyan 'CTRL+Z') $(printYellow '!!!')
	$(printBCyan 'Для продолжения нажмите Enter:')  "
		read -r ans
		case $ans in
			*)
		sudo journalctl -u celestia-appd -f --no-hostname -o cat
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/celestia/main.sh)
		;;
	esac
}


mainmenu