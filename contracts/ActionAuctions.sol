//Action auction contract organizing and running a single auction
pragma solidity ^0.4.24;

//import open zepellin, safemath, ownable
import "./safemath.sol";

contract ActionAuction{

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

  mapping(string => address) charities;

  address auctioneer;

  event AuctionCreated(uint auctionId, string title, address auctioneer);
  event BidPlaced(address auctionId, address bidder, uint amt);
  event AuctionEnded(string auctionId, address winner, uint amt);

  modifier onlyAuctioneer(uint AuctionId){
    if (auctioneer != msg.sender) throw;
        _;
  }

  modifier onlyLive(uint AuctionID){
    Auction a = auctions[auctionId];
    if (a.status != AuctionStatus.Active) {
      throw;
    }
    _;
  }

  function ActionAution() public {
    auctioneer = msg.sender;
    //add the charity to mapping of approved charities
    charities["amf"] =  0xD70AEeB15F5E934aCA7c626eA86bFc0ca5717C2A;
  }

  function createAuction(string _title, string _charity) returns (uint auctionId) {

        // Make sure that the charity is correct
        if (!charities[_charity].isValue()) {
            LogFailure("Charity not valid");
            throw;
        }

        auctionId = auctions.length++;
        Auction a = auctions[auctionId];

        a.auctioneer = msg.sender;
        a.charity = charities[_charity];
        a.title = _title;
        a.status = AuctionStatus.Active;
        a.numBids = 0;
        a.topBidder;
        a.topBid = 0;
        a.total = 0;

        AuctionCreated(auctionId, a.title, a.auctioneer);

        return auctionId;
    }

  function placeBid(uint _auctionId) payable onlyLive(_auctionId) returns (bool success) {
        Auction a = auctions[auctionId];
        address newId = msg.sender;
        uint amount = msg.value;

        if(a.numBids <= 16){
          a.total = SafeMath.add(a.newBid, 1);
          //update top bid and top id
          if(newBid > a.topBid){
            a.topBid = newBid;
            a.topId = newId;
            uint winnings = SafeMath.div(newBid, 2);
            a.uncollectedWinnings = SafeMath.add(a.uncollectedWinnings, winnings);
          }
        }
        //count bids
        a.numBids = SafeMath.add(a.numBids, 1);

        if(a.numBids >= 16){
          a.status = AuctionStatus.Inactive;
        }

        return true;
    }

  function getStatus(uint auctionId) public{
    return auctions[auctionId].status;
  }

  //sends payment to charity when winner collects
  function getWinnings(uint auctionId) public payable{
    Auction a = auctions[auctionId];
    //check auction is over
    if (a.status = AuctionStatus.Active) {
        LogFailure("Auction still running");
        throw;
    }

    //set uncollectedWinnings to 0 to prevent receiving winnings mult. times
    uint payout = a.uncollectedWinnings;
    a.uncollectedWinnings = 0;
    //send money to _charity
    a.charity.transfer(payout);
    //send money to _winner
    a.topBidder.transfer(payout);
  }

  //Doesn't allow ether randomly being sent to you
  function() {
    throw;
  }
}
