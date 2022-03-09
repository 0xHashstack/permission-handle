pragma solidity >=0.8.0 <0.9.0;

/**
 * @title NameRegistry contract interface.
 */
interface INameRegistry {
     function getContractAddress(string memory _contractName) external view returns (address);
}
