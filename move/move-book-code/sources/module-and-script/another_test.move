module move_book_code::another_test {
    struct Example has copy, drop { a: address }

    public fun print() : Example {
        Example { a: @move_book_code }
    }
}