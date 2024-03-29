#!/bin/bash
###############          ШАПКА
    clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh) && printLogo && printelixir
echo
docker kill ev
docker rm ev
docker pull elixirprotocol/validator:testnet-2
docker build . -f Dockerfile -t elixir-validator
docker run -d --restart unless-stopped --name ev elixir-validator

mainmenu


mainmenu(){
	echo -ne "
    $(printBCyan '	Обновление завершено:')  "
	$(printBCyan '	Для возврата нажмите Enter:')  "
		read -r ans
		case $ans in
			*)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/elixir/main.sh)
			;;
	esac
}
