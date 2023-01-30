// sources/move-tutorial/step1/base_coin.move
module move_book_code::base_coin {
    struct Coin has key {
        value: u64,
    }
}