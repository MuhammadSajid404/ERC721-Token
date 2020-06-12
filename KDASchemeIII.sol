pragma solidity ^0.6.7;

import "./ERC721.sol";

  contract KDASchemeIII is ERC721 {
      
      //StateVariable
      bool acceptedRequest = false;
      bool propertySaleStatus = false;
      uint256 public tokenId;
      
      
      //Structs
      struct propertyInfo {
          uint256 _tokenId;
          string _propertyName;
          string _propertyLocation;
          uint256 _propertyNumber;
          uint256 _propeertyAskingValue;
          string _tokenURI;
          bool _sellStatus;
          bool _rentalIncome;
      }
      propertyInfo[] public PropertyInfo;
      
      struct buyerDetails {
          uint256 _tokenId;
          address _propertyOwner;
          address buyingRequester;
          uint256 offerValue;
          bool finalPayingOfferValue;
      }
      
      //Mappings
      mapping (uint256 => bool) private listPropertyForSale;
      mapping (uint256 => bool) private mappingForPropertySellStatus;
      mapping (address => mapping (uint256 => mapping (address => bool))) private mappingForBuyerDetails;
      mapping (uint256 => buyerDetails) public storeBuyerDetails;
      mapping (uint256 => address) private rejectedMapping;
      mapping (uint256 => bool) private acceptedRequests;
     
     
     //Events
        event propertyRegisteredSuccessfully(
        address registrarAddress,
        uint256 tokenId
        );
        
        event propertyAddedToSellList(
        address ownerAddress,
        uint256 propertyID,
        bool isAdded
        );
        
        event buyerRequest(
        address requesterAddress,
        uint256 requestAgainstTokenID,
        uint256 tokenIdPrice
        );
     
        event buyingRequestAccepted(
        address ownerToken,
        address requester,
        bool buyingPriceAccepted
        );
        
        event propertySoldDetails(
        address previousOwner,
        address newOwner,
        uint256 soldTokenId,
        uint256 soldPrice
        );
        
        
        event withDrawAmount(
        address from,
        address to,
        uint256 amount,
        bool SuccessfulTransfer
        );
        
     constructor() 
        ERC721("ShanBuilders", "SBRS")
        public
     {}
     
     // Functions
      function registerProperty
      (
      string memory propertyFileName,
      string memory propertyLocation,
      uint256 propertyNumber,
      uint256 propertyAskingValue,
      string memory tokenURI,
      bool sellStatus,
      bool rentalIncome
      ) 
      public
      whenNotPaused()
      returns(bool) 
      {
          
         require(msg.sender != address(0), "Please! Check back! Registeration should not be from zero address");
         require(propertyAskingValue > 0, "Asking value should must be greater than zero");
         require(sellStatus == false, "Sell status must be false on registeration");
         
         address origionalOwner = msg.sender;
         tokenId++;
         
         PropertyInfo.push(propertyInfo({
             _tokenId: tokenId,
             _propertyName: propertyFileName,
             _propertyLocation: propertyLocation,
             _propertyNumber: propertyNumber,
             _propeertyAskingValue: propertyAskingValue,
             _tokenURI: tokenURI,
             _sellStatus: sellStatus,
             _rentalIncome: rentalIncome
         }));

         
         _mint(origionalOwner, tokenId);
         _setTokenURI(tokenId, tokenURI);
         
         mappingForPropertySellStatus[tokenId] = false;
         emit propertyRegisteredSuccessfully(origionalOwner, tokenId);
         
         return true;
       }
     
      function propertyDetails(uint256 _tokenId) public view
      returns(
             uint256,
             string memory,
             string memory,
             uint256,
             uint256,
             string memory,
             bool,
             bool)
      {
              
              propertyInfo memory myDetails = PropertyInfo[_tokenId - 1];
              return (
                      myDetails._tokenId,
                      myDetails._propertyName,
                      myDetails._propertyLocation,
                      myDetails._propertyNumber,
                      myDetails._propeertyAskingValue,
                      myDetails._tokenURI,
                      myDetails._sellStatus,
                      myDetails._rentalIncome
                      );
       }
          
          
      function addPropertyToSaleList(uint256 tokenID) public
      onlyOwner()
      whenNotPaused()
      returns(bool) 
      {
         require(msg.sender != address(0), "Sorry! address should not be zero");
         require(_exists(tokenID), "Token is not valid, Please! enter a valid tokenID");
         require(_isApprovedOrOwner(msg.sender, tokenID), "Caller must be an owner or approval");
         
         propertySaleStatus = true;
         mappingForPropertySellStatus[tokenID] = propertySaleStatus;
         
         emit propertyAddedToSellList(msg.sender, tokenID, true);
         return propertySaleStatus;
       }
     
     
     function checkPropertySellStautus(uint256 tokenID) public view returns(bool) {
         return mappingForPropertySellStatus[tokenID];
     }
     
     
     function buyingRequest(
                            uint256 _tokenId, 
                            address propertyOwner,
                            uint256 tokenID,
                            uint256 _offerValue,
                            bool _finalPrize
           )
           public 
           whenNotPaused()
           returns(bool)
      {
           require(msg.sender != address(0), "caller query of zero address");
           require(_exists(tokenID), "Invalid propertyId, not registered");
           require(!_isApprovedOrOwner(msg.sender, tokenID), "caller cannot be approved, operator or owner itself");
           require(_offerValue > 0, "Invalid offer price");
           require(mappingForPropertySellStatus[tokenID] == true, "mentioned property not on sale");
           require(ownerOf(tokenID) == propertyOwner, "tokenID is not of the given address");
        
           _tokenId = tokenId;
        
        buyerDetails storage b = storeBuyerDetails[tokenID];
             b._tokenId = tokenID;
             b._propertyOwner = propertyOwner;
             b.buyingRequester = msg.sender;
             b.offerValue = _offerValue;
             b.finalPayingOfferValue = _finalPrize;
        
        mappingForBuyerDetails[propertyOwner][tokenID][msg.sender];
        emit buyerRequest(msg.sender, tokenID, _offerValue);
        
        return true;
     }
     
      function checkBuyerDetails(uint256 tokenID) public view 
      returns
             (uint256 _tokenId,
             address _propertyOwner,
             address buyingRequester,
             uint256 offerValue,
             bool finalPayingOfferValue)
      {
         buyerDetails storage b = storeBuyerDetails[tokenID];
         return (
                 b._tokenId,
                 b._propertyOwner,
                 b.buyingRequester,
                 b.offerValue,
                 b.finalPayingOfferValue);
     
       }
     
     
      function rejectOffer(uint256 tokenID) public onlyOwner() returns(string memory)
      {
         delete storeBuyerDetails[tokenID];
         rejectedMapping[tokenID];
         return "offer has been rejected";
       }
     
     function checkRejectedOffersAddresses(uint256 tokenID) public view
     returns
     (address)
      {
        return rejectedMapping[tokenID]; 
       }
     
     
     
      function offerAccepted(uint256 tokenID, address _buyingRequesterAddress) public 
      onlyOwner()
      returns
             (uint256 _tokenId,
             address _propertyOwner,
             address buyingRequester,
             uint256 offerValue,
             bool finalPayingOfferValue,
             string memory comments)
      {
         acceptedRequests[tokenID] = true;
         buyerDetails storage b = storeBuyerDetails[tokenID];
         
         emit buyingRequestAccepted(ownerOf(tokenID), _buyingRequesterAddress, true);
         return (
                 b._tokenId,
                 b._propertyOwner,
                 b.buyingRequester,
                 b.offerValue,
                 b.finalPayingOfferValue,
                 "offer has been accepted");
       }
     
     function checkAcceptedRequests(uint256 tokenID) public view
     returns
     (bool) 
      {
        
         return acceptedRequests[tokenID];
       }
     
     function buyProperty(uint256 tokenID, uint256 price) public payable
     whenNotPaused()
     returns (bool, string memory) 
     {
         require(msg.sender != address(0), "caller query of zero addre=ss");
         require(_exists(tokenID), "Invalid propertyId, not registered");
         require(checkPropertySellStautus(tokenID), "property is not on salw");
         
         address _owner = ownerOf(tokenID);
         address buyer = msg.sender;
         
         buyerDetails storage b = storeBuyerDetails[tokenID];
         require(acceptedRequests[tokenID] == true, "sorry you can not buy this property");
         require(buyer == b.buyingRequester, "caller must be the accepted buyer");
         require(price == b.offerValue, "price should be same");
         
         _transfer(_owner, buyer, tokenID);
         
         listPropertyForSale[tokenID] = false;
         delete storeBuyerDetails[tokenID];
         
         emit propertySoldDetails(_owner, msg.sender, tokenID, price);
         return (true, "Property Sold Successfully");
       }
     
      fallback() external payable {
        
       }
    
      receive() external payable {
      
        
       }
    
    //function to check contract balance and transfer balance from contract to EOA
      function checkContractBalance() public view onlyOwner()
      returns
      (uint256) 
      {
           
        require(msg.sender != address(0), "Address must be valid");
        
        return address(this).balance;
       }
       
       function withDraw(uint256 _amount) public onlyOwner() whenNotPaused() returns(bool) {
        require(_amount > 0, "B-Ex-P-Token: Amount must be valid");
        
        payable(ownerA).transfer(_amount);
        
        emit withDrawAmount(address(this), ownerA, _amount, true);
        return true;
    } 
     
    }
