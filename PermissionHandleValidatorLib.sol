pragma solidity >=0.8.0 <0.9.0;
import "./StringUtils.sol";
import "./PermissionHandleRegistryInstance.sol";

/**
 * @title Permission Handle Registry Lib
 */
contract PermissionHandleValidatorLib is PermissionHandleRegistryInstance, PermissionData {
    
    function callPermissionHandle(string memory permissionHandle) internal view returns(
        string memory permissionhandle, 
        string memory userId, 
        uint256 createdOn,
        uint256 validDuration,
        Permissions[] memory permissions,
        bool exists
        ){
        return getPHRInstance().retrievePermissionHandle(permissionHandle);
    }
    
    function callPermissionHandleValidator(string memory permissionHandle, string memory userId, string memory contractSupport, string memory contractMethods) internal view returns (string memory){
        (string memory permissionHandle, string memory userid, uint256 createdOn, uint256 validDuration, Permissions[] memory permissions, bool exists) = callPermissionHandle(permissionHandle);

        return validatePermissionHandle(userId, contractSupport, contractMethods, userid, createdOn, validDuration, permissions, exists);
    }
        
    function validatePermissionHandle(string memory userId, string memory _contractSupport, string memory _contractMethods, string memory userid, uint256 createdOn, uint256 validDuration, Permissions[] memory permissions, bool exists) internal view returns (string memory){
        
        require(exists == true, "Permission Handle does not exist");
        
        bool time = false;
        if ((createdOn + validDuration) < block.timestamp) {
            require(time == true, "Permission Handle Expired");
        } else {
            time = false;
        }
        
        bool User = false;
        if(StringUtils.equal(userid, userId)){
                User = true;
        }
        require(User == true, "UserId not valid");
        
        bool Contract = false;
        bool Methods = false;
        for(uint i=0; i < permissions.length; i++){
            if(StringUtils.equal(permissions[i].contractSupport, _contractSupport)){
                Contract = true;
                for(uint j=0; j < permissions[i].contractMethods.length; j ++){
                    if(StringUtils.equal(permissions[i].contractMethods[j], _contractMethods)){
                        Methods = true;
                    }
                }
            }
        }
        require(Contract == true, "Contract not supported");
        require(Methods == true, "Contract method not valid");
    }
}