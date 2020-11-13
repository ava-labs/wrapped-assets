# WAVAX
<img src="https://raw.githubusercontent.com/ava-labs/wavax/main/imgs/logo.png?token=AA2FVIOQIL3646LYO54ZZP27XAVTO" width="100">

WAVAX or Wrapped Avax is an [ERC-20](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md) compatible wrapper contract around the Avax token.

On Avalanche's C-Chain, Avax is treated just like standard ETH is on Ethereum. This means that Avax lacks the standardized interfaces that make ERC-20 tokens so interchangeable. WAVAX corrects this by issuing one ERC-20 WAVAX token for each Avax deposited. Each WAVAX is then redeemable for an equal amount of Avax.

## Implementation
WAVAX is based on the implementation of Canonical WETH developed by the Ethereum community. Details are available [here](https://blog.0xproject.com/canonical-weth-a9aa7d0279dd) and original source code is available here: https://github.com/gnosis/canonical-weth.

The WAVAX implementation only changes the underlying contract to reflect the new token name of "Wrapped Avax" and the new symbol "WAVAX."

## Deployment
- Mainnet: [0xDCd29f325060F8e9F6c21671aDC74dabD0fD5Ff5](https://cchain.explorer.avax.network/address/0xDCd29f325060F8e9F6c21671aDC74dabD0fD5Ff5/transactions)
- Fuji: [0x1D308089a2D1Ced3f1Ce36B1FcaF815b07217be3](https://cchain.explorer.avax-test.network/address/0x1D308089a2D1Ced3f1Ce36B1FcaF815b07217be3/transactions)
