// SPDX-License-Identifier: MIT
pragma  solidity ^0.8.0;

contract auction{

 address payable public benificary;
 
 uint public acutionEndTime;

 address public HighestBider;

 uint public HighestBid;

mapping (address => uint)public pendingResults;

bool ended=false;

event highestBidIncerases(address bidder,uint amount);


event AcutionEnded(address winner, uint amount);


constructor (uint _biddingTime,address payable _benificary){

    benificary=_benificary;

    acutionEndTime=block.timestamp + _biddingTime;

}



function bid()public payable{

    if(block.timestamp > acutionEndTime){
        revert("acution is closed now");
    }

    if (msg.value <= HighestBid){
        revert("there is already higher or equal bid");
    }


    if(HighestBid != 0){
        pendingResults[HighestBider] += HighestBid;
    }

    HighestBider=msg.sender;

    HighestBid=msg.value;

    emit highestBidIncerases(msg.sender,msg.value);

}



function withdraw()public returns(bool){
    uint amount= pendingResults[msg.sender];
   
    if (amount > 0){
        pendingResults[msg.sender]=0;

   
    if( ! payable (msg.sender).send(amount)){
        pendingResults[msg.sender]=amount;
        return false;

    }
    }
   
    return true;

}


function endtime() public{
   
    if(block.timestamp < acutionEndTime){
        revert(" the acution has not ended yet");
    }
   
    if(ended){
        revert("the function action ended has been alreasy caal");

    } 
   
    ended = true;
   
    emit AcutionEnded(HighestBider,HighestBid);
   
    benificary.transfer(HighestBid);

}


}