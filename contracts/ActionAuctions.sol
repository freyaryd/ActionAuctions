//Action auction contract organizing and running a single auction
pragma solidity ^0.4.24;

//import open zepellin, safemath, ownable
import "./safemath.sol";

contract ActionAuction{

  address private topId;
  uint private topBid = 0;
  uint private total = 0;
  uint16 private numBids = 0;

  function ActionAution() public payable{

  }

//depending on how is payment works, either return the top bidder info and total
  function getPayment() private returns (address, uint){
    address newId;
    uint newBid;
    if(numBids <= 16){
      total = newBid.add(1);
      //update top bid and top id
      if(newBid > topBid){
        topBid = newBid;
        topId = newId;
      }
    }
    //count bids
    numBids = numsBids.add(1);
  }
}

//figure out how to send payments
function sendPayments(address _charity, address _winner, uint _amount) private payable{
  //calc payout
  uint payout = _amount / 2;
  //send money to _charity
  _charity.transfer(payout);
  //send money to _winner
  _winner.transfer(payout);
}
