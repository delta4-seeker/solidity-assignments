// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.18 ; 

contract Decommerce{

    address payable Admin ; 
    uint ProductCount = 1 ; 
    uint cancelCharge  = 20 ; 
    enum Status{
        Unseen , 
        Accepted,
        Delivered,
        Received
    }

    struct Product{
        uint price ; 
        string metadata ; 
    }
    mapping(uint => Product) public products ; 

    struct Order{
        Product product ; 
        uint quantity ; 
        Status status  ; 
        bool exist ; 
    }

   mapping(address => Order) Orders ; 

    constructor() {
        Admin = payable(msg.sender) ; 
    }

    modifier OnlyAdmin() {
        require( msg.sender == Admin);
        _;
    }


    function addProduct(uint price , string memory metadata) public OnlyAdmin {
        products[ProductCount] =  Product(price , metadata) ; 
        ProductCount += 1 ; 
    }

    function orderProduct(uint product_id , uint quantity) public payable{
        Product memory selected_product = products[product_id] ; 
        require(selected_product.price * quantity * 2 <= msg.value , "Amount is not equal to twice the total cost");
        Status _status ; 
        Orders[msg.sender] =  Order(selected_product , quantity , _status , true) ; 
    }

    function cancelOrder() public {
        Order memory order = Orders[msg.sender] ; 
        require(order.exist , "Order not found" );
        uint deposited_amount =  order.product.price * order.quantity * 2 ; 
        if(order.status == Status.Unseen){
            payable(msg.sender).transfer(deposited_amount) ; 
        }
        else{
            payable(msg.sender).transfer(deposited_amount * (1-cancelCharge/100)) ;
        }
    }

    function cancelAcceptance() public {
        Order memory order = Orders[msg.sender] ; 
        require(order.exist , "Order not found" );
        uint deposited_amount =  order.product.price * order.quantity ; 
        payable(Admin).transfer(deposited_amount * (1-cancelCharge/100)) ;
    }

    function acceptOrder(address customer)public payable OnlyAdmin{
        Order memory selected_order = Orders[customer] ; 
        require(selected_order.product.price*selected_order.quantity <= msg.value , "Amount is not equal to the total cost");
        Orders[customer].status = Status.Accepted ; 
    }

    //todo
    // admin sets the order to "sent for deivary state"
    // buyer can claim received item so both buyer and seller can received the item to get their staked eth back.

}