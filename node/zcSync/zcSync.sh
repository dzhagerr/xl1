#!/bin/bash

	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
	printLogo
	printzcsync

	mainmenu() { echo -ne "

		$(printBCyan ' -->') $(printBCyan    '1) Создать смартконтракт')
		$(printBCyan ' -->') $(printBCyan    '2) Сделать деплой контракта')
		$(printBCyan ' -->') $(printBGreen   '3) Обновить закрытый ключ Metamask')
		$(printBCyan ' -->') $(printBRed     '4) Удалить')

		$(printBBlue ' <-- 5) Назад')
		$(printBRed        '     0) Выход')

	$(printCyan 'Введите цифру:')  "

read -r ans
	case $ans in

		1)
		createSmart
		;;

		2)
		deploy
		;;

		3)
		updateSmart
		;;

		4)
		delet
		;;
		
		5)
		back
		;;

		0)
		echo $(printBCyan '	"Bye bye."')
		exit
		;;
		
		*)
		clear
		printLogo
		printzcsync
		echo
		echo
		echo    -ne "$(printBRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;

	esac
}

delet(){
	clear && printLogo && printzcsync
		echo
		rm -rf $HOME/greeter-example
		echo
		echo -ne "		$(printBRed	'	  zcSync удален!')"
		echo
		mainmenu
}

back(){
./x-l1bra
}

deploy(){
	clear && printLogo && printzcsync
	echo
	echo 
	cd $HOME/greeter-example/greeter/deploy/
	npx hardhat deploy-zksync
	cd $HOME
	echo
	mainmenu
}

updateSmart(){
	clear && printLogo && printzcsync
	echo
	cd $HOME/greeter-example/greeter/deploy/
	rm deploy.ts
	read -r -p "  Введите закрытый ключ Metamask: " VAR1

cat << EOF > $HOME/greeter-example/greeter/deploy/deploy.ts
import { utils, Wallet } from "zksync-web3";
import * as ethers from "ethers";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { Deployer } from "@matterlabs/hardhat-zksync-deploy";

// An example of a deploy script that will deploy and call a simple contract.
export default async function (hre: HardhatRuntimeEnvironment) {
  console.log(`Running deploy script for the Greeter contract`);

  // Initialize the wallet.
  const wallet = new Wallet("$VAR1");

  // Create deployer object and load the artifact of the contract we want to deploy.
  const deployer = new Deployer(hre, wallet);
  const artifact = await deployer.loadArtifact("Greeter");

  // Deploy this contract. The returned object will be of a `Contract` type, similarly to ones in `ethers`.
  // `greeting` is an argument for contract constructor.
  const greeting = "Hi there!";
  const greeterContract = await deployer.deploy(artifact, [greeting]);
  console.log(greeterContract.interface.encodeDeploy([greeting]));

  // Show the contract info.
  const contractAddress = greeterContract.address;
  console.log(`${artifact.contractName} was deployed to ${contractAddress}`);

  // Call the deployed contract.
  const greetingFromContract = await greeterContract.greet();
  if (greetingFromContract == greeting) {
    console.log(`Contract greets us with ${greeting}!`);
  } else {
    console.error(`Contract said something unexpected: ${greetingFromContract}`);
  }

  // Edit the greeting of the contract
  const newGreeting = "Hey guys";
  const setNewGreetingHandle = await greeterContract.setGreeting(newGreeting);
  await setNewGreetingHandle.wait();

  const newGreetingFromContract = await greeterContract.greet();
  if (newGreetingFromContract == newGreeting) {
    console.log(`Contract greets us with ${newGreeting}!`);
  } else {
    console.error(`Contract said something unexpected: ${newGreetingFromContract}`);
  }
}
EOF

echo
echo -ne " 
$(printCyan	'		Закрытый ключ Metamask изменен!')"
echo
cd $HOME
mainmenu
}
#X-l1bra
createSmart(){
	echo
	cd $HOME
	sudo apt update && sudo apt upgrade -y && sudo apt install curl nano  -y
	curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
	sudo apt install -y nodejs
	mkdir $HOME/greeter-example && cd greeter-example
	apt install cmdtest -y
	npm init --y
	npm install --save-dev hardhat
	npm install -g npm@9.6.0
	npx hardhat
	mkdir $HOME/greeter-example/greeter && cd $HOME/greeter-example/greeter
	npm init -y
npm add -D typescript ts-node @types/node ethers@^5.7.2 zksync-web3 @ethersproject/hash @ethersproject/web hardhat @matterlabs/hardhat-zksync-solc @matterlabs/hardhat-zksync-deploy


cat << EOF  > $HOME/greeter-example/greeter/hardhat.config.ts
import "@matterlabs/hardhat-zksync-deploy";
import "@matterlabs/hardhat-zksync-solc";
module.exports = {
  zksolc: {
    version: "1.3.7",
    compilerSource: "binary",
    settings: {},
  },
  defaultNetwork: "zkMainnet",
  networks: {
    zkMainnet: {
      url: "https://mainnet.era.zksync.io", 
      ethNetwork: "https://eth.llamarpc.com", 
      zksync: true,
    },
  },
  solidity: {
    version: "0.8.19",
  },
};
EOF

mkdir $HOME/greeter-example/greeter/contracts && mkdir $HOME/greeter-example/greeter/deploy

cat << EOF  > $HOME/greeter-example/greeter/contracts/Greeter.sol
//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract Greeter {
    string private greeting;

    constructor(string memory _greeting) {
        greeting = _greeting;
    }

    function greet() public view returns (string memory) {
        return greeting;
    }

    function setGreeting(string memory _greeting) public {
        greeting = _greeting;
    }
}
EOF

