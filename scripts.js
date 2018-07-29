
if (typeof web3 !== 'undefined') {
     web3 = new Web3(web3.currentProvider);
 } else {
     // set the provider you want from Web3.providers
     web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
 }
 web3.eth.defaultAccount = web3.eth.accounts[0];

let json = 

 var CoursetroContract = web3.eth.contract(`[
   {
     "constant": true,
     "inputs": [
       {
         "name": "",
         "type": "uint256"
       }
     ],
     "name": "auctions",
     "outputs": [
       {
         "name": "auctioneer",
         "type": "address"
       },
       {
         "name": "charity",
         "type": "address"
       },
       {
         "name": "title",
         "type": "string"
       },
       {
         "name": "status",
         "type": "uint8"
       },
       {
         "name": "numBids",
         "type": "uint256"
       },
       {
         "name": "topBidder",
         "type": "address"
       },
       {
         "name": "topBid",
         "type": "uint256"
       },
       {
         "name": "total",
         "type": "uint256"
       },
       {
         "name": "uncollectedWinnings",
         "type": "uint256"
       }
     ],
     "payable": false,
     "stateMutability": "view",
     "type": "function"
   },
   {
     "payable": false,
     "stateMutability": "nonpayable",
     "type": "fallback"
   },
   {
     "anonymous": false,
     "inputs": [
       {
         "indexed": false,
         "name": "auctionId",
         "type": "uint256"
       },
       {
         "indexed": false,
         "name": "title",
         "type": "string"
       },
       {
         "indexed": false,
         "name": "auctioneer",
         "type": "address"
       }
     ],
     "name": "AuctionCreated",
     "type": "event"
   },
   {
     "anonymous": false,
     "inputs": [
       {
         "indexed": false,
         "name": "auctionId",
         "type": "uint256"
       },
       {
         "indexed": false,
         "name": "winner",
         "type": "address"
       },
       {
         "indexed": false,
         "name": "amtWon",
         "type": "uint256"
       },
       {
         "indexed": false,
         "name": "topBid",
         "type": "uint256"
       }
     ],
     "name": "AuctionEnded",
     "type": "event"
   },
   {
     "constant": false,
     "inputs": [],
     "name": "ActionAution",
     "outputs": [],
     "payable": false,
     "stateMutability": "nonpayable",
     "type": "function"
   },
   {
     "constant": false,
     "inputs": [
       {
         "name": "_title",
         "type": "string"
       },
       {
         "name": "_charity",
         "type": "string"
       }
     ],
     "name": "createAuction",
     "outputs": [
       {
         "name": "auctionId",
         "type": "uint256"
       }
     ],
     "payable": false,
     "stateMutability": "nonpayable",
     "type": "function"
   },
   {
     "constant": false,
     "inputs": [
       {
         "name": "_auctionId",
         "type": "uint256"
       }
     ],
     "name": "placeBid",
     "outputs": [
       {
         "name": "success",
         "type": "bool"
       }
     ],
     "payable": true,
     "stateMutability": "payable",
     "type": "function"
   },
   {
     "constant": false,
     "inputs": [
       {
         "name": "_auctionId",
         "type": "uint256"
       }
     ],
     "name": "endAuction",
     "outputs": [],
     "payable": false,
     "stateMutability": "nonpayable",
     "type": "function"
   },
   {
     "constant": false,
     "inputs": [
       {
         "name": "_auctionId",
         "type": "uint256"
       }
     ],
     "name": "retrieveWinnings",
     "outputs": [],
     "payable": true,
     "stateMutability": "payable",
     "type": "function"
   }
 ]`)
 console.log(CoursetroContract)
