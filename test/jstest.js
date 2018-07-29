var ActionAuctions = artifacts.require("ActionAuctions")

contract('ActionAuctions', function(accounts){
  it("should start an auction", function(){
    return ActionAuctions.deployed().then(function(instance){
      console.log(instance.contract.address)
      return instance.contract.address;
    }).then(function(address){
      assert.equal(address, '0x74367da17b95b82820406fbc493d0529c268b6f8', "deployed address")
    })
  })
})