npx hardhat compile

read -r -p "  Введите закрытый ключ Metamask: " VAR1

cat << EOF  > $HOME/greeter-example/greeter/deploy/deploy.ts
import { utils, Wallet } from "zksync-web3";
import * as ethers from "ethers";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { Deployer } from "@matterlabs/hardhat-zksync-deploy";

// An example of a deploy script that will deploy and call a simple contract.
export default async function (hre: HardhatRuntimeEnvironment) {
  console.log(`Running deploy script for the Greeter contract`);

  // Initialize the wallet.
  const wallet = new Wallet("$VAR1");

  // Create deployer object and load the artifact of the contract we want to deploy.
  const deployer = new Deployer(hre, wallet);
  const artifact = await deployer.loadArtifact("Greeter");

  // Deploy this contract. The returned object will be of a `Contract` type, similarly to ones in `ethers`.
  // `greeting` is an argument for contract constructor.
  const greeting = "Hi there!";
  const greeterContract = await deployer.deploy(artifact, [greeting]);
  console.log(greeterContract.interface.encodeDeploy([greeting]));

  // Show the contract info.
  const contractAddress = greeterContract.address;
  console.log(`${artifact.contractName} was deployed to ${contractAddress}`);

  // Call the deployed contract.
  const greetingFromContract = await greeterContract.greet();
  if (greetingFromContract == greeting) {
    console.log(`Contract greets us with ${greeting}!`);
  } else {
    console.error(`Contract said something unexpected: ${greetingFromContract}`);
  }

  // Edit the greeting of the contract
  const newGreeting = "Hey guys";
  const setNewGreetingHandle = await greeterContract.setGreeting(newGreeting);
  await setNewGreetingHandle.wait();

  const newGreetingFromContract = await greeterContract.greet();
  if (newGreetingFromContract == newGreeting) {
    console.log(`Contract greets us with ${newGreeting}!`);
  } else {
    console.error(`Contract said something unexpected: ${newGreetingFromContract}`);
  }
}
EOF
cd $HOME
echo
echo -ne "
$(printBCyan	'		Смартконтракт готов!')

$(printBCyan	'		Далее необходимо сделать деплой контракта!')
"

mainmenu
}

mainmenu