//Action auction contract organizing and running a single auction
pragma solidity ^0.4.24;

//import open safemath
import "./safemath.sol";
import "./ownable.sol";

contract ActionAuctions is Ownable {
  using SafeMath for uint;

  enum AuctionStatus {Active, Inactive}

  struct Auction {
    address auctioneer;
    address charity;

    string title;
    AuctionStatus status;
    uint numBids;

    address topBidder;
    uint topBid;
    uint total;

    uint uncollectedWinnings;
  }

  Auction[] public auctions;          // All auctions

  //name of charity to eth address
  mapping(string => address) public charities;

  address auctioneer;

  event AuctionCreated(uint auctionId, string title, address auctioneer);
  event AuctionEnded(uint auctionId, address winner, uint amtWon, uint topBid);

  //Checks that sender is the auctioneer
  modifier onlyAuctioneer(uint AuctionId){
    Auction memory a = auctions[AuctionId];
    require(a.auctioneer == msg.sender);
        _;
  }

  //Checks that current auction is live
  modifier onlyLive(uint AuctionId){
    Auction memory a = auctions[AuctionId];
    require(a.status == AuctionStatus.Active);
    _;
  }

  //creates an action auction
  function ActionAuctions() public {
    auctioneer = msg.sender;
    //add the charity to mapping of approved charities
    charities["amf"] =  0xD70AEeB15F5E934aCA7c626eA86bFc0ca5717C2A;
  }

  //adds an auction to the list of auctions, and publishes it
  function createAuction(string _title, string _charity) public returns (uint auctionId) {
    // Make sure that the charity is correct
    require(charities[_charity] != 0, "Charity name is not valid");

    uint auctionId = auctions.length;

    Auction memory a = Auction(msg.sender, charities[_charity],
                        _title, AuctionStatus.Active, 0, charities[_charity], 0,
                         0, 0);

    auctions.push(a);

    emit AuctionCreated(auctionId, a.title, a.auctioneer);

    return auctionId;
  }

  //allows users to place bid
  function placeBid(uint _auctionId) payable onlyLive(_auctionId) public returns (bool success) {
    Auction memory a = auctions[_auctionId];
    address newBid = msg.sender;
    uint amount = msg.value;

    //update total, uncollected winnings
    a.total = SafeMath.add(a.total, amount);
    uint winnings = SafeMath.div(amount, 2);
    a.uncollectedWinnings = SafeMath.add(a.uncollectedWinnings, winnings);

    //update top bid and top id
    if(amount > a.topBid){
      a.topBid = amount;
      a.topBidder = newBid;
    }

    //count bids
    a.numBids = SafeMath.add(a.numBids, 1);

    return true;
  }

  // ends the auction
  function endAuction(uint _auctionId) public onlyLive(_auctionId) onlyAuctioneer(_auctionId) {
    Auction memory a = auctions[_auctionId];
    a.status = AuctionStatus.Inactive;
    emit AuctionEnded(_auctionId, a.topBidder, a.uncollectedWinnings, a.topBid);
  }

  //sends payment to charity when winner collects
  function retrieveWinnings(uint _auctionId) public payable{
    Auction memory a = auctions[_auctionId];
    //require auction is over
    require(a.status == AuctionStatus.Active, "Auction still live");

    //set uncollectedWinnings to 0 to prevent receiving winnings mult. times
    uint payout = a.uncollectedWinnings;
    a.uncollectedWinnings = 0;
    //send money to _charity
    a.charity.transfer(payout);
    //send money to _winner
    a.topBidder.transfer(payout);
  }

  ///Allows Action Auctions to remove a charity from the list
  ///of approved charities
  function removeCharity(string _charity) external onlyOwner{
    charities[_charity] = 0;
  }

  ///Allows Action Auctions to approve a charity
  function addCharity(string _charity, address _address) external onlyOwner{
    charities[_charity] = _address;
  }

  //Doesn't allow ether randomly being sent to you
  function() public {
    revert();
  }
}
