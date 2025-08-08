/*
/// Module: nft
*/
module nft::nft {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use std::string::{Self, String};

    /// NFT struct representing a non-fungible token
    public struct NFTToken has key, store {
        id: UID,
        name: String,
        description: String,
        image_url: String,
        owner: address,
    }

    /// One-time witness for the module
    public struct NFT has drop {}

    /// Initialize the module
    fun init(_witness: NFT, _ctx: &mut TxContext) {
        // Module initialization if needed
    }

    /// Mint a new NFT
    public fun mint_nft(
        name: vector<u8>,
        description: vector<u8>,
        image_url: vector<u8>,
        ctx: &mut TxContext
    ): NFTToken {
        let nft = NFTToken {
            id: object::new(ctx),
            name: string::utf8(name),
            description: string::utf8(description),
            image_url: string::utf8(image_url),
            owner: tx_context::sender(ctx),
        };
        
        nft
    }

    /// Get the name of the NFT
    public fun get_name(nft: &NFTToken): &String {
        &nft.name
    }

    /// Get the description of the NFT
    public fun get_description(nft: &NFTToken): &String {
        &nft.description
    }

    /// Get the image URL of the NFT
    public fun get_image_url(nft: &NFTToken): &String {
        &nft.image_url
    }

    /// Get the owner of the NFT
    public fun get_owner(nft: &NFTToken): address {
        nft.owner
    }

    /// Transfer NFT to another address
    public fun transfer_nft(mut nft: NFTToken, recipient: address) {
        nft.owner = recipient;
        transfer::transfer(nft, recipient);
    }
}


