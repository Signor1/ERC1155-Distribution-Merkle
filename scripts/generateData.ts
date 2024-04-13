const { Wallet } = require("ethers");

function generateRandomAmount() {
  return Math.floor(Math.random() * 100000000000000000000);
}

function generateRandomTokenIds(count: number) {
  const tokenIds: number[] = [];

  while (tokenIds.length < count) {
    const tokenId = Math.floor(Math.random() * count) + 1;
    if (!tokenIds.includes(tokenId)) {
      tokenIds.push(tokenId);
    }
  }

  return tokenIds;
}

function generateAddresses(count: number) {
  const addresses = [];
  const tokenIds = generateRandomTokenIds(count);

  for (let i = 0; i < count; i++) {
    const wallet = Wallet.createRandom();
    const address = wallet.address;
    const amount = generateRandomAmount();
    const tokenId = tokenIds[i];

    addresses.push(`${address},${amount},${tokenId}`);
  }

  return addresses;
}

const addresses = generateAddresses(500);
console.log(addresses.join("\n"));
