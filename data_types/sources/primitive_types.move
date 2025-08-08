/*
/// Module: primitive_types
*/
module primitive_types::primitive_types {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use std::string::{Self, String};
    use std::vector;

    /// Person struct with name, age, is_coder, and lessons fields
    public struct Person has key, store {
        id: UID,
        name: String,
        age: u64,
        is_coder: bool,
        lessons: vector<String>,
    }

    /// One-time witness for the module
    public struct PRIMITIVE_TYPES has drop {}

    /// Initialize the module
    fun init(_witness: PRIMITIVE_TYPES, _ctx: &mut TxContext) {
        // Module initialization if needed
    }

    /// Create a new person using let keyword
    public fun create_person(
        name: vector<u8>,
        age: u64,
        is_coder: bool,
        ctx: &mut TxContext
    ): Person {
        // Using let keyword to assign values
        let person_name = string::utf8(name);
        let person_age = age;
        let person_is_coder = is_coder;
        let person_lessons = vector::empty<String>();
        
        Person {
            id: object::new(ctx),
            name: person_name,
            age: person_age,
            is_coder: person_is_coder,
            lessons: person_lessons,
        }
    }

    /// Add a lesson to a person
    public fun add_lesson(person: &mut Person, lesson: vector<u8>) {
        let lesson_name = string::utf8(lesson);
        vector::push_back(&mut person.lessons, lesson_name);
    }

    /// Get person's name
    public fun get_name(person: &Person): &String {
        &person.name
    }

    /// Get person's age
    public fun get_age(person: &Person): u64 {
        person.age
    }

    /// Get person's coder status
    public fun is_coder(person: &Person): bool {
        person.is_coder
    }

    /// Get person's lessons
    public fun get_lessons(person: &Person): &vector<String> {
        &person.lessons
    }

    /// Update person's age
    public fun update_age(person: &mut Person, new_age: u64) {
        person.age = new_age;
    }

    /// Update person's coder status
    public fun update_coder_status(person: &mut Person, new_status: bool) {
        person.is_coder = new_status;
    }

    /// Example function showing let keyword usage
    public fun demonstrate_let_usage(): u64 {
        let x = 10;
        let y = 20;
        let z = x + y;
        z
    }
}


