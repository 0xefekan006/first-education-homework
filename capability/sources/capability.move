/*
/// Module: capability
*/
module capability::capability {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use std::string::{Self, String};
    use std::vector;

    /// WorkshopCapability - permission to organize workshops and add actions
    public struct WorkshopCapability has key, store {
        id: UID,
        owner: address,
    }

    /// Workshop struct to store workshop information
    public struct Workshop has key, store {
        id: UID,
        name: String,
        lessons: vector<String>,
        owner: address,
    }

    /// One-time witness for the module
    public struct CAPABILITY has drop {}

    /// Initialize the module
    fun init(_witness: CAPABILITY, ctx: &mut TxContext) {
        // Create and transfer the WorkshopCapability to the sender
        let capability = WorkshopCapability {
            id: object::new(ctx),
            owner: tx_context::sender(ctx),
        };
        
        transfer::transfer(capability, tx_context::sender(ctx));
    }

    /// Create a new workshop (requires WorkshopCapability)
    public fun create_workshop(
        _capability: &WorkshopCapability,
        name: vector<u8>,
        ctx: &mut TxContext
    ): Workshop {
        Workshop {
            id: object::new(ctx),
            name: string::utf8(name),
            lessons: vector::empty(),
            owner: tx_context::sender(ctx),
        }
    }

    /// Add a lesson to a workshop (requires WorkshopCapability)
    public fun add_lesson(
        _capability: &WorkshopCapability,
        workshop: &mut Workshop,
        lesson_name: vector<u8>,
    ) {
        let lesson = string::utf8(lesson_name);
        vector::push_back(&mut workshop.lessons, lesson);
    }

    /// Get workshop name
    public fun get_workshop_name(workshop: &Workshop): &String {
        &workshop.name
    }

    /// Get workshop lessons
    public fun get_workshop_lessons(workshop: &Workshop): &vector<String> {
        &workshop.lessons
    }

    /// Get workshop owner
    public fun get_workshop_owner(workshop: &Workshop): address {
        workshop.owner
    }

    /// Get capability owner
    public fun get_capability_owner(capability: &WorkshopCapability): address {
        capability.owner
    }

    /// Check if address has workshop capability
    public fun has_workshop_capability(capability: &WorkshopCapability, addr: address): bool {
        capability.owner == addr
    }
}
