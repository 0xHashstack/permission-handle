pragma solidity >=0.8.0 <0.9.0;
import "./ITemporaryPermissionRegistry.sol";
import "./INameRegistry.sol";

/**
 * @title Permission Handle Registry Instance contract
 */
contract PermissionHandleRegistryInstance {
    
    address public nameRegistryAddr;
    
    /* Name Registry instance */
    INameRegistry internal inr;
    
    /** 
     * @dev Returns Permission Handle instance
     */
    function getPHRInstance() internal view returns(ITemporaryPermissionRegistry) {
        return ITemporaryPermissionRegistry(inr.getContractAddress("TemporaryPermissionRegistry"));
    }
}
