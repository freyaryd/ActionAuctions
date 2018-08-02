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
  }

  Auction[] public auctions;          // All auctions

  //name of charity to eth address
  mapping(string => address) public charities;

  address auctioneer;

  event AuctionCreated(uint auctionId, string title, address auctioneer);
  event AuctionEnded(uint auctionId, address winner, uint amtWon, uint topBid);
  event BidPlaced(uint numBids);

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
  constructor() public {
    auctioneer = msg.sender;
    //add the charity to mapping of approved charities
    charities["amf"] =  0xD70AEeB15F5E934aCA7c626eA86bFc0ca5717C2A;
  }

  //adds an auction to the list of auctions, and publishes it
  function createAuction(string _title, string _charity) external returns (uint) {
    // Make sure that the charity is correct
    require(charities[_charity] != 0, "Charity name is not valid");

    uint auctionId = auctions.length;

    Auction memory a = Auction(msg.sender, charities[_charity],
                        _title, AuctionStatus.Active, 0, charities[_charity], 0,
                         0);
    auctions.push(a);

    emit AuctionCreated(auctionId, a.title, a.auctioneer);

    return auctionId;
  }

  //allows users to place bid
  //questionable if you need to return anything...
  function placeBid(uint _auctionId) payable onlyLive(_auctionId) external {
    require(_auctionId < auctions.length, "Invalid Auction ID");

    Auction memory a = auctions[_auctionId];
    address newBid = msg.sender;
    uint amount = msg.value;

    //update total
    a.total = a.total.add(amount);

    //update top bid and top id
    if(amount > a.topBid){
      a.topBid = amount;
      a.topBidder = newBid;
    }

    //count bids
    a.numBids = a.numBids.add(1);
    emit BidPlaced(a.numBids);
  }

  // ends the auction
  function endAuction(uint _auctionId) external onlyLive(_auctionId) onlyAuctioneer(_auctionId) {
    Auction memory a = auctions[_auctionId];
    auctions[_auctionId].status = AuctionStatus.Inactive;
    //CHECK THIS
    //Currently, for odd totals money will be left over, but only 1 wei so who cares?
    a.topBidder.transfer(a.total.div(2));
    a.charity.transfer(a.total.div(2));
    emit AuctionEnded(_auctionId, a.topBidder, a.total.div(2), a.topBid);
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
