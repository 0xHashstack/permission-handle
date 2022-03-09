// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;
pragma experimental ABIEncoderV2;
import "./Permissions.sol";

interface ITemporaryPermissionRegistry is PermissionData{
    function tempPermissionHandle(
        string memory permissionHandle, 
        string memory userId, 
        uint256  createdOn, 
        uint256 validDuration,
        Permissions[] memory permissions
        ) external returns(string memory);
        
    function retrievePermissionHandle(string memory permissionHandle) external view returns (
        string memory permissionhandle, 
        string memory userId, 
        uint256 createdOn,
        uint256 validDuration,
        Permissions[] memory permissions,
        bool exists
        );
    
}