pragma solidity ^0.7.0;

import "@balancer-labs/v2-vault/contracts/interfaces/IVault.sol";
import "../WeightedPool.sol";
import "./BasePoolSplitCodeFactory.sol";

contract OceanCustomPool is BasePoolSplitCodeFactory {

    address private oceanRouter; 

   constructor(IVault vault, address _oceanRouter) BasePoolSplitCodeFactory(vault,type(WeightedPool).creationCode) {
        oceanRouter = _oceanRouter;
        
        
    }


   
    function create(
        IVault vault,
        string memory name,
        string memory symbol,
        IERC20[] memory tokens,
        uint256[] memory weights,
        address[] memory assetManagers,
        uint256 swapFeePercentage,
        uint256 pauseWindowDuration, 
        uint256 bufferPeriodDuration, 
        address owner) external returns (address) {
        require(oceanRouter == msg.sender, 'NOT OCEAN ROUTER');

             address pool = address(
                new WeightedPool(
                    vault,
                    name,
                    symbol,
                    tokens,
                    weights,
                    assetManagers,
                    swapFeePercentage,
                    pauseWindowDuration,
                    bufferPeriodDuration,
                    owner
                )
            );

            return pool;
    }
}