/*
/// Module: visibility
*/
module visibility::visibility {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    /// Example object to demonstrate visibility
    public struct VisibilityExample has key {
        id: UID,
        value: u64,
    }

    /// One-time witness for the module
    public struct VISIBILITY has drop {}

    /// Initialize the module
    fun init(_witness: VISIBILITY, ctx: &mut TxContext) {
        // Create and transfer an example object
        let example = VisibilityExample {
            id: object::new(ctx),
            value: 42,
        };
        
        transfer::transfer(example, tx_context::sender(ctx));
    }

    /// Private function - only accessible within this module
    fun private_function(): u64 {
        100
    }

    /// Public function - accessible from outside the module
    public fun public_function(): u64 {
        private_function() + 50
    }

    /// Entry function - can be called directly in transactions
    public entry fun entry_function(ctx: &mut TxContext) {
        let value = public_function();
        // Do something with the value
    }

    /// Another public function that uses private function
    public fun get_private_value(): u64 {
        private_function()
    }

    /// Public function that creates a new object
    public fun create_example(value: u64, ctx: &mut TxContext): VisibilityExample {
        VisibilityExample {
            id: object::new(ctx),
            value,
        }
    }

    /// Public function that updates the value
    public fun update_value(example: &mut VisibilityExample, new_value: u64) {
        example.value = new_value;
    }

    /// Public function that gets the value
    public fun get_value(example: &VisibilityExample): u64 {
        example.value
    }

    /// Private helper function
    fun internal_calculation(a: u64, b: u64): u64 {
        a * b + private_function()
    }

    /// Public function that uses internal calculation
    public fun complex_calculation(a: u64, b: u64): u64 {
        internal_calculation(a, b)
    }
}


