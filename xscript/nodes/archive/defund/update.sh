#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printdefund
#-----------------------------------------------------------------------------------------#
echo
var3=0.2.5
var4=`defundd version | cut -d ' ' -f 3`

if [[ "$var3" == "$var4" ]]; then
 echo -ne "$(printBGreen '	У вас уже установлена последняя версия!')"
 mainmenu
else
	# update
	# submenu
systemctl stop defundd.service
cd $HOME
rm -rf defund
git clone https://github.com/defund-labs/defund.git
cd defund
git checkout v0.2.5

# Build binaries
make build

# Prepare binaries for Cosmovisor
mkdir -p $HOME/.defund/cosmovisor/upgrades/v0.2.5/bin
mv build/defundd $HOME/.defund/cosmovisor/upgrades/v0.2.5/bin/
rm -rf build
systemctl start defundd.service
mainmenu
fi


# update() {
# # Clone project repository
# cd $HOME
# rm -rf defund
# git clone https://github.com/defund-labs/defund.git
# cd defund
# git checkout v0.2.5

# # Build binaries
# make build

# # Prepare binaries for Cosmovisor
# mkdir -p $HOME/.defund/cosmovisor/upgrades/v0.2.5/bin
# mv build/defundd $HOME/.defund/cosmovisor/upgrades/v0.2.5/bin/
# rm -rf build
# submenu
# }

mainmenu(){
	echo -ne "
	$(printBGreen '	Обновление завершено!')
	$(printBCyan '	Для возврата нажмите Enter:')  "
		read -r ans
		case $ans in
			*)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/archive/defund/main.sh)
			;;
	esac
}

# submenu(){
# 	echo -ne "
# 	$(printBGreen '	Обновление завершено!')
# 	$(printBCyan '	Для возврата нажмите Enter:')  "
# 		read -r ans
# 		case $ans in
# 			*)
# 			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/defund/main.sh)
# 			;;
# 	esac
# }