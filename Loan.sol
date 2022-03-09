// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./INameRegistry.sol";
// import "./Instance.sol";
import "./PermissionHandleValidatorLib.sol";

contract LoanExt is PermissionHandleValidatorLib {

    /* Entity name */
    string private entityName = "Loan";
    
    /* Owner of the AvatarInterceptor smart contract */
    address private ctOwner;
    
    /* @dev The Interceptor constructor sets the original 'owner' of the contract */
    constructor(address _nameRegistryAddr) public {
        require(_nameRegistryAddr != address(0), "Error Zero Address");
        ctOwner = msg.sender;
        nameRegistryAddr = _nameRegistryAddr;
        inr = INameRegistry(_nameRegistryAddr);
    }
    
    /* @dev Throws if called by any account other than the owner.*/
    modifier onlyOwner() {
        require(msg.sender == ctOwner);
        _;
    }

    struct LoanEntry {
        string loanMarket;
        string commitment;
        uint256 loanAmount;
        uint256 collateralMarket;
        uint256 collateralAmount;
    }
    
    mapping (string => LoanEntry) keyval;


	function loanRequest(
        string memory permissionHandle,
        string memory userId,
		string memory loanMarket,
		string memory commitment,
		uint256 loanAmount,
		uint256 collateralMarket,
		uint256 collateralAmount
	) public returns (bool) {
        callPermissionHandleValidator(permissionHandle, userId, "Loan", "loanRequest");
		
        keyval[loanMarket].loanMarket = loanMarket;
        keyval[loanMarket].commitment = commitment;
        keyval[loanMarket].loanAmount = loanAmount;
        keyval[loanMarket].collateralMarket = collateralMarket;
        keyval[loanMarket].collateralAmount = collateralAmount;

		return true;
	}
}