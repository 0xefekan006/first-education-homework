/*
/// Module: testing
*/
module testing::testing {
    /// Sum function: adds two numbers
    public fun sum(a: u64, b: u64): u64 {
        a + b
    }

    /// Compare function: compares two numbers
    /// Returns 0 if equal, 1 if a > b, 2 if a < b
    public fun compare(a: u64, b: u64): u8 {
        if (a == b) {
            0
        } else if (a > b) {
            1
        } else {
            2
        }
    }

    #[test]
    fun test_sum() {
        // Test basic addition
        assert!(sum(5, 3) == 8, 0);
        assert!(sum(0, 0) == 0, 1);
        assert!(sum(100, 200) == 300, 2);
        assert!(sum(1, 1) == 2, 3);
        assert!(sum(999, 1) == 1000, 4);
    }

    #[test]
    fun test_compare() {
        // Test equal numbers
        assert!(compare(5, 5) == 0, 0);
        assert!(compare(0, 0) == 0, 1);
        assert!(compare(100, 100) == 0, 2);
        
        // Test a > b
        assert!(compare(10, 5) == 1, 3);
        assert!(compare(100, 50) == 1, 4);
        assert!(compare(1, 0) == 1, 5);
        
        // Test a < b
        assert!(compare(5, 10) == 2, 6);
        assert!(compare(50, 100) == 2, 7);
        assert!(compare(0, 1) == 2, 8);
    }

    #[test]
    fun test_edge_cases() {
        // Test with large numbers
        assert!(sum(18446744073709551615, 0) == 18446744073709551615, 0);
        assert!(compare(18446744073709551615, 18446744073709551614) == 1, 1);
        assert!(compare(18446744073709551614, 18446744073709551615) == 2, 2);
    }
}


