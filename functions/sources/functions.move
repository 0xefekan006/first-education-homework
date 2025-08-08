/*
/// Module: functions
*/
module functions::functions {
    /// Sum function: takes 2 numbers and returns their sum
    public fun sum(a: u64, b: u64): u64 {
        a + b
    }

    /// Say hello function: returns a hello message
    public fun say_hello(): vector<u8> {
        b"Hello, World!"
    }

    /// Check function: checks if a number is odd or even
    /// Returns true if odd, false if even
    public fun check(number: u64): bool {
        number % 2 == 1
    }

    #[test]
    fun test_sum() {
        assert!(sum(5, 3) == 8, 0);
        assert!(sum(0, 0) == 0, 1);
        assert!(sum(100, 200) == 300, 2);
    }

    #[test]
    fun test_say_hello() {
        let message = say_hello();
        assert!(message == b"Hello, World!", 0);
    }

    #[test]
    fun test_check() {
        assert!(check(1) == true, 0);  // odd
        assert!(check(3) == true, 1);  // odd
        assert!(check(5) == true, 2);  // odd
        assert!(check(0) == false, 3); // even
        assert!(check(2) == false, 4); // even
        assert!(check(4) == false, 5); // even
    }
}

