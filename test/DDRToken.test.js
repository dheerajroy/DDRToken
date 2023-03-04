const DDRToken = artifacts.require("DDRToken");

contract("DDRToken", accounts => {
  let token;

  beforeEach(async () => {
    token = await DDRToken.deployed();
  });

  it("should have a total supply of 10000000000000 tokens", async () => {
    const totalSupply = await token.totalSupply();
    assert.equal(totalSupply.toNumber(), 10000000000000, "Total supply should be 10000000000000");
  });

  it("should allocate the total supply to the deployer's account", async () => {
    const balance = await token.balanceOf(accounts[0]);
    assert.equal(balance.toNumber(), 10000000000000, "Balance should be 10000000000000}");
  });

  it("should transfer tokens from one account to another", async () => {
    const sender = accounts[0];
    const recipient = accounts[1];
    const transferAmount = 100;

    const initialSenderBalance = await token.balanceOf(sender);
    const initialRecipientBalance = await token.balanceOf(recipient);

    await token.transfer(recipient, transferAmount, {from: sender});

    const updatedSenderBalance = await token.balanceOf(sender);
    const updatedRecipientBalance = await token.balanceOf(recipient);

    assert.equal(
      updatedSenderBalance.toNumber(),
      initialSenderBalance.toNumber() - transferAmount,
      "Sender balance should be updated correctly"
    );
    assert.equal(
      updatedRecipientBalance.toNumber(),
      initialRecipientBalance.toNumber() + transferAmount,
      "Recipient balance should be updated correctly"
    );
  });
});
