// sources/move-tutorial/base_coin.move
module move_book_code::base_coin {
    struct Coin has key {
        value: u64,
    }

    public fun mint(account: signer, value: u64) {
        move_to(&account, Coin { value })
    }
}