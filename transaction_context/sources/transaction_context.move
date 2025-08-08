/*
/// Module: transaction_context
*/
module transaction_context::transaction_context {
    use sui::tx_context::{Self, TxContext};

    /// Get milliseconds from TxContext
    /// Note: Sui's TxContext doesn't directly provide milliseconds
    /// This is a demonstration of how you might work with time in TxContext
    public fun get_milliseconds_from_context(ctx: &TxContext): u64 {
        // Get the epoch timestamp (in seconds) and convert to milliseconds
        let epoch_seconds = tx_context::epoch(ctx);
        epoch_seconds * 1000
    }

    /// Get epoch timestamp from TxContext
    public fun get_epoch_timestamp(ctx: &TxContext): u64 {
        tx_context::epoch(ctx)
    }

    /// Get sender address from TxContext
    public fun get_sender_address(ctx: &TxContext): address {
        tx_context::sender(ctx)
    }

    /// Get transaction hash from TxContext
    public fun get_tx_hash(ctx: &TxContext): &vector<u8> {
        tx_context::digest(ctx)
    }

    /// Get current epoch number
    public fun get_current_epoch(ctx: &TxContext): u64 {
        tx_context::epoch(ctx)
    }
}


