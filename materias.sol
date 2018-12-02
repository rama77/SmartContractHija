pragma solidity ^0.4.23;

contract SmartContractHija {
	
	address owner;
    address hija;
    address mama;
    uint fondos;
    mapping (address => uint) pendingWithdrawals;
	
	constructor (address walletHija, address walletMama) public payable {
		owner = msg.sender;
        hija = walletHija;
        mama = walletMama;
        fondos = msg.value;
	}

	function juntarFondos () public payable {
        fondos += msg.value;
    }
    
    function  getFondos() public constant returns (uint) {
        return fondos;
    }

    function  finalizarContrato (bool aproboTodo) public {
        if(mama != msg.sender) {
		//	revert();
		//La red de ethereum agradece tu gas.
		} else {
            if (aproboTodo) {
                pendingWithdrawals[hija] = fondos;
            } else {
                pendingWithdrawals[owner] = fondos;
            }
            fondos = 0;
		}
    }
    function withdraw() public {
        uint amount = pendingWithdrawals[msg.sender];
        pendingWithdrawals[msg.sender] = 0;
        msg.sender.transfer(amount);
    }
}