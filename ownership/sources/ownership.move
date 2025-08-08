/*
/// Module: ownership
*/
module ownership::ownership {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    /// One-time witness for the module
    public struct OWNERSHIP has drop {}

    /// Example 1: Owned object - belongs to a specific address
    public struct OwnedObject has key {
        id: UID,
        value: u64,
    }

    /// Example 2: Shared object - can be accessed by anyone
    public struct SharedObject has key {
        id: UID,
        value: u64,
    }

    /// Example 3: Immutable object - cannot be modified after creation
    public struct ImmutableObject has key, store {
        id: UID,
        value: u64,
    }

    /// Example 4: Object with custom transfer logic
    public struct CustomOwnedObject has key, store {
        id: UID,
        value: u64,
        owner: address,
    }

    /// Initialize the module
    fun init(_witness: OWNERSHIP, ctx: &mut TxContext) {
        // Create a shared object
        let shared_obj = SharedObject {
            id: object::new(ctx),
            value: 100,
        };
        
        // Make it shared (accessible by anyone)
        transfer::share_object(shared_obj);
        
        // Create an immutable object
        let immutable_obj = ImmutableObject {
            id: object::new(ctx),
            value: 200,
        };
        
        // Make it immutable
        transfer::public_share_object(immutable_obj);
    }

    /// Create an owned object
    public fun create_owned_object(value: u64, ctx: &mut TxContext): OwnedObject {
        OwnedObject {
            id: object::new(ctx),
            value,
        }
    }

    /// Create a custom owned object
    public fun create_custom_owned_object(value: u64, ctx: &mut TxContext): CustomOwnedObject {
        CustomOwnedObject {
            id: object::new(ctx),
            value,
            owner: tx_context::sender(ctx),
        }
    }

    /// Get value from owned object
    public fun get_owned_value(obj: &OwnedObject): u64 {
        obj.value
    }

    /// Get value from shared object
    public fun get_shared_value(obj: &SharedObject): u64 {
        obj.value
    }

    /// Get value from immutable object
    public fun get_immutable_value(obj: &ImmutableObject): u64 {
        obj.value
    }

    /// Get value from custom owned object
    public fun get_custom_owned_value(obj: &CustomOwnedObject): u64 {
        obj.value
    }

    /// Update owned object value
    public fun update_owned_value(obj: &mut OwnedObject, new_value: u64) {
        obj.value = new_value;
    }

    /// Update shared object value
    public fun update_shared_value(obj: &mut SharedObject, new_value: u64) {
        obj.value = new_value;
    }

    /// Update custom owned object value (only by owner)
    public fun update_custom_owned_value(obj: &mut CustomOwnedObject, new_value: u64, ctx: &TxContext) {
        assert!(obj.owner == tx_context::sender(ctx), 0);
        obj.value = new_value;
    }

    /// Transfer custom owned object
    public fun transfer_custom_owned_object(mut obj: CustomOwnedObject, new_owner: address, ctx: &TxContext) {
        assert!(obj.owner == tx_context::sender(ctx), 0);
        obj.owner = new_owner;
        transfer::transfer(obj, new_owner);
    }
}


