const main = async () => {
  const myMessageContractFactory = await hre.ethers.getContractFactory(
    'MyMessageContract'
  );
  const myMessageContract = await myMessageContractFactory.deploy({
    value: hre.ethers.utils.parseEther('0.01'),
  });

  await myMessageContract.deployed();

  console.log('MyMessageContract address: ', myMessageContract.address);

  let contractBalance = await hre.ethers.provider.getBalance(
    myMessageContract.address
  );
  console.log(
    'Contract balance:',
    hre.ethers.utils.formatEther(contractBalance)
  );

  /*
   * Let's try two message now
   */
  const messageTxn = await myMessageContract.message(
    'This is message #1 from deployment script.'
  );
  await messageTxn.wait();
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
};

runMain();
