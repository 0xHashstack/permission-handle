// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;
import "./Permissions.sol";

/**
 * @title Contract Permission Handle Registry contract
 */
contract TemporaryPermissionRegistry is PermissionData{
    
    address private ctOwner;

    /* @dev Throws if called by any account other than the owner.*/
    modifier onlyOwner() {
        require(msg.sender == ctOwner, "Sender should be Contract Creator");
        _;
    }
    
  /**
   * @dev Struct that implements Permission Handle Registry.
   */
    struct PermissionEntry {
        string permissionHandle;
        string userId;
        uint256 createdOn;
        uint256 validDuration;
        Permissions[] permissions;
        bool exists;
    }
    
    mapping (string => PermissionEntry) keyval;
    
  /**
   * @dev creates Permission Handle
   * @param permissionHandle - unique identifier of permission handle
   * @param userId - unique identifier of permission handle
   * @param createdOn - Created on timestamp
   * @param validDuration - valid duration of permission handle
   * @param permissions - Permissions (a tuple) for contractSupport and contractMethods
   */
    function tempPermissionHandle(
        string memory permissionHandle, 
        string memory userId, 
        uint256  createdOn, 
        uint256 validDuration, 
        Permissions[] memory permissions
        ) public returns(string memory) {
            require(keyval[permissionHandle].exists == false, "Permission Handle Already Exists");
            require(bytes (permissionHandle).length > 0, "Permission Handle Cannot be Blank");
            require(bytes (userId).length > 0, "userId Cannot be Blank");
            keyval[permissionHandle].permissionHandle = permissionHandle;
            keyval[permissionHandle].userId = userId;
            keyval[permissionHandle].createdOn = createdOn;
            keyval[permissionHandle].validDuration = validDuration;
            
            for (uint i=0; i< permissions.length; i++){
                keyval[permissionHandle].permissions.push(permissions[i]);
            }
            keyval[permissionHandle].exists = true;
    }
    
  /**
   * @dev Returns permission handle with identifier
   * @param permissionHandle - unique identifier of permission handle
   */
    function retrievePermissionHandle(string memory permissionHandle) public view returns (
        string memory permissionhandle, 
        string memory userId, 
        uint256 createdOn,
        uint256 validDuration,
        Permissions[] memory permissions,
        bool exists
        ){
        require(keyval[permissionHandle].exists == true, "Permission Handle Does Not Exist");
        return (
            permissionHandle, 
            keyval[permissionHandle].userId, 
            keyval[permissionHandle].createdOn, 
            keyval[permissionHandle].validDuration,
            keyval[permissionHandle].permissions,
            keyval[permissionHandle].exists
            );
    }
}

