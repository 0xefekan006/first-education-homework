/*
/// Module: time_usage
*/
module time_usage::time_usage {
    use sui::clock::{Self, Clock};
    use sui::tx_context::{Self, TxContext};

    /// Compare function: compares two dates
    /// First date from TxContext -> epoch
    /// Second date from Clock object
    /// Returns true if epoch date is greater than clock date, false otherwise
    public fun compare(clock: &Clock, ctx: &TxContext): bool {
        let epoch_timestamp = tx_context::epoch(ctx);
        let clock_timestamp = clock::timestamp_ms(clock);
        
        // Convert epoch to milliseconds (assuming epoch is in seconds)
        let epoch_ms = epoch_timestamp * 1000;
        
        // Compare timestamps
        epoch_ms > clock_timestamp
    }

    /// Alternative compare function that returns more detailed comparison
    /// Returns: 0 if equal, 1 if epoch > clock, 2 if epoch < clock
    public fun compare_detailed(clock: &Clock, ctx: &TxContext): u8 {
        let epoch_timestamp = tx_context::epoch(ctx);
        let clock_timestamp = clock::timestamp_ms(clock);
        
        // Convert epoch to milliseconds
        let epoch_ms = epoch_timestamp * 1000;
        
        if (epoch_ms == clock_timestamp) {
            0
        } else if (epoch_ms > clock_timestamp) {
            1
        } else {
            2
        }
    }

    /// Get epoch timestamp from TxContext
    public fun get_epoch_timestamp(ctx: &TxContext): u64 {
        tx_context::epoch(ctx)
    }

    /// Get clock timestamp in milliseconds
    public fun get_clock_timestamp(clock: &Clock): u64 {
        clock::timestamp_ms(clock)
    }
}


