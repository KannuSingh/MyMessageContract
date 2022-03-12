const main = async () => {
  const myMessageContractFactory = await hre.ethers.getContractFactory(
    'MyMessageContract'
  );
  const myMessageContract = await myMessageContractFactory.deploy({
    value: hre.ethers.utils.parseEther('0.1'),
  });
  await myMessageContract.deployed();
  console.log('Contract address:', myMessageContract.address);

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
  const messageTxn = await myMessageContract.message('This is message #1');
  await messageTxn.wait();

  const messageTxn2 = await myMessageContract.message('This is message #2');
  await messageTxn2.wait();

  contractBalance = await hre.ethers.provider.getBalance(
    myMessageContract.address
  );
  console.log(
    'Contract balance:',
    hre.ethers.utils.formatEther(contractBalance)
  );

  let allMessages = await myMessageContract.getAllMessages();
  console.log(allMessages);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
