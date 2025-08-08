/*
/// Module: coin
*/
module coin::coin {
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use std::option;
    use sui::url::{Self, Url};

    /// The Workshop coin type
    public struct WORKSHOP has drop {}

    /// One-time witness for the module
    public struct COIN has drop {}

    /// Initialize the module
    fun init(witness: COIN, ctx: &mut TxContext) {
        // Create the Workshop coin with 1,000,000 supply
        let icon_url = option::some(url::new_unsafe_from_bytes(b"https://workshop.com/icon.png"));
        let (treasury_cap, metadata) = coin::create_currency(
            witness,
            9, // decimals
            b"WORKSHOP", // symbol
            b"Workshop Coin", // name
            b"Workshop Coin for educational purposes", // description
            icon_url, // icon url
            ctx
        );
        
        // Transfer the treasury cap to the sender
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
        
        // Share the metadata
        transfer::public_share_object(metadata);
    }

    /// Mint Workshop coins (requires TreasuryCap)
    public fun mint_workshop_coins(
        treasury_cap: &mut TreasuryCap<WORKSHOP>,
        amount: u64,
        ctx: &mut TxContext
    ): Coin<WORKSHOP> {
        coin::mint(treasury_cap, amount, ctx)
    }

    /// Burn Workshop coins (requires TreasuryCap)
    public fun burn_workshop_coins(
        treasury_cap: &mut TreasuryCap<WORKSHOP>,
        coin: Coin<WORKSHOP>
    ) {
        coin::burn(treasury_cap, coin);
    }

    /// Get the total supply of Workshop coins
    public fun total_supply(treasury_cap: &TreasuryCap<WORKSHOP>): u64 {
        coin::total_supply(treasury_cap)
    }

    /// Get the value of a Workshop coin
    public fun value(coin: &Coin<WORKSHOP>): u64 {
        coin::value(coin)
    }

    /// Split a Workshop coin into two coins
    public fun split(coin: &mut Coin<WORKSHOP>, amount: u64, ctx: &mut TxContext): Coin<WORKSHOP> {
        coin::split(coin, amount, ctx)
    }

    /// Join two Workshop coins
    public fun join(coin1: &mut Coin<WORKSHOP>, coin2: Coin<WORKSHOP>) {
        coin::join(coin1, coin2);
    }
}


