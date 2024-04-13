# ERC1155 Distribution Contract with Merkle Tree Verification

This project implements an ERC1155 distribution contract with qualification based on Merkle tree verification. Only verified addresses as part of the Merkle tree receive the token, and Merkle proofs are used for verification.

## Features

- ERC1155 standard compliant distribution contract.
- Qualification based on Merkle tree verification.
- Off-chain Merkle tree and verification using JavaScript.
- Support for distributing tokens to multiple addresses.

## Getting Started

To get started with this project, follow these steps:

1. Clone the repository:

```
git clone https://github.com/Signor1/ERC1155-Distribution-Merkle.git
```

2. Install dependencies:

```
cd your_repository
npm install
```

3. Compile the contracts:

```
forge build
```

4. Deploy the contracts:

```
forge create --rpc-url <your_rpc_url> --private-key <your_private_key> src/MyContract.sol:MyContract
```

5. Use the provided JavaScript scripts to generate Merkle tree data and verify addresses.

## Data Generation and Merkle Root Creation

I utilized a custom script to generate 500 Ethereum addresses along with corresponding amounts and token IDs. This data was then used to create a Merkle tree, from which the Merkle root was derived. The Merkle root is utilized for Merkle proof verification to qualify addresses for token distribution.

To replicate the process, follow these steps:

1. Run the script to generate the data:

```
ts-node scripts/generateData.ts
```

2. Use the generated data to create the Merkle root:

```
ts-node scripts/generateTree.ts
```

This will output the Merkle root hash, which is necessary for the verification process.


## Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
