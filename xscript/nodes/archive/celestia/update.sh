#! /bin/bash

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printCelestia
#-----------------------------------------------------------------------------------------#
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/archive/celestia/main.sh)

# printLogo
# printnibiru
# echo
# var3=v0.11.0
# var4=`celestia-appd version | cut -d ' ' -f 3`

# if [[ "$var3" == "$var4" ]]; then
#  echo -ne "$(printBGreen '	У вас уже установлена последняя версия!')"
#  mainmenu
# else
#  	update
#  	submenu
# fi


# update(){
# sudo systemctl stop celestia-appd

# # set necessary vars
# CHAIN_ID="mocha"
# MONIKER=$(cat "$HOME/.celestia-app/config/config.toml" | grep moniker | grep -oP 'moniker = "\K[^"]+')

# # backup priv_validator_key.json from mamaki (optional)
# cp $HOME/.celestia-app/config/priv_validator_key.json $HOME/priv_validator_key.json.backup

# # remove mamaki testnet data
# rm -rf $HOME/.celestia-app
# rm -rf $HOME/celestia-app
# rm -rf networks
# sudo rm "$(which celestia-appd)"

# # install mocha testnet
# cd $HOME || return
# rm -rf celestia-app
# git clone https://github.com/celestiaorg/celestia-app.git
# cd celestia-app || return
# git checkout v0.11.0
# make install
# celestia-appd version # 0.11.0

# celestia-appd config keyring-backend test
# celestia-appd config chain-id $CHAIN_ID
# celestia-appd init "$MONIKER" --chain-id $CHAIN_ID

# curl -s https://raw.githubusercontent.com/celestiaorg/networks/master/mocha/genesis.json > $HOME/.celestia-app/config/genesis.json
# sha256sum $HOME/.celestia-app/config/genesis.json # 05ef265e16f37d1f5aa2ec884be3782c38d71e59a6d57957235c5ca433aa8e05

# sed -i 's|^minimum-gas-prices *=.*|minimum-gas-prices = "0.0001utia"|g' $HOME/.celestia-app/config/app.toml

# seeds=$(curl -sL https://raw.githubusercontent.com/celestiaorg/networks/master/mocha/seeds.txt | tr -d '\n')
# peers=$(curl -sL https://raw.githubusercontent.com/celestiaorg/networks/master/mocha/peers.txt | tr -d '\n')
# sed -i -e 's|^seeds *=.*|seeds = "'$seeds'"|; s|^persistent_peers *=.*|persistent_peers = "'$peers'"|' $HOME/.celestia-app/config/config.toml

# # in case of pruning
# sed -i 's|pruning = "default"|pruning = "custom"|g' $HOME/.celestia-app/config/app.toml
# sed -i 's|pruning-keep-recent = "0"|pruning-keep-recent = "100"|g' $HOME/.celestia-app/config/app.toml
# sed -i 's|pruning-interval = "0"|pruning-interval = "17"|g' $HOME/.celestia-app/config/app.toml

# # restore priv_validator_key.json from mamaki (optional)
# cp $HOME/priv_validator_key.json.backup $HOME/.celestia-app/config/priv_validator_key.json
# }

# mainmenu(){
# 	echo -ne "
# 	$(printBCyan '	Для возврата нажмите Enter:')  "
# 		read -r ans
# 		case $ans in
# 			*)
# 			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/celestia/main.sh)
# 			;;
# 	esac
# }

# submenu(){
# 	echo -ne "
# 	$(printBGreen '	Обновление завершено!')
# 	$(printBCyan '	Для возврата нажмите Enter:')  "
# 		read -r ans
# 		case $ans in
# 			*)
# 			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/celestia/main.sh)
# 			;;
# 	esac
# }