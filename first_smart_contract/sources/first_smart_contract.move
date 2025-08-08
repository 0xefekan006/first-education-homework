/*
/// Module: first_smart_contract
*/
module first_smart_contract::first_smart_contract {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    /// A simple smart contract object
    public struct MyObject has key {
        id: UID,
        value: u64,
    }

    /// One-time witness for the module
    public struct FIRST_SMART_CONTRACT has drop {}

    /// Initialize the module
    fun init(_witness: FIRST_SMART_CONTRACT, ctx: &mut TxContext) {
        // Create the first object
        let my_object = MyObject {
            id: object::new(ctx),
            value: 42,
        };
        
        // Transfer the object to the sender
        transfer::transfer(my_object, tx_context::sender(ctx));
    }

    /// Get the value of the object
    public fun get_value(obj: &MyObject): u64 {
        obj.value
    }

    /// Set the value of the object
    public fun set_value(obj: &mut MyObject, new_value: u64) {
        obj.value = new_value;
    }
}


