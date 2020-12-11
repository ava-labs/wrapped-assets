# WAVAX
<img src="imgs/logo.png" width="100">

WAVAX or Wrapped Avax is an [ERC-20](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md) compatible wrapper contract around the Avax token.

On Avalanche's C-Chain, Avax is treated just like standard ETH is on Ethereum. This means that Avax lacks the standardized interfaces that make ERC-20 tokens so interchangeable. WAVAX corrects this by issuing one ERC-20 WAVAX token for each Avax deposited. Each WAVAX is then redeemable for an equal amount of Avax.

## Implementation
WAVAX is based on the implementation of Canonical WETH developed by the Ethereum community. Details are available [here](https://blog.0xproject.com/canonical-weth-a9aa7d0279dd) and original source code is available here: https://github.com/gnosis/canonical-weth.

The WAVAX implementation only changes the underlying contract to reflect the new token name of "Wrapped Avax" and the new symbol "WAVAX."

## Deployment
- Mainnet: [0x7Fc6D48E6e8e8B9505c171325539c651BF1D51d4](https://cchain.explorer.avax.network/address/0x7Fc6D48E6e8e8B9505c171325539c651BF1D51d4/transactions)
- Fuji: [0xd00ae08403B9bbb9124bB305C09058E32C39A48c](https://cchain.explorer.avax-test.network/address/0xd00ae08403B9bbb9124bB305C09058E32C39A48c/transactions)
