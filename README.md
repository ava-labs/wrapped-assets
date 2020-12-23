# WAVAX
<img src="imgs/logo.png" width="100">

WAVAX or Wrapped AVAX is an [ERC-20](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md) compatible wrapper contract around the AVAX token.

On Avalanche's C-Chain, AVAX is treated just like standard ETH is on Ethereum. This means that AVAX lacks the standardized interfaces that make ERC-20 tokens so interchangeable. WAVAX corrects this by issuing one ERC-20 WAVAX token for each AVAX deposited. Each WAVAX is then redeemable for an equal amount of AVAX.

## Implementation
WAVAX is based on the implementation of Canonical WETH developed by the Ethereum community. Details are available [here](https://blog.0xproject.com/canonical-weth-a9aa7d0279dd) and original source code is available here: https://github.com/gnosis/canonical-weth.

The WAVAX implementation only changes the underlying contract to reflect the new token name of "Wrapped AVAX" and the new symbol "WAVAX."

## Security
Because this contract is a fork of canonical WETH, it has the same security characteristics of the Gnosis WETH implementation. That contract has been in circulation for several years and has been thoroughly audited.

## Deployment
- Mainnet: [0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7](https://cchain.explorer.avax.network/address/0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7/transactions)
- Fuji: [0xd00ae08403B9bbb9124bB305C09058E32C39A48c](https://cchain.explorer.avax-test.network/address/0xd00ae08403B9bbb9124bB305C09058E32C39A48c/transactions)
