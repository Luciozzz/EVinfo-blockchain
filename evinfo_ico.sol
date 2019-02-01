// Building an  ICO

pragma solidity ^0.5.2;

contract evinfo_ico {
    
    // Max number of evinfo coins available for sale
    uint public max_evinfos = 1000000;
    
    // USD to evinfo coins conversion rate
    uint public usd_to_evinfos = 1000;
    
    // Total number of evinfo coins bought by investors
    uint public total_evinfos_bought = 0;
    
    // Equity mapped from the investor's address
    mapping(address => uint) equity_evinfos;
    mapping(address => uint) equity_usd;
    
    // Check if an investor can buy evinfo coins
    modifier can_buy(uint usd_invested) {
        require (usd_invested * usd_to_evinfos + total_evinfos_bought <= max_evinfos);
        _;
    }
    
    // Get equity in evinfo coins
    function get_equity_evinfos(address investor) external view returns (uint) {
        return equity_evinfos[investor];
    }
    
    // Get equity in USD
    function get_equity_usd(address investor) external view returns (uint) {
        return equity_usd[investor];
    }
    
    // Buy evinfo coins with USD
    function buy_evinfos(address investor, uint usd_invested) external can_buy(usd_invested) {
        equity_usd[investor] += usd_invested;
        equity_evinfos[investor] += usd_invested * usd_to_evinfos;
        total_evinfos_bought += usd_invested * usd_to_evinfos;
    }
    
    // Sell evinfo coins
    function sell_evinfos(address investor, uint evinfos_sold) external {
        equity_usd[investor] -= evinfos_sold / usd_to_evinfos;
        equity_evinfos[investor] -= evinfos_sold;
        total_evinfos_bought -= evinfos_sold;
    }
}