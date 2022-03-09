// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

/**
 * @title PermissionData for temporary permission handle.
 */
interface PermissionData {
    
  /**
   * @dev Struct that implements Temporary Permission Handle.
   */
    struct Permissions{
        string contractSupport; //name of the contract
        string[] contractMethods; //methods of the contract
    } 
}