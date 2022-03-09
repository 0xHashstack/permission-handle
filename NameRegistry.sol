pragma solidity >=0.8.0 <0.9.0;

/**
 * @title Contract Name Registry contract
 */
contract NameRegistry {
    
    /* Owner of the Contract Name Registry smart contract */
    address private ctOwner;

    // Mapping from contract name to its address 
    mapping(string => address) private nameRegistry;
    
    /**
     * @dev Emits when contract added/updated in Name Registry.
     */
    event ContractAddressAdded (
        string   _contractName,
        address  _contractAddr
    );
    
    /* @dev The ContractNameRegistry constructor sets the original `owner` of the contract */
    constructor() public {
        ctOwner = msg.sender;
    }
    
    /* @dev Throws if called by any account other than the owner.*/
    modifier onlyOwner() {
        require(msg.sender == ctOwner);
        _;
    }

    /**
     * @dev update/set the contract address
     * @param _contractName - contract name
     * @param _contractAddr - contract address
     */
    function setContractAddress(string memory _contractName, address _contractAddr) public onlyOwner returns (bool) {
        require(_contractAddr != address(0), "ERROR_ZERO_ADDRESS");
        nameRegistry[_contractName] = _contractAddr;
        emit ContractAddressAdded(_contractName, _contractAddr);
        return true;
    }
    
    /**
     * @dev Returns contract address based on contract name
     * @param _contractName - contract name
     */
    function getContractAddress(string memory _contractName) public view returns (address) {
        return nameRegistry[_contractName];
    }
}
