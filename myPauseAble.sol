pragma solidity ^0.6.7;

 contract myPauseAble {
     
     event paused(string);
     event unpaused(string);
     
     address public ownerA;
     bool private active;
     
     constructor() public {
         active = false;
         ownerA = msg.sender;
     }
     
     modifier whenNotPaused() {
         require(!active, "contract is paused");
         _;
     }
     
     modifier whenPaused() {
         require(active, "contract is not paused");
         _;
     }
     
     modifier onlyOwner() {
         require(ownerA == msg.sender, "only Owner can call this function");
         _;
     }
     function Paused() public whenNotPaused onlyOwner {
         active = true;
         emit paused("contract is successfully paused");
     }
     
     function notPaused() public whenPaused onlyOwner {
         active = false;
         emit unpaused("contract is successfully unpaused");
     }
 }
